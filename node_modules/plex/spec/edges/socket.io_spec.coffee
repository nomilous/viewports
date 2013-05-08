should       = require 'should'
SocketIoEdge = require '../../lib/edges/socket.io' 

describe 'SocketIoEdge', ->

    describe 'as assigned at the server side', -> 

        sent = undefined

        beforeEach (done) -> 

            context =
                move: 'proxy'
                globalId: -> 'GLOBAL_ID'

            mockSocket = 
                on: (event, payload) ->
                id: 'socket.io.id'

            @edge = (new SocketIoEdge).assign context, mockSocket

            done()


        it 'uses the connected socket.io id as localId()', (done) ->

            @edge.localId().should.equal 'socket.io.id'
            done()        


    describe 'as a connection to the server side', -> 

        server  = undefined
        port    = 3000

        before (done) ->

            @serversSocket = undefined
            @handshake = undefined

            server = require('socket.io').listen port

            server.on 'connection', (connected) =>
                console.log "CONNECTION"
                @serversSocket = connected

            server.on 'event:connect', (payload) =>
                @handshake = payload


            done()

        after ->


        it 'throws on missing connect.uri', (done) ->

            try
                edge = (new SocketIoEdge).connect
                    globalId: -> 'GLOBAL_ID'
                    connect:
                        adaptor: 'socket.io'


            catch error

                error.should.equal 'SocketIoEdge requires connect.uri'
                done()



        it 'calls back to onConnect if defined and sends the handshake', (done) ->

            itCalledHandshake = false

            SocketIoEdge.prototype.handshake = -> 
                itCalledHandshake = true

            context = new (require '../../lib/context') 
                mode: 'leaf'
                globalId: -> 'GLOBAL_ID'
                connect:
                    uri: 'http://localhost:3000'
                    onConnect: (edge) =>

                        itCalledHandshake.should.equal true

                        serverID = @serversSocket.id
                        clientID = edge.localId()
                        serverID.should.equal clientID

                        done()

            edge = (new SocketIoEdge).connect context
