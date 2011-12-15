SpreeQuickOrder
===============

Creates an order form page allowing the customer to enter a quantity and a sku to populate the cart

Install
=======

1. Add the following to your Gemfile
    `gem 'spree_featured_taxon', :git => 'git://github.com/Matmon/spree-quick-order.git'`

2. Run
    `bundle install`

3. Provides new route for /quick-order/ 

4. Provides helper for that quick_order_form(rows = 3, *args, &b)
   will look for :id and :class in args that are assigned to the form
   
Example
=======

Add a quick order form to the sidebar

```
Deface::Override.new(:virtual_path => 'shared/_taxonomies',
  :name => 'insert_quickorder_sidebar',
  :insert_after => "div#taxonomies",
  :partial => 'quick_order/form')
```

Or create your own partial and render the helper

`<%= quick_order_form(5) %>`

Testing
-------

Still Need to setup tests

Be sure to add the rspec-rails gem to your Gemfile and then create a dummy test app for the specs to run against.

    $ bundle exec rake test app
    $ bundle exec rspec spec

Copyright (c) 2011 Matmon Internet, Inc. released under the New BSD License
