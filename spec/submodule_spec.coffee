require('nez').realize 'Submodule', (Submodule, test, context) -> 

    context 'in CONTEXT', (does) ->

        does 'an EXPECTATION', (done) ->

            test done
