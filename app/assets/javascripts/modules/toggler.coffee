class Toggler
  constructor: ->
    $(document).on 'change', '[data-toggler]', (e) => @toggle(e.target)
    $(document).on 'change', 'input[type=radio]', @triggerToggles
    $(document).on 'ready turbolinks:load', @triggerToggles

  triggerToggles: =>
    $('[data-toggler]').each (index, element) => @toggle(element)

  toggle: (element) ->
    togglerElement = $(element)
    togglerName = togglerElement.data('toggler')

    if togglerElement.prop('checked')
      $("[data-hide-if-checked=#{togglerName}]").hide()
    else
      $("[data-hide-if-checked=#{togglerName}]").show()

new Toggler
