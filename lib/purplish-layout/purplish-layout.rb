module PurplishLayout
  class ConstraintProxy
    weak_attr_accessor :view
    weak_attr_accessor :views_mapping
    attr_accessor :attribute, :multiplier, :constant
    attr_accessor :last_constraint
    attr_accessor :next_priority

    def initialize(view, attribute=nil, multiplier=1, constant=0)
      @view = view
      @attribute = attribute
      @multiplier = multiplier
      @constant = constant
    end

    def *(aNumber)
      ConstraintProxy.new(view, attribute, aNumber, constant)
    end

    def +(aNumber)
      ConstraintProxy.new(view, attribute, multiplier, aNumber)
    end

    def -(aNumber)
      ConstraintProxy.new(view, attribute, multiplier, -aNumber)
    end

    def **(aNumber)
      ConstraintProxy.new(view, attribute, multiplier, constant).tap do |c|
        c.next_priority = aNumber
      end
    end

    def next_priority=(v)
      @next_priority = v
    end

    def create_constraint_with_rhs(rhs)
      if rhs.kind_of? self.class
        owner = rhs.view.common_superview(view)
        c = NSLayoutConstraint.constraintWithItem(view, attribute:attribute.to_layout_attribute, relatedBy:@operator, toItem:rhs.view, attribute:rhs.attribute.to_layout_attribute, multiplier:rhs.multiplier, constant:rhs.constant)
        if next_priority || rhs.next_priority
          c.priority = next_priority || rhs.next_priority
          self.next_priority = nil
          rhs.next_priority = nil
        end
        #puts "addConstraint: #{c.inspect}"
        owner.addConstraint(c)
        c
      else
        c = NSLayoutConstraint.constraintWithItem(view, attribute:attribute.to_layout_attribute, relatedBy:@operator, toItem:nil, attribute:NSLayoutAttributeNotAnAttribute, multiplier:0, constant:rhs)
        if next_priority
          c.priority = next_priority
          self.next_priority = nil
        end
        #puts "addConstraint: #{c.inspect}"
        view.superview.addConstraint(c)
        c
      end
    end

    def h(s, metrics=nil, options=0, views=nil)
      if (s.start_with? 'H:') || (s.start_with? 'V:')
        layout(s, metrics, options, views)
      else
        layout("H:#{s}", metrics, options, views)
      end
    end

    def v(s, metrics=nil, options=0, views=nil)
      if (s.start_with? 'H:') || (s.start_with? 'V:')
        layout(s, metrics, options, views)
      else
        layout("V:#{s}", metrics, options, views)
      end
    end

    def layout(s, metrics=nil, options=0, views=nil)
      views ||= views_mapping
      if options != 0
        options = case options
                  when :align_left
                    NSLayoutFormatAlignAllLeft
                  when :align_right
                    NSLayoutFormatAlignAllRight
                  when :align_top
                    NSLayoutFormatAlignAllTop
                  when :align_bottom
                    NSLayoutFormatAlignAllBottom
                  when :align_leading
                    NSLayoutFormatAlignAllLeading
                  when :align_trailing
                    NSLayoutFormatAlignAllTrailing
                  when :align_center_x
                    NSLayoutFormatAlignAllCenterX
                  when :align_center_y
                    NSLayoutFormatAlignAllCenterY
                  when :align_baseline
                    NSLayoutFormatAlignAllBaseline
                  else
                    options
                  end
      end
      #workaround1 dup to workaround crash for using WeakRef with Xcode 7 beta
      c = NSLayoutConstraint.constraintsWithVisualFormat(s, options:options, metrics:metrics, views:NSDictionary.dictionaryWithDictionary(views.dup))
      self.last_constraint = c
      if next_priority
        c.each {|e|e.priority = next_priority}
        self.next_priority = nil
      end
      #puts "addConstraints:"
      #c.each {|e| puts "  #{e.inspect}"}
      view.addConstraints(c)
    end

    ##Attributes

    def attr
      @attribute = __method__
      self
    end

    def attr=(rhs)
      #Derive reader name from writer
      @attribute = __method__[0..-3].to_sym
      @operator = NSLayoutRelationEqual
      self.last_constraint = create_constraint_with_rhs(rhs)
      self
    end

    def <=(rhs)
      @operator = NSLayoutRelationLessThanOrEqual
      create_constraint_with_rhs(rhs)
      self
    end

    def >=(rhs)
      @operator = NSLayoutRelationGreaterThanOrEqual
      create_constraint_with_rhs(rhs)
      self
    end

    alias :left :attr
    alias :left= :attr=
    alias :right :attr
    alias :right= :attr=
    alias :top :attr
    alias :top= :attr=
    alias :bottom :attr
    alias :bottom= :attr=
    alias :leading :attr
    alias :leading= :attr=
    alias :trailing :attr
    alias :trailing= :attr=
    alias :width :attr
    alias :width= :attr=
    alias :height :attr
    alias :height= :attr=
    alias :center_x :attr
    alias :center_x= :attr=
    alias :center_y :attr
    alias :center_y= :attr=
    alias :baseline :attr
    alias :baseline= :attr=
  end
end
