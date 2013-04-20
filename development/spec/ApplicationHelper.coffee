beforeEach ->
  @addMatchers {
    toBeObject: ->
      @actual isnt null and typeof(@actual) is 'object'

    toBeString: ->
      typeof @actual is 'string'

    toBeNumber: ->
      !isNaN(parseFloat(@actual)) and typeof @actual isnt 'string'

    toBeFunction: ->
      typeof @actual is 'function'

    toBeUnique: ->
      (@actual isnt null and @actual isnt undefined) and (@actual.length is undefined or @actual.length is 1)

    toExist: ->
      @actual isnt null

    toBeUndefined: ->
      @actual is undefined

    toBeVisible: ->
      @actual.offsetHeight isnt 0 and @actual.offsetWidth isnt 0

    toBeNull: ->
      @actual is null
  }
