Development = require './cache/development_cache'

module.exports = class Package

    mount: (conf = {}) ->

        unless conf.app and typeof conf.app.get == 'function'

            throw 'requires conf.app as express app instance'

        unless conf.name

            throw 'requires conf.name as package name'

        unless conf.src

            throw 'requires conf.src as path to package scripts'

        unless conf.scripts

            throw 'requires conf.scripts as list of paths relative to conf.src'

        env = process.env.NODE_ENV || process.env.ENV || 'development'

        if env == 'production'

            #cache = new Production
            cache = new Development
            cache.route conf

        else 

            cache = new Development
            cache.route conf

