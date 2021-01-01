import SwiftUI

struct ContentView: View {
    @ObservedObject var store: Store

    var body: some View {
        NekoAnimation(
            animation: $store.anim,
            tick: $store.tick
        )
    }
}
