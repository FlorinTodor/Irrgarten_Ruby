#encoding:utf-8
# frozen_string_literal: true
require_relative 'combat_element'
module Irrgarten
  class Shield < Combat_element

  def protect
    if get_uses > 0
      set_uses(get_uses - 1)
      return produce_effect
    else
      return 0.0
    end
    end

  def to_s
    "S[Protection: #{@protection}, Uses: #{@uses}]"
  end

end
end
