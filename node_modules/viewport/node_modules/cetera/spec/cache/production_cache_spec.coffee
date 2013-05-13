require('nez').realize 'ProductionCache', (ProductionCache, test, it, should) -> 

    it 'defines route()', (done) ->

        (new ProductionCache).route.should.be.an.instanceof Function
        test done

        