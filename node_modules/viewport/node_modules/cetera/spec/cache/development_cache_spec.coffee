require('nez').realize 'DevelopmentCache', (DevelopmentCache, test, it, should) -> 

    it 'defines route()', (done) ->

        (new DevelopmentCache).route.should.be.an.instanceof Function
        test done

            
    it 'assigns routes for specified scripts if app defines get()', (done) -> 

        paths = []

        (new DevelopmentCache).route
            src: __dirname + '../lib'
            name: 'PACKAGENAME'
            scripts: [
                'directory/module.js'
                'main.js'
            ]
            app: get: (path, cb) -> 
                paths.push path

        paths[0].should.equal '/PACKAGENAME/directory/module.js'
        paths[1].should.equal '/PACKAGENAME/main.js'
        test done


