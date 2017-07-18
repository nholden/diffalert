class MatchDataFormPopulator
  constructor: ->
    $(document).on 'input', '[data-match-data-form-populator]', (e) => @populateFromInput(e.target)

  populateFromInput: (inputField) ->
    inputField = $(inputField)
    regexp = new RegExp(inputField.data('match-data-form-populator'))

    $('[data-match-data-field]').each (index, targetField) ->
      targetField = $(targetField)
      if matchData = regexp.exec(inputField.val())
        matchDataIndex = targetField.data('match-data-field')
        targetField.val(matchData[matchDataIndex])
        inputField.addClass('green-border')
      else
        targetField.val('')
        inputField.removeClass('green-border')

new MatchDataFormPopulator
