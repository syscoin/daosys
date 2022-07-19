import React, {FC} from "react"
import { Card } from "react-bootstrap"

export const RightBar: FC<{}> = () => {
    return  (
        <Card>
            <Card.Header>
                Deployed Contracts
            </Card.Header>
            <Card.Body>
                ...
            </Card.Body>
        </Card>
    )
}