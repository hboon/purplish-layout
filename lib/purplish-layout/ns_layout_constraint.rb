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
      "#{s} #{firstItem}.#{firstAttribute.to_layout_attribute} #{op} #{constant} @ #{priority}"
    else
      if constant == 0
        const_s = ''
      else
        const_s = " + #{constant}"
      end
      if multiplier == 1
        "#{s} #{firstItem}.#{firstAttribute.to_layout_attribute} #{op} #{secondItem}.#{secondAttribute.to_layout_attribute}#{const_s} @ #{priority}"
      else
        "#{s} #{firstItem}.#{firstAttribute.to_layout_attribute} #{op} #{secondItem}.#{secondAttribute.to_layout_attribute} * #{multiplier}#{const_s} @ #{priority}"
      end
    end
  end

  def horizontal?
    [NSLayoutAttributeLeft, NSLayoutAttributeRight, NSLayoutAttributeLeading, NSLayoutAttributeTrailing, NSLayoutAttributeWidth, NSLayoutAttributeCenterX, NSLayoutAttributeLeftMargin, NSLayoutAttributeRightMargin, NSLayoutAttributeLeadingMargin, NSLayoutAttributeTrailingMargin, NSLayoutAttributeCenterXWithinMargins].include? firstAttribute
  end

  def vertical?
    !horizontal?
  end
end
