fs = require 'fs'

VERBOSE = process.env.METASERVE_VERBOSE or false

module.exports =
    ext: '+bounced'

    compile: (filename, config, context, cb) ->
        console.log '[Bouncer.compile] Serving bounced ' + filename if VERBOSE
        fs.readFile filename, 'utf-8', cb

    shouldCompile: (filename, config, context) ->
        enabled = if config.enabled? then config.enabled else true
        should = enabled && !context.req?.headers?['x-skip-bouncer']?
        console.log 'should?', should
        return should

