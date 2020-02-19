import Foundation

//class Node(object):
//    def __init__(self, name):
//        """Assumes name is a string"""
//        self.name = name
//    def getName(self):
//        return self.name
//    def __str__(self):
//        return self.name

public struct Node: Hashable {
    public let name: String
    public init(name: String) {
        self.name = name
    }
}
