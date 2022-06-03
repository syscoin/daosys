import React, {FC } from "react"
import { Card, ListGroup, ListGroupItem } from "react-bootstrap"
import contracts from "../contracts.json"

export const Contracts:FC<{}> = () => {

    const _contractsList = Object.entries(contracts).map(([key, value]) => (
        <ListGroupItem key={key}>
            <b>{key}</b>: <i>{value}</i>
        </ListGroupItem>
    ))

    return (
        <>
            <Card>
                <Card.Header>
                    Contracts ENV
                </Card.Header>
                <Card.Body>
                    {_contractsList}
                </Card.Body>
            </Card>
        </>
    )
}