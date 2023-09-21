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

### Streamlined Drops Definition

Leveraging the Liquid language and its Drops functionality offers significant advantages in terms of templating engine flexibility. However, the management of numerous Drops classes, often containing boilerplate code, can become cumbersome and unwieldy. `activerecord_liquid_drops` addresses this by automating the creation of Drops classes for each Active Record model seamlessly.

Defining safe attributes for exposure becomes straightforward. Take our User model with three database columns: `first_name`, `last_name`, and `dob`. To expose these as safe attributes, we simply add a Drops block and pass it symbols representing the columns.

```ruby
class User < ActiveRecord::Base
  drops :first_name, :last_name, :dob
end
```

Additionally, the Drops block can accept a method name defined on the model, providing even greater customization and control over your data presentation.

```ruby
class User < ActiveRecord::Base
  drops :name, :dob

  def name
    "#{first_name} #{last_name}"
  end
end
```

Associations are supported as well. If we add a `posts` table to our example with `title` and `body` columns, we can include them in the Drops.

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

It's important to note that by introducing the `user` association as a drop on the `Post` class, the `Post` drops will inherit those of the user, resulting in `['title', 'body', 'user.name', 'user.age']`.

### Useful Helpers

We've included two helpful helpers:

1. **`all_drops`**: This class method is added to your Active Record models, making it easy to retrieve an array containing all available Drops for the model.

   ```ruby
   => Post.all_drops
   => ['title', 'body', 'user.name', 'user.age']
   ```

2. **`drops`**: This instance method is available in your Active Record models, allowing you to instantiate a Drops class instance for your current model instance.

   ```ruby
   => post = Post.create!(title: 'New Post', body: 'I hold an affinity for Ruby!!!')
   => post.drops
   => PostDrops
   ```

These features significantly simplify the management of Drops within your application, streamlining the process and enhancing flexibility.
## Contributing
Fork it ( https://github.com/omarluq/activerecord_liquid_drops/fork )

Create your feature branch (git checkout -b my-new-feature)

Commit your changes (git commit -am 'feat: add some feature')

Push to the branch (git push origin my-new-feature)

Create a new Pull Request

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

