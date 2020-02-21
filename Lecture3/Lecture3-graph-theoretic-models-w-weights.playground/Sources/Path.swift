import Foundation

public enum PathError: Error {
    case disconnectedEdge(_ edge: Edge)
}

public struct Path {
    public private(set) var edges: [Edge]
    public private(set) var weight: Int = 0
    public init(edges: [Edge]) {
        self.edges = edges
    }
    private func isValid(edge: Edge) -> Bool {
        guard let last = self.edges.last else {
            return true
        }
        return last.destination == edge.source
    }
    public var count: Int {
        return edges.count
    }
    public mutating func append(edge: Edge) throws {
        guard isValid(edge: edge) else {
            throw PathError.disconnectedEdge(edge)
        }
        edges.append(edge)
        weight += edge.weight
    }
    
}

public func +(lhs: Path, rhs: Path) -> Path {
    Path(edges: lhs.edges + rhs.edges)
}

public func +(lhs: Path, rhs: [Node]) -> Path {
    Path(edges: lhs.edges)
}
