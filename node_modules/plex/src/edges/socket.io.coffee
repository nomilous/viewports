Base     = require './base'
ioClient = require 'socket.io-client'

#
# https://github.com/LearnBoost/socket.io/wiki/Exposed-events
#

module.exports = class SocketIo extends Base

    connect: (@context) -> 

        #console.log 'SocketIoEdge.connect() with:', @context

        unless @context.connect and @context.connect.uri
        
            throw 'SocketIoEdge requires connect.uri'


        @connection = ioClient.connect @context.connect.uri


        #
        # Override localId() to use the socket.io-client sessionid
        #

        @localId = -> @connection.socket.sessionid


        #
        # Assign Plex Edge(ness) to the connection
        #

        @assign @context, @connection

        return this
