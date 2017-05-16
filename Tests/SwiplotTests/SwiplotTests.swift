import XCTest
@testable import Swiplot

class SwiplotTests: XCTestCase {
    #if !SWIFT_PACKAGE
    func testExample() {
        let plot = Plot()
        
        plot.setting.xrange = (-10, 10)
        plot.setting.xlabel = "hoge"
        plot.setting.pointsize = 2
        
        let scatter1 = Scatter(title: "scatter1", data: [(1, 2), (2, 1), (3, 5), (4, 1), (2, 3)], color: .black)
        plot.addGraph(scatter1)
        
        let scatter2 = Scatter(title: "scatter2", data: [(3, 3), (1,5), (-1, 2), (4, 2)], color: .cyan)
        plot.addGraph(scatter2)
        
        let line = Line(title: "line", data: [(0, 0), (1, 2), (2, 1), (3, 3)], color: .red)
        plot.addGraph(line)
        
        plot.plot()
    }
    #endif
}
