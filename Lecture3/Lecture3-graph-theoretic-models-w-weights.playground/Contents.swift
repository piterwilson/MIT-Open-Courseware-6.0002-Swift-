import Foundation

/**
 def shortestPath(graph, start, end, toPrint = False):
     """Assumes graph is a Digraph; start and end are nodes
        Returns a shortest path from start to end in graph"""
     return DFS(graph, start, end, [], None, toPrint)
 */
func shortestpathDFS(graph: DiGraph, start: Node, end: Node) -> [Node]? {
    var shortest: [Node]? = nil
    return DFS(graph: graph, start: start, end: end, path: [], shortest: &shortest)
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
    let stopWatch = StopWatch()
    let graph = buildCityGraphTypeUSA()
    print("graph:")
    print("\(graph)")
    print("-> using DFS")
    stopWatch.start()
    if let sp = shortestpathDFS(graph: graph, start: source, end: destination), !sp.isEmpty {
        print("shortest path from \(source) to \(destination) is")
        print(sp)
        print("took \(stopWatch.mark()) secs")
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
func DFS(graph: GraphProtocol, start: Node, end: Node, path: [Node], shortest: inout [Node]?) -> [Node]? {
    var pathCopy = path
    pathCopy += [start]
    print("Current DFS path:")
    print(path: pathCopy)
    if start == end {
        return path + [end]
    }
    do {
        for node in try graph.childrenOf(node: start) {
            if !pathCopy.contains(node) {
                if shortest == nil || graph.calculateWeight(in: path) < graph.calculateWeight(in: shortest) {
                    if let newPath = DFS(graph: graph, start: node, end: end, path: pathCopy, shortest: &shortest) {
                        if shortest == nil || graph.calculateWeight(in: newPath) < graph.calculateWeight(in: shortest) {
                            shortest = newPath
                        }
                    }
                }
            } else {
                print("already visited \(node)")
            }
        }
    } catch {
        fatalError("\(error)")
    }
    return shortest
}

//print(" --- test 1 ---")
//testSP(source: Node(name: "Chicago"), destination: Node(name: "Boston"))
print(" --- test 2 ---")
testSP(source: Node(name: "Boston"), destination: Node(name: "Phoenix"))
