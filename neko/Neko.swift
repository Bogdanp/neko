import SwiftUI

enum NekoState {
    case idle
    case alert
    case thinking
    case grooming1
    case grooming2
    case yawning
    case sleeping1
    case sleeping2
    case movingNorthWest1
    case movingNorthWest2
    case movingNorth1
    case movingNorth2
    case movingNorthEast1
    case movingNorthEast2
    case movingEast1
    case movingEast2
    case movingSouthEast1
    case movingSouthEast2
    case movingSouth1
    case movingSouth2
    case movingSouthWest1
    case movingSouthWest2
    case movingWest1
    case movingWest2
}

struct Neko: View {
    @Binding var state: NekoState

    var body: some View {
        Image("Neko")
            .frame(width: 16, height: 16, alignment: .topLeading)
            .offset(x: offset.x, y: offset.y)
    }

    private func sprite(_ col: Int, _ row: Int) -> NSPoint {
        return NSPoint(x: -1 * row * 16, y: -1 * col * 16)
    }

    private var offset: CGPoint {
        get {
            switch state {
            case .idle:
                return sprite(0, 4)

            case .alert:
                return sprite(0, 0)

            case .thinking:
                return sprite(0, 3)

            case .grooming1:
                return sprite(1, 3)
            case .grooming2:
                return sprite(2, 3)

            case .yawning:
                return sprite(1, 4)

            case .sleeping1:
                return sprite(4, 3)
            case .sleeping2:
                return sprite(4, 2)

            case .movingNorthWest1:
                return sprite(1, 5)
            case .movingNorthWest2:
                return sprite(2, 5)

            case .movingNorth1:
                return sprite(4, 4)
            case .movingNorth2:
                return sprite(0, 5)

            case .movingNorthEast1:
                return sprite(3, 5)
            case .movingNorthEast2:
                return sprite(4, 5)

            case .movingEast1:
                return sprite(3, 4)
            case .movingEast2:
                return sprite(2, 4)

            case .movingSouthEast1:
                return sprite(2, 1)
            case .movingSouthEast2:
                return sprite(2, 2)

            case .movingSouth1:
                return sprite(0, 1)
            case .movingSouth2:
                return sprite(1, 0)

            case .movingSouthWest1:
                return sprite(1, 2)
            case .movingSouthWest2:
                return sprite(2, 0)

            case .movingWest1:
                return sprite(3, 1)
            case .movingWest2:
                return sprite(3, 0)
            }
        }
    }
}

struct Neko_Previews: PreviewProvider {
    static var previews: some View {
        Neko(state: Binding.constant(.movingSouth2))
    }
}
