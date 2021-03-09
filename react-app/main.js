import React from 'react';
import ReactDOM from 'react-dom';
import { ThemeProvider } from "@chakra-ui/react";

import VisReact from './visreact';

import "./css/style.css"
import Querys from './Form.js';

function App() {
  return (
    <div>
      <ThemeProvider>
        <Querys />
      </ThemeProvider>
      <div className="vis-react">
        <VisReact />
      </div>
    </div>

  )
}



const rootElement = document.getElementById("root");
ReactDOM.render(<App />, rootElement);

// ReactDOM.render(<App />, document.getElementById('app'));