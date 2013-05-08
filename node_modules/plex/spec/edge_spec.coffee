should = require 'should'
edge   = require '../lib/edge'

describe 'edge', -> 

    it '.connect() returns a connected edge', (done) -> 

        edge.connect(

            connect:
                adaptor: 'base'

        ).should.eql 

            context:
                connect:
                    adaptor: 'base'

        done()
