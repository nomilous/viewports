os = require 'os'

#
# Baseclass for an Edge
# 

class Base
    
    #
    # An Edge has two methods of contruction
    # 
    # 1. For the case of an incoming connection via an Adaptor
    #    it should be initialized with the connection object.
    # 
    # 2. For the case establishing a connection to a remote
    #    Adaptor the context should contain the connection
    #    parameters in the context.connect property
    #

    constructor: ->


    validate: (context) ->

        throw 'undefined context' unless context

        unless context.connect and context.connect.adaptor
            
            throw 'edge requires connect.adaptor'


    #
    # `edge.assign()` **an existing connection**
    # 
    # This is used by adaptors to initialize this edge
    # with the an already established connection
    # 
    #

    assign: (@context, @connection) -> 

        subscribe = @getSubscriber()
        publish   = @getPublisher()

        subscribe 'connect', =>

            #
            # Received notification of a connection
            # being made.
            #

            @handshake()

            if @context.connect.onConnect instanceof Function

                @context.connect.onConnect this


        subscribe 'disconnect', =>

            #
            # Received notification of adjacent edge disconnecting
            #

            @context.tree.removeLocal this


        subscribe 'event:connect', (payload) => 

            #
            # Received notification of adjacent edge connecting
            # ie. handshake is revceived here.
            #

            @context.tree.insertLocal this, payload

            if @context.secret

                if payload.secret != @context.secret

                    @connection.disconnect()

                    #
                    # TODO: clean up rejected connection
                    #


        subscribe 'event:edge:connect', (payload) => 

            #
            # Received notification of remote edge
            # being inserted into the tree.
            # 

            @context.tree.insertRemote payload


        subscribe 'event:edge:disconnect', (payload) =>

            #
            # Received notification of remote edge
            # going offline.
            #

            @context.tree.removeRemote payload


        if @context.protocol 

            #
            # Callback for userdefined protocol configuration
            #

            @context.protocol subscribe, publish, this, @context


        return this


    #
    # `edge.handshake()` **sends event:connect to remote Adaptor**
    #

    handshake: -> 

        @getPublisher() 'event:connect',
            mode: @context.mode
            globalId: @context.globalId()
            secret: @context.secret


    #
    # `edge.getSubscriber()` **gets the event subscriber**
    #
    # This is an abstraction to enable Plex to define 
    # a uniform interface onto the wire, agnostic of the 
    # underlying transport implementation.
    # 
    # Implementation should override this.
    #

    getSubscriber: -> 

        return (event, callback) => 

            @connection.on.call @connection, event, callback

    #
    # `edge.getPublisher()` **gets the event publisher**
    # 
    # Abstaction onto the event sender.
    # 
    # Implementation should override this.
    # 

    getPublisher: -> 

        return (event, payload) => 

            console.log 'SENT %s - %s', event, JSON.stringify payload

            @connection.emit.call @connection, event, payload


    #
    # `edge.locaId()` **a locally unique id**
    # 
    # Implementation should override this
    #

    localId: -> 

        @connection.id


    #
    # `edge.connect()` **to a remote adaptor**
    # 
    # Implementation should override this
    #

    connect: (@context) ->

        @validate @context

        #
        # It pretends to connect to a remote Adaptor
        #

        true == true == true == true

        if @context.connect.mockConnection

            @connection = @context.connect.mockConnection
            @handshake()

        return this

    # #
    # # `edge.send()` **to send a message**
    # # 
    # # Implementation should override this.
    # # 

    # send: (event, payload) ->

    #     @connection.emit event, payload


module.exports = Base
