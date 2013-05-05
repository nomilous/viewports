http           = require 'http'
express        = require 'express'
io             = require 'socket.io'
host           = 'localhost'
port           = 3000

module.exports = 

    start: (root) -> 

        app     = express()
        server  = http.createServer app
        sockets = io.listen server



        server.listen port, host, -> 

            console.log 'http://%s:%s',

                server.address().address, 
                server.address().port