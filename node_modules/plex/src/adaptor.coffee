module.exports = 

    #
    # Loads and returns an instance of the Adaptor 
    # plugin specified in `opts.listen.adaptor`
    # 

    listen: ( context ) -> 

        klass = (require 'knax').load

            category: 'adaptor'
            class: context.listen.adaptor

        return new klass context
