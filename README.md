#purplish\_layout – a [RubyMotion](http://rubymotion.com) wrapper for Auto Layout on iOS and OS X

About
---
Ruby lends itself to creating a nice DSL for Auto Layout, so why not? I have been using this for both iOS and OS X apps since mid-2014.

Usage
---
Use it with visual format strings:

```ruby
['celf', inner_view, 'l', post_count_label].constraints do |celf, l, _|
  celf.h '|[l]|'
  celf.v '|-m-[l]-m-|', {'m' => 7}
end
```

You can also create constraint objects yourself. This is equivalent to the previous example:

```ruby
['celf', inner_view, 'l', post_count_label].constraints do |celf, l, _|
  celf.left = l.left
  celf.right = l.right
  l.top = celf.top + 7
  l.bottom = celf.bottom - 7
end
```

Send `#constraints` with a block to an array with an even number of elements. They should be pairs – the name (a `String`) to be used in the format strings in the block, followed by the view it represents.

If there are n views involved, there should be n*2 elements in the array. The block takes n+1 arguments, and the last object is the dictionary mapping generated from the array (usually unused) and the rest of the elements are constraint proxy objects representing each view, in the order specified in the array.

To avoid confusion, it's best to keep the variable names in the block the same as the string names in the array. This syntax can be improved when Proc#parameters is available.

With the exception of the first view listed in the array, `translatesAutoresizingMaskIntoConstraints` is automatically set to `false` for every view, so you'll want to specify the outermost view as the first pair.

A multipler can be supplied:

```ruby
  l.width = celf.width * 0.5
```

The attributes are available as `:left`, `:right`, `:top`, `:bottom`, `:leading`, `:trailing`, `:width`, `:height`, `:center_x`, `:center_y` and `:baseline`.

You can mix the 2 creation methods:

```ruby
['celf', inner_view, 'l', post_count_label].constraints do |celf, l, _|
  celf.left = l.left
  celf.right = l.right
  celf.v '|-m-[l]-m-|', {'m' => 7}
end
```

When specifying options argument describing the attribute and direction of layout, you can also use symbols such as :align_center_y (for NSLayoutFormatAlignAllCenterY). They are interchangeable. The options are available as `:align_left`, `:align_right`, `:align_top`, `:align_bottom`, `:align_leading`, `:align_trailing`, `:align_center_x`, `:align_center_y`, `:align_baseline`.

ie. these are equivalent:

```ruby
cv.h '|[v1][v2][v3]|', nil, NSLayoutFormatAlignAllCenterY
cv.h '|[v1][v2][v3]|', nil, :align_center_y
```

There are 2 attributes in the constraint proxies that you would occasionally find useful:

* `last_constraint` returns the last `NSLayoutConstraint` created. It's useful if you want to hold on to a `NSLayoutConstraint` and modify it in an animation.
* `next_priority` sets the priority for the next `NSLayoutConstraint` you create.

Installation
---
1. Add this to your `Gemfile`: `gem 'purplish-layout'`
2. Run `bundle install`

Dependencies
---
* [weak\_attr\_accessor](https://github.com/hboon/weak_attr_accessor)

License
---
BSD. See LICENSE file.

Questions
---
* Email: [hboon@motionobj.com](mailto:hboon@motionobj.com)
* Web: [http://hboon.com/purplish-layout](http://hboon.com/purplish-layout)
* Twitter: [http://twitter.com/hboon](http://twitter.com/hboon)
