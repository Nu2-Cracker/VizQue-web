let options = {
  layout: {
    randomSeed: 350,
    hierarchical: true
  },
  nodes: {
    shape: "box",
    size: 30,
    borderWidth: 1.5,
    borderWidthSelected: 2,
    font: {
      size: 12,
      align: "center",
      bold: {
        color: "#bbbdc0",
        size: 25,
        vadjust: 0,
        mod: "bold"
      }
    }
  },
  edges: {
    length: 10500000,
    width: 0.5,
    color: {
      color: "#D3D3D3",
    },
    arrows: {
      to: { enabled: true, scaleFactor: 1, type: "arrow" },
      middle: { enabled: false, scaleFactor: 100, type: "arrow" },
      from: { enabled: true, scaleFactor: 1, type: "arrow" }
    }
  },
  physics: {
    enabled: false,
    maxVelocity: 146,
    solver: "repulsion",
    repulsion: {
      nodeDistance: 1000000 // Put more distance between the nodes.
    },
    timestep: 0.35,
    stabilization: { iterations: 15000 },
  },
  interaction: {
    hover: true,
    hoverConnectedEdges: true,
    hoverEdges: true,
    selectable: false,
    selectConnectedEdges: false,
    zoomView: true,
    dragView: true
  }
};