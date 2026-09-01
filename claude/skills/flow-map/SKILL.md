---
name: flow-map
description: Add or update a flow in the Flow Map static site — a visual trace of how a REST action moves through the skylight_cloud codebase (routes → auth → controller → models → jobs → serializer), with clickable ActiveRecord schema panels. Use when the user gives a path/CRUD operation and asks to trace it, add it to the flow map, or diagram a data flow.
---

The Flow Map is a zero-build static site at `dewyze/meals/` in the skylight_cloud
repo. It answers "what actually happens when this endpoint is hit" — like a
stacktrace, but only through app code, never Rails internals.

It is a personal learning tool in a gitignored folder. Optimise for insight per
line, not coverage. A flow that just restates the source is worthless; a flow
that surfaces the non-obvious is the whole point.

## Layout

```
dewyze/meals/
  index.html              # shell + one <script> tag per flow (must be updated by hand)
  assets/app.js           # rendering
  assets/styles.css
  data/_config.js         # repo/branch for GitHub links, sidebar group order
  data/models.js          # GENERATED — do not edit
  data/staleness.js       # GENERATED — do not edit
  data/flows/*.js         # one file per endpoint action — this is what you author
  data/swagger.js         # GENERATED — do not edit
  tools/dump_models.rb    # bin/rails runner dewyze/meals/tools/dump_models.rb
  tools/dump_swagger.rb   # ruby dewyze/meals/tools/dump_swagger.rb
  tools/check_staleness.rb# ruby dewyze/meals/tools/check_staleness.rb
  tools/lint_flows.js     # node dewyze/meals/tools/lint_flows.js
```

Open it by double-clicking `index.html` — it works over `file://` because all
data loads via `<script>` tags, never `fetch`. Never introduce a `fetch` call.

## Adding a flow

1. **Get the real route.** `bin/rails routes | grep -i <resource>`. Never infer
   a path from `config/routes.rb` nesting — prefixes are easy to get wrong.
2. **Trace the code yourself.** Read every file in the chain. Do not guess line
   numbers; open the file and look. Follow, in order: route → base controller
   filter chain → controller → any shared concern → param filtering → model
   (validations, callbacks, scopes) → service objects → jobs → serializer.
   Follow jobs into their `perform`, and services into their private methods.
   Stop only when control leaves app code (a gem, an external API, the DB).
3. **Check for a second entry point.** Most of this app's resources are served
   twice: `Api::X` (OAuth → `User`, frame from the URL) and `Hq::X` (device
   credentials → `Frame`, no `frame_id` segment), both including one
   `Shared::...Endpoints` concern. Both belong in `surfaces` on a single flow —
   do not create two flows.
4. **Write `data/flows/<resource>_<action>.js`.** Schema below.
5. **Register it** in `index.html` (one `<script>` tag) and add its group to
   `data/_config.js` `groups` if new.
6. **Stamp `authoredAt`** with the current short sha: `git rev-parse --short=8 HEAD`.
7. **Verify:**
   ```
   node dewyze/meals/tools/lint_flows.js       # syntax, refs, kinds, model chips
   ruby dewyze/meals/tools/check_staleness.rb  # refresh the staleness badge
   ```
   Fix everything the linter reports. It catches bad file paths, line numbers
   past EOF, unknown node kinds, and model names absent from `models.js`.

## Flow file schema

```js
FlowMap.flow({
  id: 'recipes-create',            // kebab, unique, used as the URL hash
  group: 'Meal recipes',           // sidebar section
  order: 3,                        // sort within the group
  title: 'Create a recipe',        // sidebar label — keep under ~40 chars
  verb: 'POST',                    // GET|POST|PATCH|PUT|DELETE|JOB
  path: '/api/frames/:frame_id/meals/recipes',
  authoredAt: '264a629a',          // short sha, for staleness detection
  summary: 'One or two sentences on what this does and why it is interesting.',

  params:    { permitted: '…', required: [...], optional: [...] },
  responses: [{ status: '200', body: '…' }, { status: '422', body: '…' }],
  specs:     [{ file: 'spec/requests/api/meals/recipes_spec.rb' }],

  surfaces: [{                     // one per entry point
    name: 'Mobile app / web',
    verb: 'POST', path: '/api/frames/:frame_id/meals/recipes',
    controller: 'Api::Meals::RecipesController#create',
    ref: { file: 'app/controllers/api/meals/recipes_controller.rb', line: 3 },
    auth: '**OAuth bearer token** → `User`, scope `write`.'
  }],

  steps: [ /* nodes, nested arbitrarily deep */ ]
});
```

### Node shape

```js
{
  kind: 'model',                   // see kinds below
  label: 'frame.meal_recipes.build(meal_recipe_params)',
  ref: { file: 'app/…', line: 23 },// becomes a GitHub link
  detail: 'Why this matters. The insight, not the restatement.',
  code: 'multi\nline\nsnippet',    // optional, rendered in a <pre>
  models: ['Meal::Recipe'],        // clickable chips → schema drawer
  jobs: ['SendPushNotification'],  // static chips
  flags: ['some-launchdarkly-flag'],
  external: ['OpenAI'],
  open: true,                      // force-expanded; default is depth 0 only
  children: [ /* more nodes */ ]
}
```

