SuckerPunch.exception_handler = -> (ex, klass, args) { Bugsnag.notify(ex) }
