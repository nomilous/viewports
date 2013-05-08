#!/usr/bin/env coffee

plex = require '../lib/plex'

plex.start

    secret: 'SEEKRIT'

    connect:

        #
        # establish connection to root
        #

        adaptor: 'socket.io'
        uri: 'http://localhost:3000'
        onConnect: (edge) -> 

            console.log "PROXY connected with id %s", edge.localId()


    listen:

        #
        # and listen for child nodes
        #

        adaptor: 'socket.io'
        port: 3001


    protocol: (receive, send) -> 

        console.log "configure protocol"

        receive 'connect', -> send 'greeting', 'hello'

        receive 'greeting:ack', (payload) -> 

            console.log "RECEIVED greeting:ack - %s", JSON.stringify payload
