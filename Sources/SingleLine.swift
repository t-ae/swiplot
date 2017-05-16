public func plot(_ values: [Double]) {
    let graph = Line(values: values)
    
    let plot = Plot()
    
    plot.addGraph(graph)
    plot.plot()
}

public func scatter(_ data: [(x: Double, y: Double)]) {
    let graph = Scatter(data: data)
    
    let plot = Plot()
    
    plot.addGraph(graph)
    plot.plot()
}

public func scatter(x: [Double], y: [Double]) {
    let graph = Scatter(x: x, y: y)
    
    let plot = Plot()
    
    plot.addGraph(graph)
    plot.plot()
}
