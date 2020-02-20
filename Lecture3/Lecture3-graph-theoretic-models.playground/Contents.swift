import Foundation

/**
 def shortestPath(graph, start, end, toPrint = False):
     """Assumes graph is a Digraph; start and end are nodes
        Returns a shortest path from start to end in graph"""
     return DFS(graph, start, end, [], None, toPrint)
 */
func shortestpath(graph: DiGraph, start: Node, end: Node) -> [Node]? {
    var path: [Node] = []
    var shortest: [Node]? = nil
    return DFS(graph: graph, start: start, end: end, path: &path, shortest: &shortest)
}
/**
 def testSP(source, destination):
     sp = shortestPath(g, g.getNode(source), g.getNode(destination),
                       toPrint = True)
     if sp != None:
         print('Shortest path from', source, 'to',
               destination, 'is', printPath(sp))
     else:
         print('There is no path from', source, 'to', destination)

 */
func testSP(source: Node, destination: Node) {
    let graph = buildCityGraphType(DiGraph.self)
    print("graph:")
    print("\(graph)")
    if let sp = shortestpath(graph: graph, start: source, end: destination), !sp.isEmpty {
        print("shortest path from \(source) to \(destination) is")
        print(path: sp)
    } else {
        print("There is no path from \(source) to \(destination)")
    }
}

/**
 
 def DFS(graph, start, end, path, shortest, toPrint = False):
     """Assumes graph is a Digraph; start and end are nodes;
           path and shortest are lists of nodes
        Returns a shortest path from start to end in graph"""
     path = path + [start]
     if toPrint:
         print('Current DFS path:', printPath(path))
     if start == end:
         return path
     for node in graph.childrenOf(start):
         if node not in path: #avoid cycles
             if shortest == None or len(path) < len(shortest):
                 newPath = DFS(graph, node, end, path, shortest,
                               toPrint)
                 if newPath != None:
                     shortest = newPath
         elif toPrint:
             print('Already visited', node)
     return shortest
 
 */

func DFS(graph: GraphProtocol, start: Node, end: Node, path: inout [Node], shortest: inout [Node]?) -> [Node]? {
    path += [start]
    print("Current DFS path:")
    print(path: path)
    if start == end {
        return path
    }
    do {
        let children = try graph.childrenOf(node: start)
        for node in try graph.childrenOf(node: start) {
            if !path.contains(node) {
                if shortest == nil || (shortest!.isEmpty || path.count < shortest!.count) {
                    if let newPath = DFS(graph: graph, start: node, end: end, path: &path, shortest: &shortest) {
                        shortest = newPath
                    }
                }
            } else {
                print("already visited \(node)")
            }
        }
    } catch {
        fatalError("\(error)")
    }
    if shortest == nil {
        path.popLast()
    }
    return shortest
}

let graph = buildCityGraphType(DiGraph.self)
do {
    if let start = try? graph.getNode(withName: "Phoenix") {
        print("start with \(start)")
        for node in try graph.childrenOf(node: start) {
            print("child node \(node)")
        }
    }
} catch {
    print(error)
}

testSP(source: Node(name: "Chicago"), destination: Node(name: "Boston"))
// testSP(source: Node(name: "Boston"), destination: Node(name: "Phoenix"))
