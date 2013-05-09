http           = require 'http'
path           = require 'path'
assets         = require 'connect-assets'
express        = require 'express'
rjsm           = require 'requirejs-middleware'
plex           = require 'plex'
viewport       = require 'viewport'
shape          = require 'shape'

host           = 'localhost'
port           = 3000

module.exports = 

    start: (root) -> 

        app     = express()
        server  = http.createServer app

        app.use express.logger 'dev'

        app.use rjsm
            src: path.join root, 'lib'
            dest: path.join root, 'public'
            build: false
            debug: true
            modules: 
                '/main.js': 
                    baseUrl: path.join root, 'lib'
                    include: 'main'
                    optimize: 'none'

        viewport.client path.join(root, 'public/viewport'), app
        # app.use shape.scripts

        # plex.start

        #     secret: 'SEEKRIT'

        #     listen: 
        #         server: server
        #         adaptor: 'socket.io'

        #     protocol: (When, Then, edge) -> 

        #         viewport.protocol When, Then, edge
        #         shape.protocol When, Then, edge
                

        app.set 'views', root + '/views'
        app.set 'view engine', 'jade'
        app.use express.static path.join root, 'public'
        app.use assets()

        app.get '/', (req, res) -> res.render 'index'

        server.listen port, host, -> 
            console.log 'http://%s:%s',
                server.address().address, 
                server.address().port