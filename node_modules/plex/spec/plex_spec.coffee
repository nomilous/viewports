should = require 'should'
plex   = require '../lib/plex'

describe 'plex', ->

    describe 'start()', -> 

        it 'validates config', (wasCalled) ->

            swap = plex.opts.validate
            plex.opts.validate = (config) -> 
                plex.opts.validate = swap
                config.should.equal 'config'
                wasCalled()

            plex.start 'config'


        describe 'accepts an extended Node instance as arg1', ->

            before ->

                class @ExtendedNode extends plex.Node
                    config: -> 
                        connect: 
                            adaptor: 'UNDEFINED_ADAPTOR'


            it 'uses @ExtendedNode.config()', (done) ->

                try
                    
                    plex.start new @ExtendedNode

                catch error

                    error.should.match /\/edges\/UNDEFINED_ADAPTOR/
                    error.code.should.equal 'MODULE_NOT_FOUND'
                    done()




    describe 'determines mode from opts', ->

        it 'is root if only connect', (done) ->

            context = plex.start
                listen: 
                    adaptor: 'socket.io'
                    port: 12343

            context.mode.should.equal 'root'
            done()

        it 'is proxy if both connect and listen', (done) ->

            context = plex.start
                listen: 
                    adaptor: 'socket.io'
                    port: 12344
                connect: 
                    adaptor: 'socket.io'
                    uri: 'http://k'

            context.mode.should.equal 'proxy'
            done()

        it 'is leaf if only connect', (done) ->

            context = plex.start
                connect: 
                    adaptor: 'socket.io'
                    uri: 'http://k'

            context.mode.should.equal 'leaf'
            done()
