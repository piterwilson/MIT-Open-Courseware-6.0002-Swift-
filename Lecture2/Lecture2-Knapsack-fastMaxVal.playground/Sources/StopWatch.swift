import Foundation

/// A simple Util class to measure the amount of seconds passed between 2 points in time.
public class StopWatch {
    /// Point in time at which `start()` was called.
    private(set) var startTime: Date?
    public init() {}
    /// Start measurement of time.
    public func start() {
        startTime = Date()
    }
    /// returns amount of seconds passed since `start()` was called.
    public func mark() -> TimeInterval {
        guard let startTime = startTime else {
            print("StopWatch Error: must call `start()` first.")
            return 0.0
        }
        return (-1 * startTime.timeIntervalSinceNow)
    }
    /// Sets the value of `startTime` to `nil`. After `reset()`, `start()` must be called again to get a measurement using `mark()`
    public func reset() {
        startTime = nil
    }
}
