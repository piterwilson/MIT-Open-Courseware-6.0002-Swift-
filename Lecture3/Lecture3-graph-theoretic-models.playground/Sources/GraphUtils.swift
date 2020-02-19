import Foundation

/**
 def buildCityGraph(graphType):
     g = graphType()
     for name in ('Boston', 'Providence', 'New York', 'Chicago',
                  'Denver', 'Phoenix', 'Los Angeles'): #Create 7 nodes
         g.addNode(Node(name))
     g.addEdge(Edge(g.getNode('Boston'), g.getNode('Providence')))
     g.addEdge(Edge(g.getNode('Boston'), g.getNode('New York')))
     g.addEdge(Edge(g.getNode('Providence'), g.getNode('Boston')))
     g.addEdge(Edge(g.getNode('Providence'), g.getNode('New York')))
     g.addEdge(Edge(g.getNode('New York'), g.getNode('Chicago')))
     g.addEdge(Edge(g.getNode('Chicago'), g.getNode('Denver')))
     g.addEdge(Edge(g.getNode('Chicago'), g.getNode('Phoenix')))
     g.addEdge(Edge(g.getNode('Denver'), g.getNode('Phoenix')))
     g.addEdge(Edge(g.getNode('Denver'), g.getNode('New York')))
     g.addEdge(Edge(g.getNode('Los Angeles'), g.getNode('Boston')))
     return g
 */

public func buildCityGraphType(_ graphType: DiGraph.Type) -> DiGraph {
    do {
        let graph: DiGraph = graphType.init()
        for name in ["Boston", "Providence", "New York", "Chicago", "Denver", "Phoenix", "Los Angeles"] {
            try graph.add(node: Node(name: name))
        }
        try graph.add(edge: Edge(source: try graph.getNode(withName: "Boston"), destination: try graph.getNode(withName: "Providence")))
        try graph.add(edge: Edge(source: try graph.getNode(withName: "Boston"), destination: try graph.getNode(withName: "New York")))
        try graph.add(edge: Edge(source: try graph.getNode(withName: "Providence"), destination: try graph.getNode(withName: "Boston")))
        try graph.add(edge: Edge(source: try graph.getNode(withName: "Providence"), destination: try graph.getNode(withName: "New York")))
        try graph.add(edge: Edge(source: try graph.getNode(withName: "New York"), destination: try graph.getNode(withName: "Chicago")))
        try graph.add(edge: Edge(source: try graph.getNode(withName: "Chicago"), destination: try graph.getNode(withName: "Denver")))
        try graph.add(edge: Edge(source: try graph.getNode(withName: "Chicago"), destination: try graph.getNode(withName: "Phoenix")))
        try graph.add(edge: Edge(source: try graph.getNode(withName: "Denver"), destination: try graph.getNode(withName: "Phoenix")))
        try graph.add(edge: Edge(source: try graph.getNode(withName: "Denver"), destination: try graph.getNode(withName: "New York")))
        try graph.add(edge: Edge(source: try graph.getNode(withName: "Los Angeles"), destination: try graph.getNode(withName:"Boston")))
        return graph
    } catch {
        fatalError("\(error)")
    }
}

/**
 def printPath(path):
     """Assumes path is a list of nodes"""
     result = ''
     for i in range(len(path)):
         result = result + str(path[i])
         if i != len(path) - 1:
             result = result + '->'
     return result
 */
func print(path: [Node]) -> String {
    var result = ""
    guard let last = path.last else {
        return ""
    }
    path.forEach {node in
        result += "\(node)"
        if node != last {
            result += " -> "
        }
    }
    return result
}
