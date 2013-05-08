should = require 'should'
Context = require '../lib/context'

describe 'Context', -> 

    it 'contains the runtime / support context for plex'

    it 'is an event emitter', (done) ->

        Context.prototype.on.should.equal require('events').EventEmitter.prototype.on
        done()

    it 'is extended with all config', (done) -> 

        config = thing: 'a'
        context = new Context config
        context.thing.should.equal 'a'
        done()

    it 'contains reference to the Tree', (done) -> 

        context = new Context
        context.tree.edges.should.eql
            local: {}
            remote: {}
        done()

    it 'contains reference to all connected edge INSTANCES', (done) -> 

        context = new Context
        context.edges.should.eql {}
        done()

    it 'defines globalId()', (done) -> 

        context = new Context
        context.globalId().should.equal "#{ (require 'os').hostname() }%#{ process.pid }"
        done()

    it 'allows a globalId() override', (done) -> 

        context = new Context
            globalId: -> 'something unique'

        context.globalId().should.equal 'something unique'
        done()
