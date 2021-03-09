//検索クエリの取得
import React, { useEffect, useState } from "react";
import "core-js/stable";
import "regenerator-runtime/runtime";
import {
  Box,
  Button,
  Flex,
  Input,
  InputGroup,
  Modal,
  ModalBody,
  ModalCloseButton,
  ModalContent,
  ModalFooter,
  ModalHeader,
  ModalOverlay,
  Stack,
  Text,
  useDisclosure
} from "@chakra-ui/react";

const QueryContext = React.createContext({
  query: [], fetchQuery: () => { }
})

function GetQuery() {
  const [item, setItem] = React.useState("")
  const { query, fetchQuery } = React.useContext(QueryContext)

  const handleInput = event => {
    setItem(event.target.value)
  }

  const handleSubmit = (event) => {
    const newQuery = {
      "data": item
    }

    fetch("http://127.0.0.1:8353/testquery", {
      method: "POST",
      headers: { "Context-Type": "application/json" },
      body: JSON.stringify(newQuery)
    }).then(fetchQuery)
      .then(data => console.log(data))
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
      </InputGroup>
    </form>
  )
}

export default function Querys() {
  const [query, setQuery] = useState([])
  const fetchQuery = async () => {
    const response = await fetch("http://127.0.0.1:8353/testquery")
    const query = await response.json()
    setQuery(query.data)
  }

  useEffect(() => {
    fetchQuery()
  }, [])

  return (
    <QueryContext.Provider value={{ query, fetchQuery }}>
      <GetQuery />
      <Stack spacing={5}>
        {query.map((q) => (
          <b>{q.data}</b>
        ))}
      </Stack>
    </QueryContext.Provider>
  )
}