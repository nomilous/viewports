plex
====

n-tier proxy tree for nodejs<br />

0.0.7 - high alpha - api changes/deprecations without warning. <br />


### Install

```bash
npm install plex --save
```


### Usage (basic)

```coffee

require('plex').start

    #
    # with this opts hash/literal
    #

    secret: 'SEEKRIT'

    connect:

        #
        # establish connection to parent proxy
        #

        adaptor: 'socket.io'
        uri: 'https://rootward.proxy:10001'

    listen:

        #
        # listen for children
        #

        adaptor: 'socket.io'

        port: 10002  
        # OR server: myHttpsServer


    #
    # define protocol
    #

    protocol: (subscribe, publish) -> 

        subscribe 'event:name', (payload) -> 

            publish 'event:name:ack', 'thank you :)'


```


### Usage (advanced)

```coffee

plex = require 'plex'

class MyNode extends plex.Node

    constructor: (args)

        #
        # constructor should assemble
        # the necessary @opts hash/literal
        #


context = plex.start new MyNode my: 'args'


```

