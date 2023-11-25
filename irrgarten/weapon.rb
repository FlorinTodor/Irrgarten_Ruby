#encoding:utf-8
# frozen_string_literal: true
require_relative 'combat_element'
module Irrgarten
  class Weapon < Combat_element
    public

  def attack
    produce_effect
  end

  def to_s
    "W[Effect: #{@effect}, Uses: #{@uses}]"
  end

  public_class_method :new
end
end