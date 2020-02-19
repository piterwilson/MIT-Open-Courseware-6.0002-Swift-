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
    case nodeNotInGraph
}

public protocol GraphProtocol: class, CustomStringConvertible {
    var edges: [Node: [Node]] { get set }
    func add(node: Node) throws
    func add(edge: Edge) throws
    func childrenOf(node: Node) throws -> [Node]
    func has(node: Node) -> Bool
    func getNode(withName name: String) throws -> Node
}

extension GraphProtocol {
    public func add(node: Node) throws {
        if edges.keys.contains(node) {
            throw GraphError.duplicateNode
        }
        edges[node] = []
    }
    public func childrenOf(node: Node) throws -> [Node]  {
        guard has(node: node) else {
            throw GraphError.nodeNotInGraph
        }
        return edges[node] ?? []
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
        throw GraphError.nodeNotInGraph
    }
    public var description: String {
        var result = ""
        for source in edges.keys {
            for destination in (edges[source] ?? []) {
                result += "\(source.name) -> \(destination.name)\n"
            }
        }
        return result
    }
}

public class DiGraph: GraphProtocol {
    public required init() {}
    public var edges: [Node: [Node]] = [:]
    public func add(edge: Edge) throws {
        let source = edge.source
        let destination = edge.destination
        guard has(node: source), has(node: destination) else {
            throw GraphError.nodeNotInGraph
        }
        edges[source]?.append(destination)
    }
}

public class Graph: DiGraph {
    override public func add(edge: Edge) throws {
        try super.add(edge: edge)
        let reverseEdge = Edge(source: edge.destination, destination: edge.source)
        try super.add(edge: reverseEdge)
    }
}
