{changelog} = require '../changelog'
{make}      = require '../../render/make'
rx          = require 'reactive-coffee'

dialog_open = rx.cell(false)
dialog      = null

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
    _EXPORTS: ['save', 'edit']
    save:     (world) ->
      dialog = $(world.element).dialog
        width:    400
        title:    'Custom Level'
        position:
          my: 'right bottom'
          at: 'right bottom'
          of: $('.inspector')
      dialog_open.set true
    edit:    (world) ->
      return unless dialog_open.get()

      dialog.dialog 'destroy'
  }
