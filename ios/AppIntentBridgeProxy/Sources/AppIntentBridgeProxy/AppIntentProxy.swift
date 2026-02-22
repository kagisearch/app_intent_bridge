import SwiftUI

public class AppIntentProxy: @unchecked Sendable {
    public var callback: ((String, [String: Any]) -> Void)?

    public init() {}

    public func action(_ action: String, _ parameters: [String: Any] = [:]) {
        callback?(action, parameters)
    }
}
