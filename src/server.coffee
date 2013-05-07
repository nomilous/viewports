http           = require 'http'
assets         = require 'connect-assets'
express        = require 'express'
io             = require 'socket.io'
viewport       = require 'viewport'
shape          = require 'shape'

host           = 'localhost'
port           = 3000

module.exports = 

    start: (root) -> 

        app     = express()
        server  = http.createServer app
        sockets = io.listen server

        app.use express.logger 'dev'

        app.use viewport.scripts
        viewport.listen sockets

        app.use shape.scripts
        shape.listen sockets

        app.set 'views', root + '/views'
        app.set 'view engine', 'jade'
        app.use assets()

        app.get '/', (req, res) -> res.render 'index'

        server.listen port, host, -> 
            console.log 'http://%s:%s',
                server.address().address, 
                server.address().port