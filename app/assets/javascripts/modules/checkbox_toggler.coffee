class CheckboxToggler
  constructor: ->
    $(document).on 'change', '[data-checkbox-toggler]', @toggle
    $(document).on 'ready turbolinks:load', @triggerToggles

  triggerToggles: ->
    $('[data-checkbox-toggler]').change()

  toggle: (e) ->
    togglerElement = $(e.target)
    togglerName = togglerElement.data('checkbox-toggler')

    if togglerElement.prop('checked')
      $("[data-hide-if-checked=#{togglerName}]").hide()
    else
      $("[data-hide-if-checked=#{togglerName}]").show()

new CheckboxToggler
