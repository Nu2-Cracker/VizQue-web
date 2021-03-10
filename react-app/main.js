import React from 'react';
import ReactDOM from 'react-dom';
import { ThemeProvider } from "@chakra-ui/react";

import VisReact from './visreact.jsx';

import "./css/style.css"
import Querys from './Form.jsx';

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