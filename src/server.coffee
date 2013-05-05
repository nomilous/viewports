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

        app.use viewport()

        server.listen port, host, -> 

            console.log 'http://%s:%s',

                server.address().address, 
                server.address().port