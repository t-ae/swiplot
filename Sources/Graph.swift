
enum LineStyle: String {
    case lines = "l"
    case linesPoints = "lp"
    case points = "p"
    case dots = "d"
}

public class Graph {
    
    let data: [(x: Double, y: Double)]
    
    var title: String?
    var color: Color?
    var lineStyle: LineStyle = .lines
    var lineWidth: Double = 1
    var pointSize: Double = 1
    var lineType: Int?
    var pointType: Int?
    
    public init(_ data: [(x: Double, y: Double)]) {
        self.data = data
    }
    
    public convenience init(x: [Double], y: [Double]) {
        self.init([(Double, Double)](zip(x, y)))
    }
    
    public convenience init(_ values: [Double]) {
        self.init(values.enumerated().map { (Double($0), $1) })
    }
    
    public func headerQuery() -> String {
        
        var ret = "'-' u 1:2 w \(lineStyle.rawValue)"
        
        if let lineType = self.lineType {
            ret += " lt \(lineType)"
        }
        
        ret += " lw \(lineWidth)"
        
        if let pointType = self.pointType {
            ret += " pt \(pointType)"
        }
        
        switch lineStyle {
        case .points, .linesPoints:
            ret += " ps \(pointSize)"
        default:
            break
        }
        
        
        if let color = self.color {
            ret += " lc rgb '\(color.str)'"
        }
        
        if let title = self.title {
            ret += " title '\(title)'"
        } else {
            ret += " notitle"
        }
        
        return ret
    }
    
    public func dataQueries() -> [String] {
        return data.map { x, y in "\(x) \(y)" } + ["e"]
    }
}
