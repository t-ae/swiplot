public func plot(_ values: [Double]) {
    let graph = Graph(values)
    graph.setting.lineStyle = .lines
    
    let plot = Plot()
    
    plot.addGraph(graph)
    plot.plot()
}

public func plot(x: [Double], y: [Double]) {
    let graph = Graph(x: x, y: y)
    graph.setting.lineStyle = .lines
    
    let plot = Plot()
    
    plot.addGraph(graph)
    plot.plot()
}

public func scatter(_ data: [(x: Double, y: Double)]) {
    let graph = Graph(data)
    graph.setting.lineStyle = .points
    
    let plot = Plot()
    
    plot.addGraph(graph)
    plot.plot()
}

public func scatter(x: [Double], y: [Double]) {
    let graph = Graph(x: x, y: y)
    graph.setting.lineStyle = .points
    
    let plot = Plot()
    
    plot.addGraph(graph)
    plot.plot()
}
