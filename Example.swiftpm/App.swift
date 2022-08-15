import SwiftUI
import SwiftUIWorkaround

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Button {
                    isPresented = true
                } label: {
                    Text("ColorScheme")
                }
            }
        }.sheet(isPresented: $isPresented) {
            ColorSchemeView()
        }
    }
}

struct ColorSchemeView: View {
    @State var colorScheme: ColorScheme? = nil
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker(selection: $colorScheme) {
                        Text("Light").tag(Optional<ColorScheme>.some(.light))
                        Text("Dark").tag(Optional<ColorScheme>.some(.dark))
                        Text("Auto").tag(Optional<ColorScheme>.none)
                    } label: {
                        Text("Appearance")
                    }
                } footer: {
                    Text("preferredColorScheme = auto is not working on sheet after changed.")
                }

            }
        }
        .workaround.preferredColorScheme($colorScheme)
    }
}
