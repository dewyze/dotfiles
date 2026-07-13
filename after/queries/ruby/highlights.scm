; extends

; Definition-site keyword parameters, colored like symbols/hash keys
; (call-site kwargs are already hash_key_symbol -> @string.special.symbol)
(keyword_parameter
  name: (identifier) @variable.parameter.keyword)

; Rails DSL / class macros, colored like attr_accessor and include
; (@function.builtin). Receiverless calls only, same pattern the stock
; query uses for include/extend. Extend the list as needed.
((call
  !receiver
  method: (identifier) @function.builtin.rails)
  (#any-of? @function.builtin.rails
    "has_many" "has_one" "belongs_to" "has_and_belongs_to_many"
    "validates" "validate" "scope" "default_scope" "enum" "delegate"
    "before_action" "after_action" "around_action" "skip_before_action"
    "before_validation" "after_validation" "before_save" "after_save"
    "before_create" "after_create" "before_destroy" "after_destroy"
    "after_commit" "after_initialize"
    "accepts_nested_attributes_for" "has_secure_password" "serialize"
    "rescue_from" "helper_method"))
