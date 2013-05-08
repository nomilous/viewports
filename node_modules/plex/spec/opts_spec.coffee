should = require 'should'
opts   = require('../lib/plex').opts

describe 'opts.validate()', -> 

    it 'throws if neither opts.listen or opts.connect is defined', (done) -> 

        try 
            opts.validate {}

        catch error
        
            error.should.match /plex requires opts.connect and\|or opts.listen/
            done()

    it 'throws if opts.listen.adaptor is undefined', (done) -> 

        try 
            opts.validate
                listen: {}

        catch error

            error.should.match /plex requires opts.listen.adaptor/
            done()
