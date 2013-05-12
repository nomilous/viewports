requirejs.config

    'packages': ['viewport']

requirejs ['/socket.io/socket.io.js', 'viewport'], (io, Viewport) -> 

    new Viewport

        container: document.getElementById 'viewport'
        socket: io.connect()
        group: 'viewport groupname'
