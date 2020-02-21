import Foundation

/**
 
 class Digraph(object):
     """edges is a dict mapping each node to a list of
     its children"""
     def __init__(self):
         self.edges = {}
     def addNode(self, node):
         if node in self.edges:
             raise ValueError('Duplicate node')
         else:
             self.edges[node] = []
     def addEdge(self, edge):
         src = edge.getSource()
         dest = edge.getDestination()
         if not (src in self.edges and dest in self.edges):
             raise ValueError('Node not in graph')
         self.edges[src].append(dest)
     def childrenOf(self, node):
         return self.edges[node]
     def hasNode(self, node):
         return node in self.edges
     def getNode(self, name):
         for n in self.edges:
             if n.getName() == name:
                 return n
         raise NameError(name)
     def __str__(self):
         result = ''
         for src in self.edges:
             for dest in self.edges[src]:
                 result = result + src.getName() + '->'\
                          + dest.getName() + '\n'
         return result[:-1] #omit final newline

 class Graph(Digraph):
     def addEdge(self, edge):
         Digraph.addEdge(self, edge)
         rev = Edge(edge.getDestination(), edge.getSource())
         Digraph.addEdge(self, rev)
 */

public enum GraphError: Error {
    case duplicateNode
    case nodeNotInGraph(String)
    case edgeDoesntExistBetweenNodes(Node, Node)
}

public protocol GraphProtocol: class, CustomStringConvertible {
    var edges: [Node: [Edge]] { get set }
    func add(node: Node) throws
    func add(edge: Edge) throws
    func childrenOf(node: Node) throws -> [Node]
    func has(node: Node) -> Bool
    func getNode(withName name: String) throws -> Node
    func getEdge(source: Node, destination: Node) throws -> Edge
    func calculateWeight(in path: [Node]?) -> Int
    func log(path: [Node])
}

public class DiGraph: GraphProtocol {
    public required init() {}
    public var edges: [Node: [Edge]] = [:]
    public func add(edge: Edge) throws {
        let source = edge.source
        let destination = edge.destination
        guard has(node: source) else {
            throw GraphError.nodeNotInGraph(source.name)
        }
        guard has(node: destination) else {
            throw GraphError.nodeNotInGraph(destination.name)
        }
        edges[source]?.append(edge)
    }
    public func calculateWeight(in path: [Node]?) -> Int {
        do {
            guard let path = path else {
                return 0
            }
            guard path.count > 1, let last = path.last else {
                return 0
            }
            var result = 0
            for (index, node) in path.enumerated() where node != last {
                // find edge with the next node and add the weight
                let next = path[index + 1]
                let edge = try getEdge(source: node, destination: next)
                result += edge.weight
            }
            print("path \(path) weights: \(result)")
            return result
        } catch {
            return 0
        }
    }
    public func log(path: [Node]) {
        var result = ""
        guard let last = path.last else {
            print("")
            return
        }
        path.forEach {node in
            result += "\(node)"
            if node != last {
                result += " -> "
            }
        }
        let weight = calculateWeight(in: path)
        print("\(result) w: \(weight)")
    }
    public func getEdge(source: Node, destination: Node) throws -> Edge {
        guard let edgesInNode = edges[source] else {
            throw GraphError.nodeNotInGraph(source.name)
        }
        for edge in edgesInNode {
            if edge.destination == destination { return edge }
        }
        throw GraphError.edgeDoesntExistBetweenNodes(source, destination)
        
    }
    public func add(node: Node) throws {
        if edges.keys.contains(node) {
            throw GraphError.duplicateNode
        }
        edges[node] = []
    }
    public func childrenOf(node: Node) throws -> [Node]  {
        guard let edgesInNode = edges[node] else {
            throw GraphError.nodeNotInGraph(node.name)
        }
        return edgesInNode.map { $0.destination }
    }
    public func has(node: Node) -> Bool {
        return edges.keys.contains(node)
    }
    public func getNode(withName name: String) throws -> Node {
        for node in edges.keys {
            if node.name == name {
                return node
            }
        }
        throw GraphError.nodeNotInGraph(name)
    }
    public var description: String {
        var result = ""
        for source in edges.keys {
            for edge in (edges[source] ?? []) {
                result += "\(source.name) -> \(edge.destination.name) w: \(edge.weight)\n"
            }
        }
        return result
    }
}

public class Graph: DiGraph {
    override public func add(edge: Edge) throws {
        try super.add(edge: edge)
        let reverseEdge = Edge(source: edge.destination, destination: edge.source)
        try super.add(edge: reverseEdge)
    }
}
