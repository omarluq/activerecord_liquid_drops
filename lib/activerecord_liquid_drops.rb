# frozen_string_literal: true

require 'activerecord_liquid_drops/base'
require 'activerecord_liquid_drops/helpers'
require 'activerecord_liquid_drops/factory'
require 'active_record'

ActiveRecord::Base.include(ActiverecordLiquidDrops::Helpers)
