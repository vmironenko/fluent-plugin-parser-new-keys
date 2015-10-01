module Fluent
  class ParserNewKeysOutput < Output
    Fluent::Plugin.register_output('parser_new_keys', self)

    config_param :tag, :string
    config_param :parse_field,        :string, :default => 'message'
    config_param :prefix_new_key,     :string, :default => 'new_key'
    config_param :number_of_keys,     :string,:default => '3'
    config_param :pattern,            :string,
                 :default => %{\n(?:Caused by: )*([a-zA-Z_.]+Exception): }


    def compiled_pattern
      @comp_pattern ||= Regexp.new(@pattern)
    end

    def emit(tag, es, chain)
      es.each { |time, record|
      Engine.emit(@tag, time, parsing(record))
      }
      chain.next
    end


    def parsing(record)
      compiled_pattern()
      source = record[@parse_field].to_s
      num = 1
      while  @number_of_keys.to_i >= num
        if source.scan(@comp_pattern)[num - 1].nil?
           mess = ''
        else
           mess = source.scan(@comp_pattern)[num - 1][0].to_s
        end
        record[@prefix_new_key + '_' + num.to_s] = mess
        num = num + 1
      end
      return record
    end
  end
