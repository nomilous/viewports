require('nez').realize 'Package', (Package, test, context, DevelopmentCache) -> 

    context 'mount()', (it) ->

        it 'requires conf.app as connect based app instance', (done) ->

            try
                (new Package).mount()
            catch error
                error.should.match /requires conf.app as express app instance/
                test done

        it 'requires a conf.name as package name', (done) -> 

            try
                (new Package).mount app: get: ->
            catch error
                error.should.match /requires conf.name as package name/
                test done

        it 'requires conf.src as path to package scripts', (done) -> 

            try
                (new Package).mount
                    app: get: ->
                    name: 'PACKAGENAME'
            catch error
                error.should.match /requires conf.src as path to package scripts/
                test done

        it 'defaults to development environment', (done) -> 

            DevelopmentCache.prototype.route = -> test done

            (new Package).mount
                src: __dirname + '../lib'
                name: 'PACKAGENAME'
                scripts: [
                    'directory/module.js'
                    'main.js'
                ]
                app: get: (path, cb) -> 