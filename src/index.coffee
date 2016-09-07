fs = require 'fs'
Compiler = require 'metaserve/src/compiler'

VERBOSE = process.env.METASERVE_VERBOSE or false

class Bouncer extends Compiler

    compile: (bounced_filename) ->
        console.log '[Bouncer] Serving bounced ' + bounced_filename if VERBOSE
        fs.readFile bounced_filename, 'utf-8', cb

    shouldCompile: (bounced_filename) ->
        enabled = if @options.enabled? then @options.enabled else true
        return (req, res, next) ->
            return enabled && !req.headers['x-skip-bouncer']?

module.exports = (options={}) -> new Bouncer(options)

