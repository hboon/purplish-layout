class NSArray
  def constraints(&block)
    mapping = Hash[*self]
    view_constraint_proxies = each_slice(2).to_a.transpose[1].map do |e|
      if e.nil?
        nil
      elsif e.kind_of? NSArray
        e.map do |ele|
          ele.translatesAutoresizingMaskIntoConstraints = false if ele != self[1]
          ele.constraint
        end
      else
        e.translatesAutoresizingMaskIntoConstraints = false if e != self[1]
        c = e.constraint
        c.views_mapping = mapping
        c
      end
    end
    block.call(*(view_constraint_proxies + [mapping]))
  end

  def constraint_same_width
    inject do |prev, e|
      prev.width = e.width
      e
    end
  end

  def constraint_same_height
    inject do |prev, e|
      prev.height = e.height
      e
    end
  end
end
