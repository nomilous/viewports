path = require 'path'
fs   = require 'fs'

module.exports = class DevelopmentCache

    route: (conf) -> 

        app     = conf.app
        scripts = conf.scripts
        src     = conf.src
        name    = conf.name

        for script in scripts

            route = "/#{name}/#{script}"
            console.log 'create route GET %s', route

            app.get route, (req, res) -> 

                match = req.path.match new RegExp "^\/#{name}\/(.*)"
                file  = path.join src, match[1]

                res.header 'Content-Type': 'text/javascript'

                #
                # development reloads script from file with each GET 
                #

                fs.readFile file, (err, data) -> 

                    return res.send( data ) unless err
                    res.statusCode = 404
