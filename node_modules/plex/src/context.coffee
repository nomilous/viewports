#
# Context carries reference to all the necessary
# components for [Plex](plex.html) to function.
#
#
# `context.edges` A collection of all locally 
#                 attached Edge **instances**
#
# `context.tree` A reference to the [Tree](tree.html)
#
#

os = require 'os'

module.exports = class Context extends require('events').EventEmitter

    constructor: ( opts = {} ) -> 

        for property of opts

            #
            # All configured properties are loaded 
            # into the Context instance.
            #

            @[property] = opts[property]
    
        @tree = new (require './tree') this




        @edges = {}

    #
    # `context.globalId()` **provides a globally unique identity**
    # 
    # Facility to override can be placed among the config:
    # 
    # <pre>
    # plex.start 
    #   ..
    #   ..
    #   globalId: -> 'something unique'
    #   ..
    #   ..
    # </pre>
    # 
    # 
    # 

    globalId: -> 

        "#{ os.hostname() }%#{ process.pid }"





