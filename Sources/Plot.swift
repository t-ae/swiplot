
import Foundation

public class Plot {
    
    public var setting = Setting()
    
    var graphs: [Graph] = []
    
    public func plot(gnuplotPath: String? = nil) {
        let process = Process()
        
        if let gnuplotPath = gnuplotPath {
            process.launchPath = gnuplotPath
            process.arguments = ["-p"]
        } else {
            process.environment = ProcessInfo.processInfo.environment
            process.environment!["PATH"] = "/usr/local/bin:" + process.environment!["PATH"]!
            process.launchPath = "/usr/bin/env"
            
            process.arguments = ["gnuplot", "-p"]
        }
        
        let stdin = Pipe()
        let stdout = Pipe()
        let stderr = Pipe()
        
        func query(_ str: String) {
            // print(str)
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
        
        let header = "plot " + graphs.map { $0.headerQuery() }.joined(separator: ", ") + "; pause mouse close; exit"
        query(header)
        for graph in graphs {
            for q in graph.dataQueries() {
                query(q)
            }
        }
    }
    
    public func addGraph(_ graph: Graph) {
        graphs.append(graph)
    }
}

extension Plot {
    public struct Setting {
        
        public var terminal: String?
        
        public var title: String?
        
        public var showGrid: Bool = false
        
        public var xlabel: String?
        public var ylabel: String?
        
        public var xrange: (Double, Double)?
        public var yrange: (Double, Double)?
        
        public var pointsize: Double?
        
        func queries() -> [String] {
            var ret: [String] = []
            
            if let terminal = self.terminal {
                ret.append("set term '\(terminal)'")
            }
            
            if let title = self.title {
                ret.append("set title '\(title)'")
            }
            
            if showGrid {
                ret.append("set grid")
            }
            
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
}


