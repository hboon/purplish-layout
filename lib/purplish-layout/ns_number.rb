class NSNumber
  def to_layout_attribute
    case self
    when NSLayoutAttributeLeft
      'left'
    when NSLayoutAttributeRight
      'right'
    when NSLayoutAttributeTop
      'top'
    when NSLayoutAttributeBottom
      'bottom'
    when NSLayoutAttributeLeading
      'leading'
    when NSLayoutAttributeTrailing
      'trailing'
    when NSLayoutAttributeWidth
      'width'
    when NSLayoutAttributeHeight
      'height'
    when NSLayoutAttributeCenterX
      'center_x'
    when NSLayoutAttributeCenterY
      'center_y'
    when NSLayoutAttributeBaseline
      'baseline'
    end
  end
end
