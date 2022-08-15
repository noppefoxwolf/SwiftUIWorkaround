# SwiftUIWorkaround

# Install

# Usage

## preferredColorScheme(_:)

`preferredColorScheme(nil)` is not working on sheet after changed.

`workaround.preferredColorScheme(_:)` changes all hierarcy appearance and working good with nil.

```swift
struct ColorSchemeView: View {
    @State var colorScheme: ColorScheme? = nil
    
    var body: some View {
        contentView
            .workaround.preferredColorScheme($colorScheme)
    }
}
```

# Autho
