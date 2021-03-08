//検索クエリの取得
import React, { Component, Fragment } from 'react';


export default class AppForm extends Component{
  constructor(props){
    super(props);

    this.state = {
      data: ""//初期値
    }
    this.updateState = this.updateState.bind(this);
    this.clickEvent = this.clickEvent.bind(this);
  };

  clickEvent(e){
    var query = this.state.data;
    console.log(query);
  }

  updateState(e){
    this.setState({data: e.target.value});
  }

  render(){
    return (
      <div>
        <Content FormDataProp = {this.state.data}
        updateStateProp = {this.updateState}
        clickEventProp = {this.clickEvent}></Content>
      </div>
    );
  }
}

class Content extends React.Component {
  render(){
    return(
      <div>
        <input type="text" value={this.props.FormDataProp}
        onChange={this.props.updateStateProp} />
        <button
        onClick={this.props.clickEventProp}
        value={this.props.FormDataProp}
        >SEARCH</button>
      </div>
    )
  }
}
