# frozen_string_literal: true

require 'liquid'

module ActiverecordLiquidDrops
  class Base < ::Liquid::Drop
    def initialize(resource)
      @resource = resource
      super
    end

    def self.all_drops
      all_drops = []
      drops_array.map(&:to_s).each do |drop|
        if associations_hash.keys.include?(drop)
          association_drops = "#{associations_hash[drop].classify}Drops".constantize.all_drops.map { |d| "#{drop}.#{d}" }
          all_drops.concat(association_drops)
        else
          all_drops << drop
        end
      end
      all_drops
    end

    def self.associations_hash
      model_klass.reflect_on_all_associations.each_with_object({}) { |a, obj| obj[a.name.to_s] = a.options[:class_name] || a.name }
    end

    def self.model_klass
      class_name.gsub('Drops', '').constantize
    end
  end
end
