public func plot(_ values: [Double]) {
    let graph = Graph(values)
    graph.lineStyle = .lines
    
    let plot = Plot()
    
    plot.addGraph(graph)
    plot.plot()
}

public func plot(x: [Double], y: [Double]) {
    let graph = Graph(x: x, y: y)
    graph.lineStyle = .lines
    
    let plot = Plot()
    
    plot.addGraph(graph)
    plot.plot()
}

public func scatter(_ data: [(x: Double, y: Double)]) {
    let graph = Graph(data)
    graph.lineStyle = .points
    
    let plot = Plot()
    
    plot.addGraph(graph)
    plot.plot()
}

public func scatter(x: [Double], y: [Double]) {
    let graph = Graph(x: x, y: y)
    graph.lineStyle = .points
    
    let plot = Plot()
    
    plot.addGraph(graph)
    plot.plot()
}
