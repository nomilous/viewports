### Todo

* expand plugin to support 3rd party local override or installed module

* per adaptor/edge secrets

* context events

* Properly disconnect (clean up tree)
* Properly disconnect on failed secret

* Label each node ( name )
* Maintain Routing knowledge in tree (which node contains the 'label'd subnode)

* Tag each node (allow multiple tags per node)
* Maintain Routing knowledge (for broadcast to all with 'tag')

* modify proxy_reconnect / remote_edge_change to properly propagate nested changes that ocurred while the rootward link was severed such that new or departed leaves not known to the root become known (it makes sense to only propagate globalid/label/tags more than one tier rootward)

* third argument to protocol to enable interaction with node context within protocol handlers

* persisted messages for guaranteed delivery (to survive temporary link outages)
* `fifo` and `lifo` modes for outage recovery sync stream 

