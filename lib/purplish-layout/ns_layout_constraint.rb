class NSLayoutConstraint
  def inspect
    s = super
    op = case relation
         when NSLayoutRelationEqual
           '=='
         when NSLayoutRelationLessThanOrEqual
           '<='
         when NSLayoutRelationGreaterThanOrEqual
           '>='
         end
    if secondAttribute == NSLayoutAttributeNotAnAttribute
      "#{s} #{firstItem}.#{firstAttribute.to_layout_attribute} #{op} #{constant}"
    else
      if constant == 0
        const_s = ''
      else
        const_s = " + #{constant}"
      end
      if multiplier == 1
        "#{s} #{firstItem}.#{firstAttribute.to_layout_attribute} #{op} #{secondItem}.#{secondAttribute.to_layout_attribute}#{const_s}"
      else
        "#{s} #{firstItem}.#{firstAttribute.to_layout_attribute} #{op} #{secondItem}.#{secondAttribute.to_layout_attribute} * #{multiplier}#{const_s}"
      end
    end
  end
end
