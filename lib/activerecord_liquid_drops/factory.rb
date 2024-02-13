# frozen_string_literal: true

module ActiverecordLiquidDrops
  class Factory
    def initialize(model, drops = [])
      @model = model
      @model_klass = model.to_s
      @drops = drops
      build_drops_klass
    end

    def nested?
      @model_klass.include?('::')
    end

    def model_klass
      nested? ? @model_klass.split('::').last : @model_klass
    end

    def drops_klass
      "#{model_klass}Drops"
    end

    def build_drops_klass
      nested? ? drops_from_nested_model : drops_from_model
    end

    def drops_from_nested_model
      return if parent.const_defined?(drops_klass)

      parent.const_set(drops_klass, klass_defention)
    end

    def parent
      @parent ||= @model.responed_to?(:module_parent) ? @model.module_parent : @model.parent if nested?
    end

    def drops_from_model
      return if Object.const_defined?(drops_klass)

      Object.const_set(drops_klass, klass_defention)
    end

    def klass_defention
      # this method is a simple meta class builder used to build an un-instantiable class that can be used to expose safe attributes only to liquid templates
      # this buider handles un-nested models
      # the builder defines a class called ModelDrops
      # the ModelDrops inherits from the base class Drops::Base
      # the base drops defines an initialize method that takes a model instance as an argument and sets it as an instance variable @resource
      # thus we have access to the @resource[drop] inside of the klass defention block
      # in other words this method generates the following class defention magically assuming that we have the following drops on the model:
      #
      # def Model < ApplicationRecord
      #   drops :drop1, :drop2
      # end
      #
      # class ModelDrops < Drops::Base
      #   def drop1
      #     @resource[drop1]
      #   end
      #
      #   def drop2
      #     @resource[drop2]
      #   end
      #
      #   def self.drops_array
      #     [:drop1, :drop2].freeze
      #   end
      # end
      #
      drops_as_sym = @drops.map(&:to_sym)
      Class.new(ActiverecordLiquidDrops::Base) do |klass|
        klass.define_singleton_method(:drops_array) { drops_as_sym.freeze }
        drops_as_sym.each do |drop|
          klass.define_method(drop) do
            value = @resource.public_send(drop)
            if value.is_a?(ActiveRecord::Base)
              value.drops
            else
              value
            end
          end
        end
      end
    end
  end
end
