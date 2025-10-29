(function_definition
  body: (compound_statement
    .
    "{"
    .
    (_) @_start @_end
    (_)? @_end
    .
    "}"
    (#make-range! "function.inner" @_start @_end))) @function.outer

(struct_specifier
  body: (field_declaration_list
    .
    "{"
    . (_) @_start @_end
    (_)? @_end
    .
    "}"
    (#make-range! "class.inner" @_start @_end))) @class.outer

(enum_specifier
  body: (enumerator_list
    .
    "{"
    . (_) @_start @_end
    (_)? @_end
    .
    "}"
    (#make-range! "class.inner" @_start @_end))) @class.outer

; conditionals
(if_statement
  consequence: (compound_statement
    .
    "{"
    .
    (_) @_start @_end
    (_)? @_end
    .
    "}"
    (#make-range! "conditional.inner" @_start @_end))) @conditional.outer

(if_statement
  alternative: (else_clause
    (compound_statement
      .
      "{"
      .
      (_) @_start @_end
      (_)? @_end
      .
      "}"
      (#make-range! "conditional.inner" @_start @_end)))) @conditional.outer

(if_statement) @conditional.outer

(if_statement
  condition: (_) @conditional.inner
  (#offset! @conditional.inner 0 1 0 -1))

(while_statement
  condition: (_) @conditional.inner
  (#offset! @conditional.inner 0 1 0 -1))

(do_statement
  condition: (_) @conditional.inner
  (#offset! @conditional.inner 0 1 0 -1))

(for_statement
  condition: (_) @conditional.inner)

; loops
(while_statement) @loop.outer

(while_statement
  body: (compound_statement
    .
    "{"
    .
    (_) @_start @_end
    (_)? @_end
    .
    "}"
    (#make-range! "loop.inner" @_start @_end))) @loop.outer

(for_statement) @loop.outer

(for_statement
  body: (compound_statement
    .
    "{"
    .
    (_) @_start @_end
    (_)? @_end
    .
    "}"
    (#make-range! "loop.inner" @_start @_end))) @loop.outer

(do_statement) @loop.outer

(do_statement
  body: (compound_statement
    .
    "{"
    .
    (_) @_start @_end
    (_)? @_end
    .
    "}"
    (#make-range! "loop.inner" @_start @_end))) @loop.outer

(compound_statement
  .
  "{"
  .
  (_) @_start @_end
  (_)? @_end
  .
  "}"
  (#make-range! "block.inner" @_start @_end)) @block.outer

(comment) @comment.outer

(call_expression
  arguments: (argument_list
    .
    "("
    .
    (_) @_start
    (_)* 
    (_) @_end
    .
    ")"
    (#make-range! "call.inner" @_start @_end))) @call.outer

(return_statement
  (_)? @return.inner) @return.outer

; Statements
;(expression_statement ;; this is what we actually want to capture in most cases (";" is missing) probably
;(_) @statement.inner) ;; the other statement like node type is declaration but declaration has a ";"
(compound_statement
  (_) @statement.outer)

(field_declaration_list
  (_) @statement.outer)

(preproc_if
  (_) @statement.outer)

(preproc_elif
  (_) @statement.outer)

(preproc_else
  (_) @statement.outer)

((parameter_list
  "," @_start
  .
  (parameter_declaration) @parameter.inner)
  (#make-range! "parameter.outer" @_start @parameter.inner))

((parameter_list
  .
  (parameter_declaration) @parameter.inner
  .
  ","? @_end)
  (#make-range! "parameter.outer" @parameter.inner @_end))

((argument_list
  "," @_start
  .
  (_) @parameter.inner)
  (#make-range! "parameter.outer" @_start @parameter.inner))

((argument_list
  .
  (_) @parameter.inner
  .
  ","? @_end)
  (#make-range! "parameter.outer" @parameter.inner @_end))

(number_literal) @number.inner

(declaration
  declarator: (init_declarator
    declarator: (_) @assignment.lhs
    value: (_) @assignment.rhs) @assignment.inner) @assignment.outer

(declaration
  type: (primitive_type)
  declarator: (_) @assignment.inner)

(expression_statement
  (assignment_expression
    left: (_) @assignment.lhs
    right: (_) @assignment.rhs) @assignment.inner) @assignment.outer
