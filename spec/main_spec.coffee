require('nez').realize 'Main', (Main, test, context) -> 

    context 'in CONTEXT', (does) ->

        does 'an EXPECTATION', (done) ->

            test done
