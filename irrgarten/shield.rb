#encoding:utf-8
# frozen_string_literal: true
require_relative 'dice'
module Irrgarten
class Shield
  def initialize(p,u)
    @protection = p
    @uses = u
  end

  def protect
    if @uses > 0
      @uses -= 1
      return @protection
    else
      return 0
    end
  end

  def to_s
    "S[Protection: #{@protection}, Uses: #{@uses}]"
  end

  def discard
    Dice.discard_element(@uses)
  end
end
end