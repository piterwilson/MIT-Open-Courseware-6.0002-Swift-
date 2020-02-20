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
 def shortestPath(graph, start, end, toPrint = False):
     """Assumes graph is a Digraph; start and end are nodes
        Returns a shortest path from start to end in graph"""
     return BFS(graph, start, end, toPrint)
 */
func shortestpathBFS(graph: DiGraph, start: Node, end: Node) -> [Node]? {
    return BFS(graph: graph, start: start, end: end)
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
    let graph = buildCityGraphType(DiGraph.self)
    print("graph:")
    print("\(graph)")
    print("-> using DFS")
    stopWatch.start()
    if let sp = shortestpathDFS(graph: graph, start: source, end: destination), !sp.isEmpty {
        print("shortest path from \(source) to \(destination) is")
        print(path: sp)
        print("took \(stopWatch.mark()) secs")
    } else {
        print("There is no path from \(source) to \(destination)")
    }
    print("-> using BFS")
    stopWatch.start()
    if let sp = shortestpathBFS(graph: graph, start: source, end: destination), !sp.isEmpty {
        print("shortest path from \(source) to \(destination) is")
        print(path: sp)
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
                if shortest == nil || (shortest!.isEmpty || path.count < shortest!.count) {
                    if let newPath = DFS(graph: graph, start: node, end: end, path: pathCopy, shortest: &shortest) {
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
    return shortest
}

/**
 def BFS(graph, start, end, toPrint = False):
     """Assumes graph is a Digraph; start and end are nodes
        Returns a shortest path from start to end in graph"""
     initPath = [start]
     pathQueue = [initPath]
     while len(pathQueue) != 0:
         #Get and remove oldest element in pathQueue
         if printQueue:
             print('Queue:', len(pathQueue))
             for p in pathQueue:
                 print(printPath(p))
         tmpPath = pathQueue.pop(0)
         if toPrint:
             print('Current BFS path:', printPath(tmpPath))
             print()
         lastNode = tmpPath[-1]
         if lastNode == end:
             return tmpPath
         for nextNode in graph.childrenOf(lastNode):
             if nextNode not in tmpPath:
                 newPath = tmpPath + [nextNode]
                 pathQueue.append(newPath)
     return None
 */
func BFS(graph: DiGraph, start: Node, end: Node) -> [Node]? {
    var pathQueue: [[Node]] = [[start]]
    repeat {
        // Get and remove oldest element in pathQueue
        print("Queue:")
        pathQueue.forEach { print(path: $0) }
        let tmpPath = pathQueue.removeFirst()
        print("Current BFS path:")
        print(path: tmpPath)
        let lastNode: Node? = tmpPath.last
        if let lastNode = lastNode {
            if lastNode == end {
                return tmpPath
            }
            do {
                for nextNode in try graph.childrenOf(node: lastNode) {
                    if !tmpPath.contains(nextNode) {
                        let newPath = tmpPath + [nextNode]
                        pathQueue.append(newPath)
                    }
                }
            } catch {
                print(error)
            }
        }
    } while (!pathQueue.isEmpty)
    return nil
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
print(" --- test 1 ---")
testSP(source: Node(name: "Chicago"), destination: Node(name: "Boston"))
print(" --- test 2 ---")
testSP(source: Node(name: "Boston"), destination: Node(name: "Phoenix"))
