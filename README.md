[![Gem Version](https://badge.fury.io/rb/activerecord_liquid_drops.svg)](https://badge.fury.io/rb/activerecord_liquid_drops)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![unstable](http://badges.github.io/stability-badges/dist/stable.svg)](http://github.com/badges/stability-badges)

# Activerecord_liquid_drops

Integrates [Liquid Templating Language](https://github.com/Shopify/liquid) [Drops](https://github.com/Shopify/liquid/wiki/Introduction-to-Drops) to Active Record

## Installation
Add this line to your application's Gemfile:

```ruby
gem "activerecord_liquid_drops"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install activerecord_liquid_drops
```

## Usage

### Defining Drops
We love the Liquid language and we love the Drops functionality! Exposing DB attributes to a templating engine safely is awesome; however, you can end up with a huge (and ugly) directory of Drops classes that are mostly boilerplate just to define those safe attributes.
Activerecord_liquid_drops takes care of all the boilerplate by defining a Drops class for every Active Record model magically under the hood.
Mmm, okay, but how do we define those safe attributes if the class is no longer accessible? Simple! Let's assume we have the following User model with 3 columns in the DB - first_name, last_name, and dob. We simply add a Drops block and pass it symbols of the columns we want to expose as safe attributes.

```ruby
class User < ActiveRecord::Base
  drops :first_name, :last_name, :dob
end

```

Mmm, okay, cool. But can I only make a DB column safe for the templating language? We can do a little more! Mmm, let's say I don't want to expose both first_name and last_name separately. That's just too much for the end user! I want to have a name function!

```ruby
class User < ActiveRecord::Base
  drops :name, :dob

  def name
   "#{first_name} #{last_name}"
  end
end

```

What about associations? That works too! Let's add a posts table to our example with a title and a body columns.


```ruby
class User < ActiveRecord::Base
  has_many :posts
  drops :name, :dob

  def name
   "#{first_name} #{last_name}"
  end
end

class Post < ActiveRecord::Base
  belongs_to :user
  drops :user, :title, :body
end
```
Note: by adding the user association as a drop on the Post class, the post will inherit the user drops, so the post drops would be `['title', 'body', 'user.name', 'user.age']`.

### Helpers
`all_drops` helper is added to your Active Record models as a class method. It returns an array of all the model drops.
```irb
=> Post.all_drops
=> ['title', 'body', 'user.name', 'user.age']
```

`drops` helper is added to your Active Record models as an instance method. It news up a Drops class instance for your current model instance.
```irb
=> post = Post.create!(title: 'New Post', body: 'I love Ruby!!!')
=> post.drops
=> PostDrops
```
## Contributing
Fork it ( https://github.com/omarluq/activerecord_liquid_drops/fork )

Create your feature branch (git checkout -b my-new-feature)

Commit your changes (git commit -am 'feat: add some feature')

Push to the branch (git push origin my-new-feature)

Create a new Pull Request

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

