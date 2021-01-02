import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 16, height: 16),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false)
        window.level = NSWindow.Level.mainMenu
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.isReleasedWhenClosed = false
        window.ignoresMouseEvents = true
        window.center()

        let store = Store(withMouseLoc: NSEvent.mouseLocation, andNekoLoc: window.frame.origin)
            let contentView = ContentView(store: store)
        let hostingView = NSHostingView(rootView: contentView)
        Timer.scheduledTimer(withTimeInterval: 0.16, repeats: true) { _ in
            DispatchQueue.main.async {
                self.window.setFrameOrigin(store.nextTick(NSEvent.mouseLocation))
            }
        }

        window.backgroundColor = NSColor.init(calibratedRed: 1, green: 1, blue: 1, alpha: 0)
        window.contentView = hostingView
        window.makeKeyAndOrderFront(nil)
    }
}
