import tc from 'teacup'

import ModalRegion from 'tbirds/regions/bsmodal'
import config from 'tbirds/app-config'
import MainPageLayout from 'tbirds/tklayout'

class Layout extends MainPageLayout
  template: tc.renderable () ->
    tc.div '#modal'
    tc.div ".container-fluid", ->
      tc.div '#navbar-view-container'
      tc.div '.row.fixed-bottom', ->
        tc.div '#messages'
      tc.div '#applet-content'
      tc.div '#footer'

  regions:
    messages: '#messages'
    navbar: '#navbar-view-container'
    modal: ModalRegion
    applet: '#applet-content'
    footer: '#footer'
  

config.layout = Layout
config.hasUser = false
config.brand.label = 'Cheat Sheet Demo'
config.brand.url = '#'

config.authToken = {}
config.authToken.refreshInterval = '5m'
config.authToken.refreshIntervalMultiple = 3
config.authToken.loginUrl = '#frontdoor/login'

config.appRegion = '#root-div'
export default config
