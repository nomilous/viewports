module.exports = opts = 

    #
    # **function** `opts.validate`
    #

    validate: (config) -> 

        #
        # config requires either or both of `connect` and `listen`
        # 
        # * if **only connect** then node mode becomes 'root'
        # * if **both** then node mode becomes 'proxy'
        # * if **only listen** then node mode becomes 'leaf'
        #

        unless config.listen or config.connect

            throw 'plex requires opts.connect and|or opts.listen'

        #
        # `connect` and `listen` must define the [Adaptor](adaptor.html) plugin
        # 
        # eg. 
        # 
        # <pre>
        # config = 
        #    listen:
        #       adaptor: 'socket.io'
        # </pre>
        #

        for edge in ['connect', 'listen']

            if config[edge]

                unless config[edge].adaptor

                    throw "plex requires opts.#{ edge }.adaptor"

