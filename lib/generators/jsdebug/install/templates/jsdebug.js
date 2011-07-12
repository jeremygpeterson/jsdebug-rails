/*!
 * Rails Jsdebug
 * Dual licensed under the MIT and GPL licenses.
 *
 * Based upon the plugin by "Cowboy" Ben Alman
 * http://benalman.com/projects/javascript-debug-console-log/
 */

// Script: JavaScript Debug: A simple wrapper for console.log
// Tested with Internet Explorer 6-8, Firefox 3-3.6, Safari 3-4, Chrome 3-5, Opera 9.6-10.5
//
// About: License
// Dual licensed under the MIT and GPL licenses.
//
// About: Support and Testing
// Information about what browsers this code has been tested in.
//
// Browsers Tested - Internet Explorer 6-8, Firefox 3-3.6, Safari 3-4, Chrome
// 3-5, Opera 9.6-10.5
//
// About: Examples
//
// These working examples, complete with fully commented code, illustrate a few
// ways in which this plugin can be used.
//
// Examples - http://benalman.com/code/projects/javascript-debug/examples/debug/
//
// Topic: Pass-through console methods
//
// assert, clear, count, dir, dirxml, exception, group, groupCollapsed,
// groupEnd, profile, profileEnd, table, time, timeEnd, trace
//
// These console methods are passed through (but only if both the console and
// the method exists), so use them without fear of reprisal.

window.debug = (function(){
  var window = this,

    // Some convenient shortcuts.
    aps = Array.prototype.slice,
    con = window.console,

    // Public object to be returned.
    that = {},

    callback_func,
    callback_force,

    // Logging methods, in "priority order". Not all console implementations
    // will utilize these, but they will be used in the callback passed to
    // setCallback.
    log_methods = [ 'error', 'warn', 'info', 'debug', 'log' ],

    // Pass these methods through to the console if they exist, otherwise just
    // fail gracefully. These methods are provided for convenience.
    pass_methods = 'assert clear count dir dirxml exception group groupCollapsed groupEnd profile profileEnd table time timeEnd trace'.split(' '),
    idx = pass_methods.length,

    // Logs are stored here so that they can be recalled as necessary.
    logs = [];

  while ( --idx >= 0 ) {
    (function( method ){

      // Generate pass-through methods. These methods will be called, if they
      // exist, as long as the logging level is non-zero.
      that[ method ] = function() {
        con && con[ method ]
          && con[ method ].apply( con, arguments );
      }

    })( pass_methods[idx] );
  }

  idx = log_methods.length;
  while ( --idx >= 0 ) {
    (function( idx, level ){

      // Method: debug.log
      //
      // Call the console.log method if available. Adds an entry into the logs
      // array for a callback .
      //
      // Usage:
      //
      //  debug.log( object [, object, ...] );                               - -
      //
      // Arguments:
      //  object - (Object) Any valid JavaScript object.

      // Method: debug.debug
      //
      // Call the console.debug method if available, otherwise call console.log.
      // Adds an entry into the logs array.
      //
      // Usage:
      //
      //  debug.debug( object [, object, ...] );                             - -
      //
      // Arguments:
      //
      //  object - (Object) Any valid JavaScript object.

      // Method: debug.info
      //
      // Call the console.info method if available, otherwise call console.log.
      // Adds an entry into the logs array.
      //
      // Usage:
      //
      //  debug.info( object [, object, ...] );                              - -
      //
      // Arguments:
      //
      //  object - (Object) Any valid JavaScript object.

      // Method: debug.warn
      //
      // Call the console.warn method if available, otherwise call console.log.
      // Adds an entry into the logs array.
      //
      // Usage:
      //
      //  debug.warn( object [, object, ...] );                              - -
      //
      // Arguments:
      //
      //  object - (Object) Any valid JavaScript object.

      // Method: debug.error
      //
      // Call the console.error method if available, otherwise call console.log.
      // Adds an entry into the logs array.
      //
      // Usage:
      //
      //  debug.error( object [, object, ...] );                             - -
      //
      // Arguments:
      //
      //  object - (Object) Any valid JavaScript object.

      that[ level ] = function() {
        var args = aps.call( arguments ),
          log_arr = [ level ].concat( args );

        logs.push( log_arr );
        exec_callback( log_arr );

        if ( !con ) { return; }

        con.firebug ? con[ level ].apply( window, args )
          : con[ level ] ? con[ level ]( args )
          : con.log( args );
      };

    })( idx, log_methods[idx] );
  }

  // Execute the callback function if set.
  function exec_callback( args ) {
    if ( callback_func && (callback_force || !con || !con.log) ) {
      callback_func.apply( window, args );
    }
  };

  // Method: debug.setCallback
  //
  // Set a callback to be used if logging isn't possible due to console.log
  // not existing. If unlogged logs exist when callback is set, they will all
  // be logged immediately unless a limit is specified.
  //
  // Usage:
  //
  //  debug.setCallback( callback [, force ] [, limit ] )
  //
  // Arguments:
  //
  //  callback - (Function) The aforementioned callback function. The first
  //    argument is the logging level, and all subsequent arguments are those
  //    passed to the initial debug logging method.
  //  force - (Boolean) If false, log to console.log if available, otherwise
  //    callback. If true, log to both console.log and callback.
  //  limit - (Number) If specified, number of lines to limit initial scrollback
  //    to.

  that.setCallback = function() {
    var args = aps.call( arguments ),
      max = logs.length,
      i = max;

    callback_func = args.shift() || null;
    callback_force = typeof args[0] === 'boolean' ? args.shift() : false;

    i -= typeof args[0] === 'number' ? args.shift() : max;

    while ( i < max ) {
      exec_callback( logs[i++] );
    }
  };

  return that;
})();