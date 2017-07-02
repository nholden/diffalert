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
        if opts.missingTextContainer?
          itemValue = this.items[0]

          if itemValue?
            itemText = this.options[itemValue].text
            if itemText? && itemText != itemValue then opts.missingTextContainer.hide() else opts.missingTextContainer.show()
          else
            opts.missingTextContainer.hide()
      onInitialize: ->
        itemValue = this.items[0]

        # Prevents input element from creating a new blank line in
        # selectize-input div when initial item has a long name
        if itemValue?
          this.hideInput()

        if opts.missingTextContainer?
          if itemValue?
            itemText = this.options[itemValue].text
            if itemText? && itemText != itemValue then opts.missingTextContainer.hide() else opts.missingTextContainer.show()
          else
            opts.missingTextContainer.hide()
    )
