requirejs.config

    'packages': ['viewport']

requirejs ['viewport'], (Viewport) -> 

    try
    
        new Viewport

    catch error

        console.log error
