class window.TextInputToSelectize
  constructor: (input, opts) ->
    input.selectize(
      items: opts.items,
      options: opts.options,
      create: true,
      maxItems: 1,
    )
