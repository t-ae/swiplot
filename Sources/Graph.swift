
public class Graph {
    
    let data: [(x: Double, y: Double)]
    var setting: Setting
    
    public init(_ data: [(x: Double, y: Double)]) {
        self.data = data
        self.setting = Setting()
    }
    
    public convenience init(x: [Double], y: [Double]) {
        self.init([(Double, Double)](zip(x, y)))
    }
    
    public convenience init(_ values: [Double]) {
        self.init(values.enumerated().map { (Double($0), $1) })
    }
    
    public func headerQuery() -> String {
        
        var ret = "'-' w \(setting.lineStyle.rawValue)"
        
        if let lineType = self.setting.lineType {
            ret += " lt \(lineType)"
        }
        
        ret += " lw \(setting.lineWidth)"
        
        if let pointType = self.setting.pointType {
            ret += " pt \(pointType)"
        }
        
        switch setting.lineStyle {
        case .points, .linesPoints:
            ret += " ps \(setting.pointSize)"
        default:
            break
        }
        
        
        if let color = self.setting.color {
            ret += " lc rgb '\(color.str)'"
        }
        
        if let title = self.setting.title {
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

extension Graph {
    struct Setting {
        var title: String?
        var color: Color?
        var lineStyle: LineStyle = .lines
        var lineWidth: Double = 1
        var pointSize: Double = 1
        var lineType: Int?
        var pointType: Int?
    }
}
