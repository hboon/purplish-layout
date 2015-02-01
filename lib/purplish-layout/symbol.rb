class Symbol
  def to_layout_attribute
    case self
    when :left
      NSLayoutAttributeLeft
    when :right
      NSLayoutAttributeRight
    when :top
      NSLayoutAttributeTop
    when :bottom
      NSLayoutAttributeBottom
    when :leading
      NSLayoutAttributeLeading
    when :trailing
      NSLayoutAttributeTrailing
    when :width
      NSLayoutAttributeWidth
    when :height
      NSLayoutAttributeHeight
    when :center_x
      NSLayoutAttributeCenterX
    when :center_y
      NSLayoutAttributeCenterY
    when :baseline
      NSLayoutAttributeBaseline
    end
  end
end
