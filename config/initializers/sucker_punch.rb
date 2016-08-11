# frozen_string_literal: true
SuckerPunch.exception_handler = -> (ex, _klass, _args) { Bugsnag.notify(ex) }
