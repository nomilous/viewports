module.exports = 
    
    #
    # Loads and returns an instance of the Edge 
    # plugin specified in `opts.connect.adaptor`
    # 

    connect: ( context ) -> 

        klass = (require 'knax').load

            category: 'edge'
            class: context.connect.adaptor

        edge = new klass
        
        return edge.connect context
