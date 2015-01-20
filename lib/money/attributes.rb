require 'money/money'

class Money
  module Attributes
    extend ActiveSupport::Concern

    module ClassMethods

      protected

      def money(field_name)
        define_method(field_name) do
          Money.new(super(), security.currency.code, date)
        end
        define_method("#{field_name}=") do |value|
          if value.kind_of?(Money)
            super(value.amount)
          else
            super(value)
          end
        end
      end
    end
  end
end
