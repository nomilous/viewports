cetera
======

effortlessness, clientside, requirejs, package, modules

### version 0.0.1 (high alpha)


usage
-----

```coffee

Package = require('cetera').Package
package = new Package

app = express()

package.mount

    #
    # config.app as express app instance
    # 
    # - uses app.get() to define routes
    # 

    app: app

    #
    # config.name as name of package
    #
    # - results in script routes as /packagename/**/*.js
    # 

    name: 'packagename'

    #
    # config.src as source directory for scripts
    #

    src: __dirname + '/lib/client'

    #
    # scripts as array of scripts to serve
    # 

    scripts: [
      'main.js'
      'submodule1/main.js'          
      'submodule2/et.js'
      'submodule2/cetera.js'
    ]


```
