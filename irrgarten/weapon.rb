#encoding:utf-8
# frozen_string_literal: true
require_relative 'combat_element'
module Irrgarten
  class Weapon < Combat_element


  def attack
    if get_uses > 0
      set_uses(get_uses - 1)
      return produce_effect
    else
    return 0.0
  end
  end

  def to_s
    "W[Power: #{@power}, Uses: #{@uses}]\n"
  end


end
end