require('nez').realize 'Cetera', (Cetera, test, it, Package) -> 

    it 'exports package', (done) ->

        Cetera.package.should.equal Package
        test done
