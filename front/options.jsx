let options = {
  layout: {
    randomSeed: 12,
    hierarchical: false
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
    barnesHut: {
      gravitationalConstant: -30000,
      centralGravity: 1,
      springLength: 150,
      avoidOverlap: -1
    },
    stabilization: { iterations: 2500 }
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