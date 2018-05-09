fs = require 'fs'
emoji = require 'node-emoji'

getModuleName = (emojiName) ->
  char = emoji.get emojiName
  hex = char.charCodeAt(0).toString(16)
  if char.length == 2
    return "asturur-noto-emoji/svg/emoji_u#{hex}.svg"
  return false
  
AllEmojiNames = Object.keys emoji.emoji

icons = {}
AllEmojiNames.forEach (name) ->
  char = emoji.get name
  if char.length <= 2
    icons[name] = char
    
fs.writeFileSync 'icons.json', JSON.stringify icons
