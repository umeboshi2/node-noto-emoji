# (some) Google Noto Emojis for Webpack

## What is this?

This is a module to help include *some* 
[noto-emoji](https://github.com/googlei18n/noto-emoji) svg icons
selectively in a web application bundled with 
[webpack](https://webpack.js.org/).


## Install

```
npm install --save-dev node-noto-emoji
```

## Webpack Config

- Use [file-loader](https://github.com/webpack-contrib/file-loader) or
  [url-loader](https://github.com/webpack-contrib/url-loader) if you 
  prefer.
  
  
## Using node-noto-emoji

In your javascript, just

```javascript
beer = require("node-noto-emoji/dist/beer");

template = `<img src="${beer}">`
```
