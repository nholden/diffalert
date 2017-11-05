class TextInputSelectizer
  constructor: ->
    $(document).on 'ready turbolinks:load', =>
      $('[data-selectize]').each((index, input) =>
        data = $(input).data('selectize')

        @selectizeInput(input, {
          items: data.items
          options: data.options
          missingTextContainer: $(data['missing-text-container-selector'])
        })
      )
    
  selectizeInput: (input, {items, options, missingTextContainer}) ->
    $(input).selectize(
      items: items
      options: options
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
        if missingTextContainer? then missingTextContainer.find('input').val('')
      onBlur: ->
        if missingTextContainer?
          itemValue = this.items[0]

          if itemValue?
            itemText = this.options[itemValue].text
            if itemText? && itemText != itemValue then missingTextContainer.hide() else missingTextContainer.show()
          else
            missingTextContainer.hide()
      onInitialize: ->
        itemValue = this.items[0]

        # Prevents input element from creating a new blank line in
        # selectize-input div when initial item has a long name
        if itemValue?
          this.hideInput()

        if missingTextContainer?
          if itemValue?
            itemText = this.options[itemValue].text
            if itemText? && itemText != itemValue then missingTextContainer.hide() else missingTextContainer.show()
          else
            missingTextContainer.hide()
    )

new TextInputSelectizer
