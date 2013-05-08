should   = require 'should'
adaptors = require '../lib/adaptor'

describe 'adaptors', -> 

    it '.listen() returns a listening adaptor', (done) -> 

        adaptors.listen(

            listen:
                adaptor: 'base'

        ).should.eql 

            context:
                listen: 
                    adaptor: 'base' 

        done()
