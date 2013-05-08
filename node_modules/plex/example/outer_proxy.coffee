#!/usr/bin/env coffee

plex = require '../lib/plex'

plex.start

    secret: 'SEEKRIT'
    
    connect:

        #
        # establish connection to inner_proxy
        #

        adaptor: 'socket.io'
        uri: 'http://localhost:3001'
        onConnect: (edge) -> 

            console.log "PROXY connected with id %s", edge.localId()


    listen:

        #
        # and listen for child nodes
        #

        adaptor: 'socket.io'
        port: 3002

    