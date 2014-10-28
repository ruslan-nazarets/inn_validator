require 'active_model'
require 'active_support/i18n'
I18n.load_path << File.dirname(__FILE__) + '/locale/en.yml'

module ActiveModel
  module Validations
    class InnValidator < ActiveModel::EachValidator

      def initialize(options)
        options.reverse_merge!(message: :inn)
        super(options)
      end

      def validate_each(record, attribute, value)
        if 10 == value.length
          a1 = value[0].to_i
          a2 = value[1].to_i
          a3 = value[2].to_i
          a4 = value[3].to_i
          a5 = value[4].to_i
          a6 = value[5].to_i
          a7 = value[6].to_i
          a8 = value[7].to_i
          a9 = value[8].to_i
          x = -1 * a1 + 5 * a2 + 7 * a3 + 9 * a4 + 4 * a5 + 6 * a6 + 10 * a7 + 5 * a8 + 7 * a9
          result = (x % 11) % 10
          unless value[9].to_i == result
            record.errors.add(attribute, options.fetch(:message), value: value)
          end
        else
          record.errors.add(attribute, options.fetch(:message), value: value)
        end
      end
    end

    module ClassMethods
      def validates_inn(*attr_names)
        validates_with InnValidator, _merge_attributes(attr_names)
      end
    end
  end
end