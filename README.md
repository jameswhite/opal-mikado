# Opal::Mikado

An [Opal](http://opalrb.org) library for creating [Mikado Method](http://mikadomethod.wordpress.com/) graphs in an easy to use way.

## Installation

Add this line to your application's Gemfile:

    gem 'opal-mikado'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opal-mikado

## Usage

### The Ruby Code

```ruby
# opal/application.rb

require 'opal'
require 'browser'
require 'opal-dagred3'
require 'opal-mikado'

class App
  attr_accessor :mikado

  def initialize
    %x{
      d3.select('body')
        .append('svg')
        .attr('class', 'container')
      d3.select('svg')
        .append('g')
        .attr('transform','translate(20,20)');
    }
    @mikado = Mikado::Mikado.new
    @mikado.layout.node_sep = 10
    @mikado.layout.rank_dir = "BT"
    @mikado.layout.edge_sep = 2
  end

  def graph(data)
    @mikado.build_graph(data[:nodes], data[:edges])
  end

end


nodes = [
  { id: "A", label: "Some great label A", state: "done" },
  { id: "B", label: "Some great label B", state: "doing" }
]

edges = [{ from: "A", to: "B" }]

data = { nodes: nodes, edges: edges }

$document.ready do
  App.new.graph(data)
end
```
### How It Works

The `Mikado#build_graph` method expects two arrays of hashes. The first array is the `nodes` to be drawn. The nodes must have an id, label, and state in each hash. Whatever string you pass in the state slot in the hash will become a class on the `div` surrounding that node's text.  This can then be used to style and color nodes from your css.  The second array contains the `edges`, and provide the graphing library with the information needed to properly direct the graph. These edges go outward or upward `from:` the trunk `to:` the leaves, or `from` more elementary nodes `to` their dependencies.

### In Need of Style and Form

Some html and styling information is also necessary to use the library.  Something like the following should suffice (Bear in mind you will need to increase the size of the svg `.container` as you add more nodes to the graph):

```html

/*index.html*/

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Mikado</title>
    <script src="/assets/application.js"></script>
    <style>
    svg {
      border: 1px solid black;
    }

    .container {
        width: 800 px;
        height: 600 px;
    }

    text {
      font-weight: 300;
      font-family: "Helvetica Neue", Helvetica, Arial, sans-serf;
      font-size: 10px;
    }

    .node rect {
      stroke-width: 2px;
      stroke: #333;
      fill: #fff;
    }

    .edgeLabel rect {
      fill: #fff;
    }

    .edgePath path {
      stroke: #333;
      stroke-width: 1.5px;
      fill: none;
    }
    </style>

  </head>
  <body>

  </body>
</html>

```
Or you could use [Paggio](https://github.com/meh/paggio) and keep your entire app in ruby.

### Run w/ Rack

You can follow the directions at [http://opalrb.org/docs/using_sprockets/](http://opalrb.org/docs/using_sprockets/) to compile your opal scripts and serve the pages, or run it with this simple `config.ru` (taken from the README at [opal-dagred3](https://github.com/lonelyplanet/opal-dagred3)).

```ruby
# config.ru

require 'opal'
require 'bundler'
Bundler.require

run Opal::Server.new { |s|
  s.append_path 'opal'

  s.main = 'application.rb'

  s.index_path = 'index.html'
}

```

## Contributing

1. Fork it ( http://github.com/lonelyplanet/opal-mikado/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add a TEST.
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

We **_love_** tests at LonelyPlanet, and Pull Requests can not be merged without them, no matter how cool the feature or well-coded. So please write some tests to go with your feature or bug-fix.
