Backbone = require 'backbone'
Marionette = require 'backbone.marionette'
tc = require 'teacup'
PageableCollection = require 'backbone.paginator'
emoji = require 'node-emoji'

PaginateBar = require('tbirds/views/paginate-bar').default

#heart = require 'emojis/heart'
heart = require 'node-noto-emoji/dist/heart'

coffee = require 'emojis/coffee'


view_template = tc.renderable (model) ->
  tc.div '.row.listview-list-entry', ->
    #tc.h1 style:"display:inline", ->
    tc.h1 ->
      tc.text "Hello World!!"
      tc.img src:heart, width:"40"
      tc.img src:coffee, width:"40"
      
  tc.div '.paginate-bar'
  tc.div '.emoji-list'

window.emoji = emoji
allEmojiNames = []
Object.keys(emoji.emoji).forEach (key) ->
  c = emoji.emoji[key]
  if c.length <= 2
    allEmojiNames.push key
    

class Emoji extends Backbone.Model
  
class EmojiCollection extends PageableCollection
  model: Emoji
  mode: 'client'

models = []
allEmojiNames.forEach (name) ->
  data =
    id: name
    char: emoji.emoji[name]
  models.push data
  

collection = new EmojiCollection models
window.collection = collection

class EmojiImageView extends Marionette.View
  template: tc.renderable (model) ->
    console.log "SRC", model.src
    tc.img src:model.src, style:"height:2rem;width:2rem"
    
    

class ItemView extends Marionette.View
  className: 'listview-list-entry'
  template: tc.renderable (model) ->
    tc.span '.emoji-image'
    tc.span model.id
  ui:
    image: '.emoji-image'
  regions:
    image: '@ui.image'
  onRender: ->
    name = @model.id
    handler = `import(\`emojis\/${name}\`)` #noqa
    handler.then (src) =>
      view = new EmojiImageView
        model: new Backbone.Model {src:src.default}
      @showChildView 'image', view
      
class ItemCollectionView extends Marionette.CollectionView
  childView: ItemView
  className: 'row'

class MainView extends Marionette.View
  template: view_template
  options:
    listContainer: '.emoji-list'
  ui: ->
    header: '.listview-header'
    itemList: @getOption 'listContainer'
    paginateBar: '.paginate-bar'
  regions:
    paginateBar: '@ui.paginateBar'
    itemList: '@ui.itemList'
  onRender: ->
    view = new ItemCollectionView
      collection: collection
    @showChildView 'itemList', view
    pager = new PaginateBar
      collection: collection
      setKeyHandler: true
    @showChildView 'paginateBar', pager
  onBeforeDestroy: ->
    collection.off 'pageable:state:change'
    
#class MainView extends Marionette.View
#  template: view_template

module.exports = MainView

