http           = require 'http'
assets         = require 'connect-assets'
express        = require 'express'
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

        app.use viewport.scripts
        app.use shape.scripts

        plex.start

            secret: 'SEEKRIT'

            listen: 
                server: server
                adaptor: 'socket.io'

            protocol: (When, Then) -> 

                shape.protocol When, Then


        app.set 'views', root + '/views'
        app.set 'view engine', 'jade'
        app.use assets()

        app.get '/', (req, res) -> res.render 'index'

        server.listen port, host, -> 
            console.log 'http://%s:%s',
                server.address().address, 
                server.address().port