# -*- coding: utf-8 -*-
"""
Created on Tue Jul 12 15:04:56 2016

@author: guttag, revised egrimson
"""

class Node(object):
    def __init__(self, name):
        """Assumes name is a string"""
        self.name = name
    def getName(self):
        return self.name
    def __str__(self):
        return self.name

class Edge(object):
    def __init__(self, src, dest, weight):
        """Assumes src and dest are nodes, weight is an integer"""
        self.src = src
        self.dest = dest
        self.weight = weight
    def getWeight(self):
        return self.weight
    def getSource(self):
        return self.src
    def getDestination(self):
        return self.dest
    def __str__(self):
        return self.src.getName() + '->' + self.dest.getName() + ' weight: ' + str(self.getWeight())
               
class Digraph(object):
    """edges is a dict mapping each node to a list of
    its children Edges"""
    def __init__(self):
        self.edges = {}
    def calculateWeightInPath(self, path):
        """
        Assumes path is an Array of Node.
        Returns: Integer, sum of the weight property in the Node Array
        """
        if path == None:
            return 0
        elif len(path) == 0:
            return 0
        else:
            print('path is ', path)
            result = 0
            for i in range(len(path) - 1):
                source = path[i]
                destination = path[i + 1]
                if destination != None:
                    edge = self.getEdge(source, destination)
                    result = result + edge.getWeight()
            return result
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
        self.edges[src].append(edge)
    def getEdge(self, source, destination):
        """
        Assumes source and destination are Nodes joined by an Edge.
        Returns: Edge joining source and destination if it exists.
        """
        src = self.getNode(source.getName())
        dest = self.getNode(destination.getName())
        if src == None:
            raise ValueError('Node not in Graph ',source)
        if dest == None:
            raise ValueError('Node not in Graph ',destination)
        print('get edges with source',src)
        edges = self.edges[src]
        for edge in edges:
            if edge.getDestination() == dest:
                print('found edge',edge)
                return edge
        raise ValueError('No Edge found between ',source, destination)
    def childrenOf(self, node):
        return map(lambda x: x.getDestination(), self.edges[node]) 
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
            edges = self.edges[src]
            for edge in edges:
                result = result + src.getName() + '->'\
                         + edge.getDestination().getName() + '\n'
        return result[:-1] #omit final newline

class Graph(Digraph):
    def addEdge(self, edge):
        Digraph.addEdge(self, edge)
        rev = Edge(edge.getDestination(), edge.getSource())
        Digraph.addEdge(self, rev)
    
def buildCityGraph(graphType):
    g = graphType()
    for name in ('Boston', 'Providence', 'New York', 'Chicago',
                 'Denver', 'Phoenix', 'Los Angeles'): #Create 7 nodes
        g.addNode(Node(name))
    g.addEdge(Edge(g.getNode('Boston'), g.getNode('Providence'), 3))
    g.addEdge(Edge(g.getNode('Boston'), g.getNode('New York'), 1))
    g.addEdge(Edge(g.getNode('Providence'), g.getNode('Boston'), 1))
    g.addEdge(Edge(g.getNode('Providence'), g.getNode('New York'), 1))
    g.addEdge(Edge(g.getNode('New York'), g.getNode('Chicago'), 1))
    g.addEdge(Edge(g.getNode('Chicago'), g.getNode('Denver'), 1))
    g.addEdge(Edge(g.getNode('Chicago'), g.getNode('Phoenix'), 10))
    g.addEdge(Edge(g.getNode('Denver'), g.getNode('Phoenix'), 1))
    g.addEdge(Edge(g.getNode('Denver'), g.getNode('New York'), 1))
    g.addEdge(Edge(g.getNode('Los Angeles'), g.getNode('Boston'), 1))
    return g


def printPath(path):
    """Assumes path is a list of nodes"""
    result = ''
    for i in range(len(path)):
        result = result + str(path[i])
        if i != len(path) - 1:
            result = result + '->'
    return result 

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
    
def shortestPath(graph, start, end, toPrint = False):
    """Assumes graph is a Digraph; start and end are nodes
       Returns a shortest path from start to end in graph"""
    return DFS(graph, start, end, [], None, toPrint)

def testSP(source, destination):
    
    sp = shortestPath(g, g.getNode(source), g.getNode(destination),
                      toPrint = True)
    if sp != None:
        print('Shortest path from', source, 'to',
              destination, 'is', printPath(sp))
    else:
        print('There is no path from', source, 'to', destination)

def DFSWeighed(graph, start, end, path, shortest, toPrint = False):
    """Assumes graph is a Digraph; start and end are nodes;
          path and shortest are lists of nodes
       Returns a shortest path from start to end in graph taking into account the weight in the edges"""
    path = path + [start]
    if toPrint:
        print('Current DFS path:', printPath(path))
    if start == end:
        return path
    for node in graph.childrenOf(start):
        if node not in path: #avoid cycles
            if shortest == None or graph.calculateWeightInPath(path) < graph.calculateWeightInPath(shortest):
                newPath = DFS(graph, node, end, path, shortest,
                              toPrint)
                if newPath != None:
                    shortest = newPath
        elif toPrint:
            print('Already visited', node)
    return shortest
    
def shortestPath(graph, start, end, toPrint = False):
    """Assumes graph is a Digraph; start and end are nodes
       Returns a shortest path from start to end in graph"""
    return DFS(graph, start, end, [], None, toPrint)

def testSP(source, destination):
    
    sp = shortestPath(g, g.getNode(source), g.getNode(destination),
                      toPrint = True)
    if sp != None:
        print('Shortest path from', source, 'to',
              destination, 'is', printPath(sp))
    else:
        print('There is no path from', source, 'to', destination)

g = buildCityGraph(Digraph)
print(g)
path = [Node('Boston'), Node('Providence'), Node('New York')]
weight = g.calculateWeightInPath(path)
#print('weight is ',weight)
testSP('Chicago', 'Boston')
#print()
#testSP('Boston', 'Phoenix')
#print()

printQueue = True 

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

def shortestPath(graph, start, end, toPrint = False):
    """Assumes graph is a Digraph; start and end are nodes
       Returns a shortest path from start to end in graph"""
    return BFS(graph, start, end, toPrint)
    
#testSP('Boston', 'Phoenix')
    
