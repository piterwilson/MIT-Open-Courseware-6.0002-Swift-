import Foundation
//class Edge(object):
//    def __init__(self, src, dest):
//        """Assumes src and dest are nodes"""
//        self.src = src
//        self.dest = dest
//    def getSource(self):
//        return self.src
//    def getDestination(self):
//        return self.dest
//    def __str__(self):
//        return self.src.getName() + '->' + self.dest.getName()

public struct Edge {
    public let source: Node
    public let destination: Node
    public init(source: Node, destination: Node) {
        self.source = source
        self.destination = destination
    }
}
