should      = require 'should'
BaseAdaptor = require '../../lib/adaptors/base'
Context     = require '../../lib/context'

describe 'Adaptor', -> 


    it 'throws if context is undefined', (done) -> 

        try
            adaptor = new BaseAdaptor

        catch error

            error.should.match /undefined context/
            done()

    it 'throws if context.listen.adaptor is undefined', (done) -> 

        try
            new BaseAdaptor
                listen:
                    toMusic:
                        artist:    'Raimonds Tiguls'
                        album:     'Četri vēji'
                        track:     'Kū es biju sarēbusi'
                        seriously: 'its a masterpiece'

        catch error

            error.should.match /adaptor requires context\.listen\.adaptor/
            done()


    it 'listens', (done) ->

        #
        # temporarilly override listen()
        #

        itListenend = false

        previous = BaseAdaptor.prototype.listen

        BaseAdaptor.prototype.listen = -> itListenend = true

        adaptor = new BaseAdaptor 
            listen:
                adaptor: {}

        itListenend.should.equal true

        #
        # and fix it
        #

        BaseAdaptor.prototype.listen = previous

        done()


    it 'stores the connecting edge instance into context.edges', (done) -> 

        context = new Context
            # mock
            uplink: send: ->
            listen:
                adaptor: {}
                mockConnection:
                    id: 'THE_LOCAL_ID'
                    on: ->


        new BaseAdaptor context

        context.edges.THE_LOCAL_ID.should.not.be.undefined
                
        done()


    xit 'informs the Tree of the new Edge', (done) -> 

        #
        # Actually it does not
        #

        sent = 'not yet'

        context = new Context
            globalId: -> 'override'
            # mock
            uplink: send: (event, payload) -> sent = event: event, payload: payload
            listen:
                adaptor: {}
                mockConnection:
                    id: 'THE_LOCAL_ID'

        
        new BaseAdaptor context
        
        sent.should.eql 

            event: 'event:connect'
            payload: 
                mode: 'proxy'
                globalId: 'override'

        done()



