public struct Color {
    let str: String
    
    init(_ str: String) {
        self.str = str
    }
    
    public init(red: UInt8, green: UInt8, blue: UInt8) {
        self.init(String(format: "#%02x%02x%02x", red, green, blue))
    }
}

extension Color {
    static let red = Color("red")
    static let green = Color("green")
    static let blue = Color("blue")
    static let black = Color("black")
    static let cyan = Color("cyan")
    static let magenta = Color("magenta")
    static let yellow = Color("yellow")
}
