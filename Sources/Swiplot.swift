
import Foundation

public class Plot {
    
    public var setting = Setting()
    
    var graphs: [Graph] = []
    
    public func plot(gnuplotPath: String? = nil) {
        let process = Process()
        
        if let gnuplotPath = gnuplotPath {
            process.launchPath = gnuplotPath
            process.arguments = ["-persist"]
        } else {
            process.environment = ProcessInfo.processInfo.environment
            process.environment!["PATH"] = "/usr/local/bin:" + process.environment!["PATH"]!
            process.launchPath = "/usr/bin/env"
            
            process.arguments = ["gnuplot", "-persist"]
        }
        
        let stdin = Pipe()
        let stdout = Pipe()
        let stderr = Pipe()
        
        func query(_ str: String) {
            print(str)
            let str = str + "\n"
            stdin.fileHandleForWriting.write(str.data(using: .utf8)!)
        }
        
        process.standardInput = stdin
        process.standardOutput = stdout
        process.standardError = stderr
        
        stdout.fileHandleForReading.readabilityHandler = { h in
            print(String(data: h.availableData, encoding: .utf8)!)
        }
        stderr.fileHandleForReading.readabilityHandler = { h in
            print(String(data: h.availableData, encoding: .utf8)!)
        }
        
        process.launch()
        
        for q in setting.queries() {
            query(q)
        }
        
        let header = "plot " + graphs.map { $0.headerQuery() }.joined(separator: ", ")
        query(header)
        for graph in graphs {
            for q in graph.dataQueries() {
                query(q)
            }
        }
        query("exit")
    }
    
    public func addGraph(_ graph: Graph) {
        graphs.append(graph)
    }
}

public struct Setting {
    public var xlabel: String?
    public var ylabel: String?
    
    public var xrange: (Double, Double)?
    public var yrange: (Double, Double)?
    
    public var pointsize: Double?
    
    func queries() -> [String] {
        var ret: [String] = []
        
        if let xlabel = self.xlabel {
            ret.append("set xlabel '\(xlabel)'")
        }
        if let ylabel = self.ylabel {
            ret.append("set ylabel '\(ylabel)'")
        }
        
        if let xrange = self.xrange {
            ret.append("set xrange [\(xrange.0):\(xrange.1)]")
        }
        if let yrange = self.yrange {
            ret.append("set yrange [\(yrange.0):\(yrange.1)]")
        }
        
        if let pointsize = self.pointsize {
            ret.append("set pointsize \(pointsize)")
        }
        
        return ret
    }
}

public protocol Graph {
    func headerQuery() -> String
    func dataQueries() -> [String]
}

public struct Scatter: Graph {
    let title: String
    let data: [(x: Double, y: Double)]
    let color: Color?
    
    public init(title: String, data: [(x: Double, y: Double)], color: Color? = nil) {
        self.title = title
        self.data = data
        self.color = color
    }
    
    public init(title: String, x: [Double], y: [Double], color: Color? = nil) {
        self.init(title: title, data: zip(x, y).map { (x: $0, y: $1) }, color: color)
    }
    
    public init(title: String, values: [Double], color: Color? = nil) {
        self.init(title: title, data: values.enumerated().map { (x: Double($0), y: $1) }, color: color)
    }
    
    public func headerQuery() -> String {
        var ret = "'-' u 1:2 title '\(title)'"
        
        if let color = self.color {
            ret += " lc rgb '\(color.str)'"
        }
        
        return ret
    }
    
    public func dataQueries() -> [String] {
        return data.map { x, y in "\(x) \(y)" } + ["e"]
    }
}

public struct Line: Graph {
    let title: String
    let data: [(x: Double, y: Double)]
    let color: Color?
    
    init(title: String, data: [(x: Double, y: Double)], color: Color? = nil) {
        self.title = title
        self.data = data
        self.color = color
    }
    
    public init(title: String, x: [Double], y: [Double], color: Color? = nil) {
        self.init(title: title, data: zip(x, y).map { (x: $0, y: $1) }, color: color)
    }
    
    public init(title: String, values: [Double], color: Color? = nil) {
        self.init(title: title, data: values.enumerated().map { (x: Double($0), y: $1) }, color: color)
    }
    
    public func headerQuery() -> String {
        var ret = "'-' u 1:2 w line title '\(title)'"
        
        if let color = self.color {
            ret += " lc rgb '\(color.str)'"
        }
        
        return ret
    }
    
    public func dataQueries() -> [String] {
        return data.map { x, y in "\(x) \(y)" } + ["e"]
    }
}

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
