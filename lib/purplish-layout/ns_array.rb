class NSArray
  def constraints(&block)
    mapping = Hash[*self]
    view_constraint_proxies = each_slice(2).to_a.transpose[1].map do |e|
      if e.nil?
        c = nil
      else
        e.translatesAutoresizingMaskIntoConstraints = false if e != self[1]
        c = e.constraint
        c.views_mapping = mapping
      end
      c
    end
    block.call(*(view_constraint_proxies + [mapping]))
  end
end
