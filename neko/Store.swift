import Foundation

enum Direction {
    case none
    case northWest
    case north
    case northEast
    case east
    case southEast
    case south
    case southWest
    case west
}

final class Store: ObservableObject {
    private var direction: Direction
    private var ticksSinceLastMove = 0

    @Published var nekoLoc: NSPoint = NSPoint(x: 0, y: 0)
    @Published var mouseLoc: NSPoint = NSPoint(x: 0, y: 0)
    @Published var tick: Int = 0
    @Published var anim: [NekoState] = [.idle]

    init(withMouseLoc mouseLoc: NSPoint, andNekoLoc nekoLoc: NSPoint) {
        self.mouseLoc = mouseLoc
        self.nekoLoc = nekoLoc
        self.direction = nextDirection(mouseLoc, nekoLoc)
    }

    func nextTick(_ newMouseLoc: NSPoint) -> NSPoint {
        tick += 1

        let newDirection = nextDirection(newMouseLoc, nekoLoc)
        if direction != newDirection {
            tick = 0
            if direction == .none {
                anim = [.alert]
            } else {
                anim = [.idle]
            }
            direction = newDirection
            ticksSinceLastMove = 0
            return nekoLoc
        }

        if mouseLoc == newMouseLoc {
            ticksSinceLastMove += 1
        }

        switch direction {
        case .none:
            anim = [.idle]

            if ticksSinceLastMove > 33 {
                anim = [.sleeping1, .sleeping1, .sleeping1, .sleeping1, .sleeping2, .sleeping2, .sleeping2, .sleeping2]
            } else if ticksSinceLastMove > 31 {
                anim = [.yawning, .yawning]
            } else if ticksSinceLastMove > 16 {
                anim = [.idle]
            } else if ticksSinceLastMove > 8 {
                anim = [.grooming1, .grooming2]
            }
        case .northWest:
            anim = [.movingNorthWest1, .movingNorthWest2]
            nekoLoc = move(-1, 1)
        case .north:
            anim = [.movingNorth1, .movingNorth2]
            nekoLoc = move(0, 1)
        case .northEast:
            anim = [.movingNorthEast1, .movingNorthEast2]
            nekoLoc = move(1, 1)
        case .east:
            anim = [.movingEast1, .movingEast2]
            nekoLoc = move(1, 0)
        case .southEast:
            anim = [.movingSouthEast1, .movingSouthEast2]
            nekoLoc = move(1, -1)
        case .south:
            anim = [.movingSouth1, .movingSouth2]
            nekoLoc = move(0, -1)
        case .southWest:
            anim = [.movingSouthWest1, .movingSouthWest2]
            nekoLoc = move(-1, -1)
        case .west:
            anim = [.movingWest1, .movingWest2]
            nekoLoc = move(-1, 0)
        }

        mouseLoc = newMouseLoc
        return nekoLoc
    }

    private func move(_ xSteps: CGFloat, _ ySteps: CGFloat) -> NSPoint {
        return NSPoint(x: nekoLoc.x + CGFloat(step) * xSteps, y: nekoLoc.y + CGFloat(step) * ySteps)
    }
}

private let step: CGFloat = 16

private func nextDirection(_ mouseLoc: NSPoint, _ nekoLoc: NSPoint) -> Direction {
    let d = delta(nekoLoc, mouseLoc)
    if d.x >= 1 {
        if d.y > -1 && d.y < 1 {
            return .west
        } else if d.y >= 1 {
            return .southWest
        } else {
            return .northWest
        }
    } else if d.x <= -1 {
        if d.y > -1 && d.y < 1 {
            return .east
        } else if d.y >= 1 {
            return .southEast
        } else {
            return .northEast
        }
    } else {
        if d.y > -1 && d.y < 1{
            return .none
        } else if d.y >= 1 {
            return .south
        } else {
            return .north
        }
    }
}

private func delta(_ p1: NSPoint, _ p2: NSPoint) -> NSPoint {
    return NSPoint(x: (p1.x - p2.x) / step, y: (p1.y - p2.y) / step)
}
