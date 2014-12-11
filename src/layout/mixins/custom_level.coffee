{changelog} = require '../changelog'
{make}      = require '../../render/make'

exports.custom_level = (level) ->
  make.columns 'custom_level', [
    { name: 'URL:' }
    {
      tag_name: 'input'
      name:     changelog.url
      init:     (world, element) ->
        $(element).on 'focus', -> $(this).select()
    }
    {
      tag_name: 'button'
      name:     'View Source'
      click:    ->
        $("<pre>#{changelog.pretty_source()}</pre>").dialog
          title:       'View Source'
          dialogClass: 'view_source'
          width:       400
          modal:       true
    }
  ],
  {
    name:   'Custom Level'
    hidden: -> !(level.get('level_edited') && !level.get('edit_mode'))
  }
