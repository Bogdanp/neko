import SwiftUI

struct NekoAnimation: View {
    @Binding var animation: [NekoState]
    @Binding var tick: Int

    var body: some View {
        Neko(state: $animation[tick % animation.count])
    }
}

struct NekoAnimation_Previews: PreviewProvider {
    static var previews: some View {
        NekoAnimation(
            animation: Binding.constant([.sleeping1, .sleeping2]),
            tick: Binding.constant(0)
        )
    }
}
