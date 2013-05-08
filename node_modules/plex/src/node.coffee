#
# Node is the baseclass that represents the
# running [Plex](plex.html) instance.
#

module.exports = class Node extends require('./context')

    constructor: -> 

    #
    # `node.start()` **a new instance running**
    # 
    # This returns the running [Context](context.html)
    #

    start: ( opts = {} ) -> 

        context = new (require './context') opts


        # 
        # **To configure the node to listen**
        # 
        # <pre>
        # context = node.start
        #   listen: 
        #     adaptor: 'name'
        #        # 
        #        # see  ./adaptors/*-adaptor
        #        # 
        # </pre>
        # 

        context.adaptor = @listen context if opts.listen


        #
        # **To configure the node to connect**
        # 
        # <pre>
        # node.start 
        #   connect: 
        #     adaptor: 'name'
        #        #
        #        # see  ./edges/*-edge
        #        # 
        # </pre>

        context.uplink = @connect context if opts.connect



        return context


    #
    # **listen() using opts.listen.adaptor**
    # 
    # * Starts a listening Adaptor that multiple edges
    #   may attach to
    #
    # * Return the listening Adaptor
    # 

    listen: ( context ) -> 

        #console.log '\nNode().listen()'

        return ( require './adaptor' ).listen context


    #
    # **connect() using opts.connect.adaptor**
    #
    # * Connects the edge to some remote Adaptor
    # 
    # * Sends a Handshake message
    # 
    # * Returns the connected edge
    # 

    connect: ( context ) -> 

        #console.log 'Node().connect()'

        return ( require './edge' ).connect context


module.exports = Node

