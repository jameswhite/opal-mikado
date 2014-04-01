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

```ruby
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

edges = { from: "A", to: "B" }

data = { nodes: nodes, edges: edges }

$document.ready do
  App.new.graph(data)
end
```
The `Mikado#build_graph` method expects two arrays of hashes. The first array, the nodes must have an id, label, and state in each hash. Whatever string you pass in the state slot in the hash will become a class on the `div` surrounding that node's text.  This can then be used to style and color
nodes from your css.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/opal-mikado/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
