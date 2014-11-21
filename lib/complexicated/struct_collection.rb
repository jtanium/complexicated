require 'active_support/core_ext/hash'

module Complexicated
  class StructCollection

    def initialize(data)
      data_keys_tmp = []
      @data = data.map do |element|
        data_keys_tmp << element.keys
        element.stringify_keys
      end
      @data_keys = data_keys_tmp.flatten.uniq
    end

    def ==(other_object)
      @data == other_object
    end

    def to_ary
      @data
    end

    def method_missing(method_name, *args, &block)
      data_key, action = determine_key_and_action(method_name.to_s)

      if method_name == :pluck
        raise ArgumentError.new("wrong number of arguments (#{args.length} for 1)") if args.length != 1
        pluck_elements(args.first)
      elsif @data_keys.include?(data_key)
        new_data =  send("#{action}_elements", data_key, args)
        self.class.new(new_data)
      else
        super(method_name, *args, &block)
      end
    end

    def determine_key_and_action(method_name)
      method_name[-1] == '!' ? [method_name.chop, 'reject'] : [method_name, 'select']
    end
    private :determine_key_and_action

    def reject_elements(key, values)
      @data.reject { |element| values.include?(element[key]) }
    end
    private :reject_elements

    def select_elements(key, values)
      @data.select { |element| values.include?(element[key]) }
    end
    private :select_elements

    def pluck_elements(key)
      @data.map { |element| element[key] }
    end
    private :pluck_elements
  end

end