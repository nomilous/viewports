#
# Base class for an Adaptor
# 

class Base

    constructor: (@context) ->

        #console.log '\nBaseAdaptor() with:', @context

        @validate @context

        return @listen()


    validate: (context) ->     # , onConnect) -> 

        throw 'undefined context' unless context

        unless context.listen and context.listen.adaptor
            
            throw 'adaptor requires context.listen.adaptor'


    #
    # ### insertEdge() into the local context
    # 
    # This method should be used in Adaptor implementations
    #

    insertEdge: (edgeClass, connection) -> 

        edge = new edgeClass

        edge.assign @context, connection

        #
        # **TODO** The connecting edge may already be present,
        # depending on the implementation of localId() and 
        # whether or not it is a re-connect after-drop,
        #

        id = edge.localId()

        @context.edges[id] = edge

        # @context.uplink.send 'event:connect'
        #     mode: @context.mode
        #     globalId: @context.globalId()

        return edge


    listen: -> 

        #console.log '\nBaseAdaptor().listen()'

        #
        # It pretends to enter a listen loop
        #

        true == true == true == true 

        # 
        # It can be initialized with a mock connection/socket that will be
        # be used to generate a connecting edge.
        # 
        # eg. 
        # 
        # <pre>
        #  
        # new BaseAdaptor
        #   listen:
        #     mockConnection: [Object]
        # 
        #     see [spec/adaptors/base-adaptor.coffee](https://github.com/nomilous/plex/blob/master/spec/adaptors/base-adaptor_spec.coffee#L53)
        # 
        # </pre>
        # 

        if @context.listen.mockConnection

            @insertEdge (require '../edges/base'), @context.listen.mockConnection


module.exports = Base
