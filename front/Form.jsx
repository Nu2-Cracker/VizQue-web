//検索クエリの取得
import React, { useEffect } from "react";

import {
  Input,
  InputGroup
} from "@chakra-ui/react";


const QueryContext = React.createContext({
  query: "", fetchQuery: () => { }
})

function GetQuery() {
  const [item, setItem] = React.useState("")
  const [level, setLevel] = React.useState("")
  const { query, fetchQuery } = React.useContext(QueryContext)

  const handleInput = event => {
    setItem(event.target.value)
  }

  const handleSelect = event => {
    setLevel(event.target.value)
  }



  const handleSubmit = (event) => {
    const newQuery = { "data": item, "level": level}
    fetch("http://127.0.0.1:8353/vizque", {
      method: "POST",
      headers: { "Context-Type": "application/json" },
      body: JSON.stringify(newQuery)
    }).then(fetchQuery)
  }

  return (
    <form onSubmit={handleSubmit}>
      <InputGroup size="md">
        <Input
          pr="4.5rem"
          type="text"
          placeholder="Add a search query"
          aria-label="Add a search query"
          onChange={handleInput}
        />
        <select onChange={handleSelect}>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
        </select>
        <button type="submit">Show</button>
      </InputGroup>
    </form>
  )
}

export default function Querys() {
  return (
      <GetQuery />
  )
}