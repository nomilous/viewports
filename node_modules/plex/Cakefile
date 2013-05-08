child_process = require 'child_process'
hound = require 'hound'

docs = (after) ->
    opts = ['src/*.coffee']
    docco = child_process.spawn './node_modules/.bin/docco', opts
    docco.stdout.pipe process.stdout
    docco.stderr.pipe process.stderr
    after()


build = (after) ->
    coffeeOpts = ['-c', '-b', '-o', "lib", "src"]
    coffee = child_process.spawn './node_modules/.bin/coffee', coffeeOpts

    #
    # TODO: fix: build may not finish before spec runs in after()
    #

    coffee.stdout.pipe process.stdout
    coffee.stderr.pipe process.stderr
    after()

runSpec = (fileOrFolder) ->
  test_runner = child_process.spawn './node_modules/.bin/mocha', [
    '--colors','--compilers', 'coffee:coffee-script', fileOrFolder
  ]
  test_runner.stdout.pipe process.stdout
  test_runner.stderr.pipe process.stderr

specOrSrc = (file) ->
  console.log 'CHANGED:', file
  match = file.match /(src|spec)\/(.+)(_spec)?.coffee/
  if match[1] == 'src'
    #
    # changed src/ file
    #
    build ->
      # after()
      specFile = 'spec/' + match[2] + '_spec.coffee'
      runSpec specFile
  else
    runSpec file

watchSrcDir = ->
  watcher = hound.watch './src'
  watcher.on 'change', (file, stats) ->
    specOrSrc file

watchSpecDir = ->
  watcher = hound.watch './spec'
  watcher.on 'change', (file, stats) ->
    specOrSrc file

task 'dev', "Continuous test code changes", ->
  watchSpecDir()
  watchSrcDir()

task 'spec', "Run all tests", ->
  runSpec 'spec'

task 'build', "Build all", ->
  build ->

task 'doc', "Build docs", -> 
  docs -> 