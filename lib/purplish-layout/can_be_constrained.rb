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

  def filled_by(aView, insets=NSEdgeInsetsMake(0, 0, 0, 0))
    ['celf', self, 'v', aView].constraints do |celf, v, _|
      celf.h '|-l-[v]-r-|', {'l'=>insets.left, 'r'=>insets.right}
      celf.v '|-t-[v]-b-|', {'t'=>insets.top, 'b'=>insets.bottom}
    end
  end
end
