module CanBeConstrained
  def constraint
    #Don't bother storing it, and most importantly, don't reuse it because things like multipler and constant must always be reset
    PurplishLayout::ConstraintProxy.new(self)
  end

  def constrained_views(*views, &block)
    block.call(*(views.map {|e| e.constraint}))
  end

  def common_superview(v)
    if v.superview == self
      self
    elsif superview == v
      v
    else
      (superviews & v.superviews)[0]
    end
  end

  def superviews
    v = self
    result = []
    loop do
      v = v.superview
      break unless v
      result << v
    end
    result
  end

  def all_subviews
    subviews.map { |e| [e] + e.all_subviews }.flatten
  end

  def all_subviews_and_self
    all_subviews + [self]
  end

  def constraints_for_view(view)
    all_subviews_and_self.map {|e| e.constraints.select { |e| e.firstItem == view || e.secondItem == view }}.flatten
  end
end
