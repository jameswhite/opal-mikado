module Mikado
  class Mikado
    attr_accessor :digraph, :renderer, :layout, :svg

    def initialize
      @digraph = Dagre::Digraph.new
      @renderer = Dagre::Renderer.new
      @layout = Dagre::Layout.new
      #@digraph.graph(rankDir: "BT", nodeSep: 10, edgeSep: 2)
    end

    def build_graph(nodes, edges)
      @svg = `d3.select('svg g')`
      @digraph.graph(@layout.graph.to_n)

      nodes.each do |node|
        label = "<div class='text #{node[:state]}'>#{node[:label]}</div>"
        @digraph.add_node(node[:id], { label: label })
      end
      edges.each do |edge|
        @digraph.add_edge(`null`, edge[:from], edge[:to])
      end

      @renderer.run(@digraph, @svg)
    end

    def test
      build_graph(nodes, edges)
    end
  end
end
