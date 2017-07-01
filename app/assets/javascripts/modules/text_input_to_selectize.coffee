class window.TextInputToSelectize
  constructor: (input, opts) ->
    input.selectize(
      items: opts.items
      options: opts.options
      create: true
      maxItems: 1
      render: {
        item: (data, escape) ->
          label = if data.text? && data.text != data.value then " (#{data.text})" else ''
          "<div>#{escape(data.value + label)}</div>"
        option: (data, escape) ->
          label = if data.text? && data.text != data.value then data.text else ''
          "<div><div>#{escape(data.value)}</div><div class='option-label'>#{escape(label)}</div></div>"
      }
      onChange: ->
        if opts.missingTextContainer? then opts.missingTextContainer.find('input').val('')
      onBlur: ->
        if opts.missingTextContainer? && this.items[0]?
          itemValue = this.items[0]
          itemText = this.options[itemValue].text
          if itemText? && itemText != itemValue then opts.missingTextContainer.hide() else opts.missingTextContainer.show()
      onInitialize: ->
        if opts.missingTextContainer? && this.items[0]?
          itemValue = this.items[0]
          itemText = this.options[itemValue].text
          if itemText? && itemText != itemValue then opts.missingTextContainer.hide() else opts.missingTextContainer.show()
    )
