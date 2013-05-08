should          = require 'should'
SocketIoAdaptor = require '../../lib/adaptors/socket.io'

describe 'SocketIoAdaptor', ->

    it 'throws if listen.port is undefined', (pass) ->

        try 
            adaptor = new SocketIoAdaptor
                listen:
                    adaptor: 'socket.io'

        catch error

            error.should.equal 'requires listen.port or listen.server'
            pass()

    it 'does not throw if listen.server is defined', (done) ->

        http = require('http')
            .createServer( (req, res) -> )
            .listen 3000 

        try 
            adaptor = new SocketIoAdaptor
                listen:
                    adaptor: 'socket.io'
                    server: http

        catch error
            error.should.not.equal error
            http.close()
            done()

        http.close()
        done()

    it 'uses listen.app', (pass) -> 

        http = require('http')
            .createServer( (req, res) -> )
            .listen 3000

        adaptor = new SocketIoAdaptor
            edges: {}
            listen: 
                adaptor: 'socket.io'
                server: http
                onConnect: (socket) ->

                    #
                    # the client connected... shutdown
                    # 
                    
                    http.close()
                    pass()

        #
        # connect the client
        #

        (require 'socket.io-client').connect "http://localhost:3000"


    it 'callsback to listen.onListen if defined', (pass) -> 

        new SocketIoAdaptor
                listen:
                    adaptor: 'socket.io'
                    port: 3000
                    onListen: (server) -> 
                        #console.log '\nSERVER: ', server
                        pass()


    it 'callsback to listen.onConnect if defined', (pass) ->

        sent = 'nothing yet'
        context = new (require '../../lib/context')
            # mock
            uplink: send: (e, p) -> sent = event: e, payload: p
            mode: 'leaf'
            listen:
                adaptor: 'socket.io'
                port: 3001
                onListen: (server) -> 

                    #
                    # its listening, connect a client to it
                    #

                    (require 'socket.io-client').connect "http://localhost:3001"

                onConnect: (socket) -> 

                    #console.log '\nCONTEXT: ', context
                    #console.log '\nHANDSHAKE:', sent
                    pass()

        new SocketIoAdaptor context
