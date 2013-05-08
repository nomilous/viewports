#!/usr/bin/env coffee

plex = require '../lib/plex'

plex.start

    secret: 'SEEKRIT'

    onChange:
        localEdge: (context, edge) -> 

            console.log '\n\n\n\nLOCAL EDGE CHANGE:', 

                JSON.stringify context.tree.edges.local, null, 2

        remoteEdge: (context, edgeData) -> 

            console.log '\n\n\n\nREMOTE EDGE CHANGE:', 

                JSON.stringify context.tree.edges.remote, null, 2



    listen:
        adaptor: 'socket.io'
        port: 3000
        onListen: (adaptor) ->

            console.log "ROOT listening"
        
        onConnect: (edge) ->

            console.log "ROOT got connection with id = %s", edge.localId()


    protocol: (receive, send) ->

        receive 'greeting', (payload) -> send 'greeting:ack', 'hello you too'

        