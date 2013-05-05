http           = require 'http'
express        = require 'express'
io             = require 'socket.io'
host           = 'localhost'
port           = 3000
viewport       = require 'viewport' 

module.exports = 

    start: (root) -> 

        app     = express()
        server  = http.createServer app
        sockets = io.listen server

        app.use express.logger 'dev'
        app.use viewport()

        app.set 'views', root + '/views'
        app.set 'view engine', 'jade'

        app.get '/', (req, res) -> res.render 'index'

        server.listen port, host, -> 
            console.log 'http://%s:%s',
                server.address().address, 
                server.address().port