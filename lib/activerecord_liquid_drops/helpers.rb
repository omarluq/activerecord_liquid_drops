# frozen_string_literal: true

module ActiverecordLiquidDrops
  module Helpers
    extend ActiveSupport::Concern

    class_methods do
      # the drops method can be added to models to expose attributes to liquid templates
      # When the liquid factory is called, it will create a new invisible class called ModelDrops
      # when we compose a template we need to call ModelDrops.new(model) to create a new instance of the class for each model needed as assigns for the template
      def drops(*drops)
        Factory.new(self, drops)
      end

      def drops_klass
        drops_class_name.constantize
      end

      delegate :all_drops, to: :drops_klass

      def drops_class_name
        "#{name}Drops"
      end
    end

    included do
      def drops
        self.class.drops_klass.new(self)
      end
    end
  end
end
