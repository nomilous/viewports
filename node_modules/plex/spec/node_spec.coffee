should       = require 'should'
Node         = require '../lib/node'
Edge         = require '../lib/edge'
EventEmitter = require('events').EventEmitter

describe 'Node', -> 

    it 'is an EventEmitter', (done) ->

        Node.prototype.on.should.equal EventEmitter.prototype.on
        done()

    it 'defines start()', (done) -> 

        (new Node).start.should.be.an.instanceof Function
        done()

    it 'returns the running Context on start()', (done) -> 

        opts = mode: 'root'
        context = (new Node).start opts
        context.mode.should.equal 'root'
        done()


    it 'start() calls listen() if it should', (done) ->

        node = new Node
        node.listen = -> done()
        
        node.start 
            listen: 
                adaptor: 'base'



    it 'start() calls connect() if it should', (done) -> 

        node = new Node
        node.connect = -> done()

        node.start 
            connect: 
                adaptor: 'base'


    # it 'marks edges as disconnected', (done) ->

    #     edge = new Edge()
    #     Node.onConnect( edge )
    #     Node.onDisconnect( edge )
    #     timestamp = Node.edges.LOCAL_ID.disconnected.timestamp
        
    #     #
    #     # dunno why this behaves oddly.
    #     # 
    #     # timestamp.should.be.an.instanceOf Date

    #     timestamp.getHours().should.equal (new Date()).getHours()
    #     done()

    # it 'throws on unimplemented adaptor type', (done) -> 

    #     try 
    #         Node.start listen: adaptor: 'celtic lantern morse'

    #     catch error

    #         error.should.match /adaptor not implemented: celtic lantern morse/
    #         done()


    # it 'attaches reference to edges onto opts', (done) -> 

    #     opts = 
    #         listen: 
    #             adaptor: 'socket.io'
    #             port: 3006

    #     Node.listen opts
    #     opts.edges.should.not.be.undefined
    #     done()

    # it 'attaches reference to uplink onto opts', (done) -> 

    #     opts = 
    #         connect: 
    #             adaptor: 'socket.io'
    #             uri: 'http://localhost:3000'

    #     Node.connect opts
    #     opts.uplink.should.not.be.undefined
    #     done()
