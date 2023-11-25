#encoding:utf-8
# frozen_string_literal: true
require_relative 'combat_element'
module Irrgarten
  class Shield < Combat_element
    public

  def protect
    produce_effect
  end

  def to_s
    "S[Effect: #{@effect}, Uses: #{@uses}]"
  end

  public_class_method :new
end
end
