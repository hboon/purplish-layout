module CanBeConstrained
  def filled_by(aView, insets=NSEdgeInsetsMake(0, 0, 0, 0))
    ['celf', self, 'v', aView].constraints do |celf, v, _|
      celf.h '|-l-[v]-r-|', {'l'=>insets.left, 'r'=>insets.right}
      celf.v '|-t-[v]-b-|', {'t'=>insets.top, 'b'=>insets.bottom}
    end
  end
end
