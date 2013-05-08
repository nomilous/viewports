Node = require './node'
opts = require './opts'

plex = 

    #
    # **function** `plex.start` 
    #
    # * Starts the server
    #
    # *Usage*
    #
    # <pre>
    # plex = require 'plex'
    #
    # plex.start
    # 
    #    secret: 'SEEKRIT'
    # 
    #    connect:
    #       adaptor: 'socket.io'
    #       uri: 'http://rootward.proxy:3000'
    # 
    #    listen:
    #       # listen for leaves/childProxies
    #       adaptor: 'socket.io'
    #       port: 12340
    #    
    # </pre>
    #

    
    start: ( opts = {} ) -> 

        if typeof opts.config != 'undefined'

            node = opts
            opts = node.config()

        else

            node = new Node


        plex.opts.validate opts

        if opts.listen

            if opts.connect

                opts.mode = 'proxy'
        
            else

                opts.mode = 'root'


         if opts.connect and not opts.mode

            opts.mode = 'leaf'


        return node.start opts


    #
    # questionable as necessary?:
    supportedAdaptors: 'socket.io'


    #
    # **class** `plex.Node` 
    #
    # * Returns the [Node](node.html) class for extension
    # * Constructor should assemble [opts](opts.html) 
    #
    #
    # *Usage*
    #
    # <pre>
    # plex = require 'plex'
    #
    # class MyNode extends plex.Node
    #   
    #     constructor: (args) ->
    # 
    #         #
    #         # assemble @opts from args
    #         #
    #
    # node = new MyNode 'my', 'args'
    # context = plex.start node
    #
    # </pre>
    #
    # see [Context](context.html)
    # 

    Node: Node


    #
    # **literal** `plex.opts`
    # 
    # * Returns [opts](opts.html) object literal
    # 
    # 

    opts: opts



module.exports = plex