Top-level steps render expanded, everything deeper collapsed. That is the
intended reading experience — the spine at a glance, detail on demand. Only set
`open: true` on a node genuinely central to the flow.

### Node kinds

`auth` `route` `controller` `concern` `params` `serializer` `response` `model`
`db` `callback` `validation` `service` `job` `external` `flag` `branch` `note`
`gotcha`

Anything else renders grey and the linter flags it. `gotcha` is the highest-value
kind — use it for the things that would cost someone an afternoon.

### Text formatting

`label`, `detail`, `summary`, and `surfaces[].auth` support exactly three
tokens:

| Token      | Renders as        |
|------------|-------------------|
| `` `x` ``  | inline code       |
| `**x**`    | bold              |
| `~x~`      | dimmed text       |

**Never write raw HTML.** All text is HTML-escaped before these tokens are
applied, specifically so authored content can contain angle brackets like
`<ActiveModel::Errors>`. A `<span>` in the data renders as literal text.
Likewise write `&`, not `&amp;`.

## Model panels are generated — never hand-write schema

Columns, associations, callbacks, validations, indexes, enums and scopes all
come from real ActiveRecord reflection via `dump_models.rb`. If a model chip is
missing, rerun the dumper rather than describing the schema in prose:

```
bin/rails runner dewyze/meals/tools/dump_models.rb
```

It dumps every model with a table (~96), so any model can be referenced from any
flow. It also picks up inherited hooks that are invisible when reading a model
file alone — e.g. `around_destroy :track_destroyed` from `ApplicationRecord`.

Do not restate columns or associations in a node `detail`. Add a `models:` chip
and let the drawer do it. Node details are for behaviour and consequences.

## Swagger prose is wired in automatically

`dump_swagger.rb` extracts the hand-written prose from `swagger/v1/*.yaml` and the
site renders it without you doing anything:

- **On the flow** — a "Documented behaviour" card per surface: operation
  description, `oneOf` request-body variants with their own `required` lists,
  query params, response `meta`, and serialized attributes that have no column.
- **In the model drawer** — descriptions attached to columns, but only where the
  name really is a column on that model. Request-body prose becomes `stored:`,
  response prose becomes `serialized:`, and both show only when they differ (a
  serialized `summary` may come from the recipe; the column never does).

Two rules when writing a flow:

- **Don't hand-copy swagger text into a node `detail`.** It renders automatically
  and would go stale twice over. Cite it only when you are explaining a
  *disagreement* between the docs and the code.
- **Treat swagger as intent, not truth.** Per CLAUDE.md it is refreshed
  out-of-band, so it can lag the code. Where it disagrees, the code wins and the
  disagreement is worth a `gotcha` node.

`lint_flows.js` reports drift as informational findings (never failures):
undocumented flows, swagger operations no flow traces, unmapped JSON:API record
types, and required-param mismatches. If a flow's path is absent from swagger,
that is a finding, not something to "fix" by editing the path.

New record types need an entry in `data/_config.js` `recordTypes` mapping the
JSON:API type string to a model name — otherwise the linter flags it and the
column notes are silently skipped.

## What makes a flow worth reading

Aim for these; they are what the source does not tell you at a glance:

- **Where authorisation actually happens.** In this app it is usually scoping
  (`approved_frames.find(...)` → 404, not 403), not an explicit check.
- **Divergence between the two surfaces.** `frame_user` is nil on `hq/`; custom
  actions have no OAuth scope requirement; only `api/` has draft review.
- **Writes that are not what the verb implies.** Deleting one occurrence of a
  recurring sitting is an UPDATE to an `exdate` array.
- **Scopes with filters baked in.** `Meal::Sitting.in_range` silently excludes
  `draft: false`, which is why assistant drafts are invisible everywhere else.
- **Order-dependent code**, `update_all` bypassing validations, transactions and
  what they protect.
- **Blast radius.** Editing a recipe renames it on every past sitting.
- **Fan-out.** Jobs enqueued after render, cascading `dependent: :destroy`,
  external calls.
- **Naming traps.** `Meal::Category` is a meal slot; `Category` is a family
  member profile. Both appear on `Meal::Sitting`.

When the source has a comment explaining a non-obvious decision, quote or
paraphrase it in the `detail` and cite the line — that is exactly the context a
newcomer needs.

## Conventions

- One flow per endpoint action, not per resource and not per user story.
- Both `api/` and `hq/` entry points on one flow, via `surfaces`.
- `ref.file` is always repo-relative (`app/…`, `spec/…`, `config/…`).
- Verify line numbers by reading the file. The linter checks they are in range,
  not that they point at the right thing.
- Trivial actions (`show` when it is a two-line variant of `index`) are better
  as a `note` node on the sibling flow than a flow of their own.
- Never edit `models.js` or `staleness.js` by hand.
- Rerun `check_staleness.rb` after any flow change so the badge stays honest.
