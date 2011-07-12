require 'tilt'

module Jsdebug
  module Rails
    class Processor < Tilt::Template
      # TODO: More control can be given here for customization.
      # log levels are(0..4): :debug, :info, :warn, :error, and :fatal
      def is_jsdebug_allowed?
        ::Rails.logger.level == 0
      end

      def prepare
      end

      def evaluate(context, locals, &block)
        #      return data if is_jsdebug_allowed?

        log_methods = %w[log debug info warn error].
          map{|c| Regexp.escape "debug.#{c}"}
        block_methods = %w[start end].
          map{|c| Regexp.escape "debug_#{c}"}
        pass_methods = %w[assert clear count dir dirxml exception group groupCollapsed groupEnd profile profileEnd table time timeEnd trace].
          map{|c| Regexp.escape "debug.#{c}"}


        log_regex = Regexp.new log_methods.map{|c| "#{c}#{Regexp.escape '('}"}.join("|")
        debug_regex = Regexp.new (log_methods + pass_methods).join("|")
        any_debug_regex = Regexp.new (log_methods + pass_methods + block_methods).join("|")

        if %w[jsdebug jquery jquery_ujs jquery-ui].include? name || !data =~ any_debug_regex
          return data
        end

        new_data = []
        index = 0
        debug_block = false
        data.each_line do |line|
          index += 1

          if(is_jsdebug_allowed? && line.match(log_regex))
            cmd = line.scan(log_regex).first
            new_data << line.gsub(cmd, "#{cmd}'[#{name}::#{index}]', ")
          else
            if (!is_jsdebug_allowed?)
              if line.match(/debug_start/)
                debug_block = true
              elsif line.match(/debug_end/)
                debug_block = false
                next
              end

              next if debug_block
            end

            new_data << line if !line.match(debug_regex)
          end
        end

        return new_data.join("")
      end
    end
  end
end
