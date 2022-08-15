import SwiftUI

public struct Workaround<V: View> {
    let base: V
}

extension View {
    public var workaround: Workaround<Self> {
        Workaround(base: self)
    }
}
