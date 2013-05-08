Base         = require './base'
io           = require 'socket.io'
SocketIoEdge = require '../edges/socket.io'

#
# https://github.com/LearnBoost/socket.io/wiki/Exposed-events
#

module.exports = class SocketIo extends Base

    listen: -> 

        #
        # Can be initialized with either a port to listen
        # on or an app (eg. express)
        #
        # <pre>
        # 
        # express = require 'express'
        # app = express()
        # server = app.listen 3000
        #  
        # plex.start
        #   ..
        #   ..
        #   listen:
        #     adaptor: 'socket.io'
        #     server: server
        #   ..
        #   ..
        # </pre>
        # 
        # 

        #console.log '\nSocketIoAdaptor() with:', @context

        unless @context.listen

            throw 'requires listen config'

        unless @context.listen.port or @context.listen.server

            throw 'requires listen.port or listen.server'

        if @context.listen.port

            @server = io.listen @context.listen.port, =>

                if @context.listen.onListen
                
                    @context.listen.onListen this

        if @context.listen.server

            @server = io.listen @context.listen.server, =>

                if @context.listen.onListen
                
                    @context.listen.onListen this


        @server.on 'connection', (socket) => 

            edge = @insertEdge SocketIoEdge, socket

            if @context.listen.onConnect
            
                @context.listen.onConnect edge
