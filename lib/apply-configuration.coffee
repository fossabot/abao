###*
# @file Stores command line arguments in configuration object
###

applyConfiguration = (config) ->

  coerceToArray = (value) ->
    if typeof value is 'string'
      value = [value]
    else if !value?
      value = []
    else if value instanceof Array
      value
    else value
    return value

  coerceToDict = (value) ->
    array = coerceToArray value
    dict = {}

    if array.length > 0
      for item in array
        [key, value] = item.split(':')
        dict[key] = value

    return dict

  configuration =
    ramlPath: null
    options:
      server: null
      schemas: null
      reporters: false
      reporter: null
      header: null
      names: false
      hookfiles: null
      grep: ''
      invert: false
      'hooks-only': false
      sorted: false

  # Normalize options and config
  for own key, value of config
    configuration[key] = value

  # Coerce some options into an dict
  configuration.options.header = coerceToDict(configuration.options.header)

  # TODO(quanlong): OAuth2 Bearer Token
  if configuration.options.oauth2Token?
    configuration.options.headers['Authorization'] = "Bearer #{configuration.options.oauth2Token}"

  return configuration


module.exports = applyConfiguration

