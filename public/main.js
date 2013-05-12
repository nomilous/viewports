// Generated by CoffeeScript 1.4.0

requirejs.config({
  'packages': ['viewport']
});

requirejs(['/socket.io/socket.io.js', 'viewport'], function(io, Viewport) {
  return new Viewport({
    container: document.getElementById('viewport'),
    socket: io.connect(),
    group: 'viewport groupname'
  });
});
