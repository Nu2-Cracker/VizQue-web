import React from 'react';
import ReactDOM from 'react-dom';
import VisReact from './visreact';

import "./css/style.css"
import AppForm from './Form.jsx';

function App(){
  return (
    <div className="vis-react">
      <VisReact />
    </div>
  )
}

// function Form(){
//   return (
//     <div className="apps-Form">
//       <AppForm />
//     </div>
//   )
// }

const FormSearch =  document.getElementById("research-form")
ReactDOM.render(<AppForm />, FormSearch)

const rootElement = document.getElementById("root");
ReactDOM.render(<App />, rootElement);

// ReactDOM.render(<App />, document.getElementById('app'));