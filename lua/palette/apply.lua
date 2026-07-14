-- Maps a palette (see palette/tomorrow_night.lua) onto highlight groups.
-- Palettes supply colors; this file decides where they go. Swapping the
-- palette restyles everything without touching this mapping.
--
-- Only divergences from nvim's default links are listed; everything else
-- falls back to the standard groups (Boolean -> Constant, @function ->
-- Function, etc.).
return function(p)
  vim.o.background = p.mode
  vim.cmd.highlight("clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.g.colors_name = p.name

  local function hl(group, spec)
    vim.api.nvim_set_hl(0, group, spec)
  end

  -- UI
  hl("Normal", { fg = p.foreground, bg = p.background })
  hl("LineNr", { fg = p.selection })
  hl("NonText", { fg = p.selection })
  hl("SpecialKey", { fg = p.selection })
  hl("Search", { fg = p.background, bg = p.yellow })
  hl("TabLine", { fg = p.foreground, bg = p.background, reverse = true })
  hl("StatusLine", { fg = p.window, bg = p.yellow, reverse = true })
  hl("StatusLineNC", { fg = p.window, bg = p.foreground, reverse = true })
  hl("VertSplit", { fg = p.window, bg = p.window })
  hl("Visual", { bg = p.selection })
  hl("Directory", { fg = p.blue })
  hl("ModeMsg", { fg = p.green })
  hl("MoreMsg", { fg = p.green })
  hl("Question", { fg = p.green })
  hl("WarningMsg", { fg = p.red })
  hl("MatchParen", { bg = p.selection, bold = true })
  hl("Folded", { fg = p.comment, bg = p.background })
  hl("FoldColumn", { bg = p.background })
  hl("CursorLine", { bg = p.line })
  hl("CursorColumn", { bg = p.line })
  hl("Pmenu", { fg = p.foreground, bg = p.selection })
  hl("PmenuSel", { fg = p.foreground, bg = p.selection, reverse = true })
  hl("SignColumn", { bg = p.background })
  hl("ColorColumn", { bg = p.line })

  -- Standard syntax
  hl("Comment", { fg = p.comment })
  hl("Todo", { fg = p.comment, bg = p.background, bold = true })
  hl("Title", { fg = p.comment, bold = true })
  hl("Identifier", { fg = p.red })
  hl("Statement", { fg = p.foreground, bold = true })
  hl("Conditional", { fg = p.foreground })
  hl("Repeat", { fg = p.foreground })
  hl("Structure", { fg = p.purple })
  hl("Function", { fg = p.blue })
  hl("Constant", { fg = p.orange })
  hl("String", { fg = p.green })
  hl("Special", { fg = p.foreground })
  hl("PreProc", { fg = p.purple })
  hl("Operator", { fg = p.aqua })
  hl("Type", { fg = p.blue })
  hl("Define", { fg = p.purple })
  hl("Include", { fg = p.blue })

  -- Ruby (legacy syntax groups)
  hl("rubyAttribute", { fg = p.blue })
  hl("rubyInclude", { fg = p.blue })
  hl("rubyStringDelimiter", { fg = p.green })
  hl("rubyInterpolationDelimiter", { fg = p.orange })
  hl("rubyRepeat", { fg = p.purple })
  hl("rubySymbol", { fg = p.royal })
  hl("rubyClass", { fg = p.orange })
  hl("rubyDefine", { fg = p.orange })
  hl("rubyConstant", { fg = p.red })
  hl("rubyInstanceVariable", { fg = p.aqua })
  hl("rubyFunction", { fg = p.yellow })
  hl("rubyConditional", { fg = p.orange })
  hl("rubyControl", { fg = p.orange })
  hl("rubyBlockParameter", { fg = p.foreground })
  hl("rubyLocalVariableOrMethod", { fg = p.foreground })
  hl("rubyRailsUserClass", { fg = p.red })
  hl("rubyRailsMethod", { fg = p.foreground })

  -- Diff
  hl("diffAdded", { fg = p.green })
  hl("diffRemoved", { fg = p.red })

  -- ShowMarks
  hl("ShowMarksHLl", { fg = p.orange, bg = p.background })
  hl("ShowMarksHLo", { fg = p.purple, bg = p.background })
  hl("ShowMarksHLu", { fg = p.yellow, bg = p.background })
  hl("ShowMarksHLm", { fg = p.aqua, bg = p.background })

  -- Treesitter captures (global; these style ruby too)
  hl("@variable", { fg = p.foreground })
  hl("@variable.parameter", { fg = p.foreground })
  hl("@variable.member", { fg = p.aqua })
  hl("@string.special.symbol", { fg = p.royal })
  hl("@punctuation.special", { fg = p.orange })
  hl("@tag", { fg = p.red })
  hl("@tag.attribute", { fg = p.red })
  hl("@tag.delimiter", { fg = p.red })

  -- Treesitter captures, ruby (mirrors the rubyXxx groups above)
  hl("@keyword.ruby", { fg = p.orange })
  hl("@keyword.function.ruby", { fg = p.orange })
  hl("@keyword.type.ruby", { fg = p.orange })
  hl("@keyword.conditional.ruby", { fg = p.orange })
  hl("@keyword.return.ruby", { fg = p.orange })
  hl("@keyword.exception.ruby", { fg = p.orange })
  hl("@keyword.repeat.ruby", { fg = p.purple })
  hl("@keyword.import.ruby", { fg = p.blue })
  hl("@constant.ruby", { fg = p.red })
  hl("@constant.builtin.ruby", { fg = p.orange })
  hl("@variable.builtin.ruby", { fg = p.orange })
  hl("@type.ruby", { fg = p.red })
  hl("@function.ruby", { fg = p.yellow })
  hl("@function.call.ruby", { fg = p.foreground })
  hl("@function.builtin.ruby", { fg = p.blue })
  hl("@function.builtin.rails", { fg = p.purple })
  hl("@variable.parameter.keyword", { fg = p.royal })
end
