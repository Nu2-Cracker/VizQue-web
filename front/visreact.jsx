import React, { Component, Fragment, useEffect } from 'react';
import "core-js/stable";
import "regenerator-runtime/runtime";
import Graph from 'vis-react';
import options from './options.jsx';


export default class VisReact extends Component {
  setState(stateObj) {
    if (this.mounted) {
      super.setState(stateObj);

    }
  }

  componentWillMount() {
    this.mounted = true;

    return fetch("http://127.0.0.1:8353/vizque")
      .then((response) => response.json())
      .then((responseJson) => {
        this.setState({
          graph: responseJson.data[0]
        })
      })
  }

  constructor(props) {
    super(props);
    let newGraph = {
      "edges": [],
      "nodes": []
    };
    //this.state.graphで値をセットするのが理想かな
    this.state = {
      graph: newGraph,
      style: { width: "1500px", height: "800px" },
      network: null
    };
    this.redirectToLearn = this.redirectToLearn.bind(this);
    this.getNetwork = this.getNetwork.bind(this);
  }

  componentDidMount() {
    this.events = {
      click: function (event) {
        this.redirectToLearn(event);
      }
    };
    this.events.click = this.events.click.bind(this);
  }

  redirectToLearn(params) {
    //node click action
    let Pnode = params.nodes;
    let Gnode = this.state.graph.nodes;
    if(Pnode.length != 0){
      let Pindex = Pnode[0];
      Gnode.forEach((node) => {
        if(node.id == Pindex){
          window.open(node.url, '_blank')
          return true
        }
      })
    }
  }


  getNetwork(data) {
    this.setState({ network: data })
  };


  render() {
    return (
      <Fragment>
        <div className="vis-react-title">vis react</div>
        <Graph
          graph={this.state.graph}
          style={this.state.style}
          options={options}
          getNetwork={this.getNetwork}
          events={this.events}
          vis={(vis) => (this.vis = vis)}
        />
      </Fragment>
    );
  }
}






