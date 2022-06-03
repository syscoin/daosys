import React, {FC} from "react"
import { Card } from "react-bootstrap";

export const CommonSettings : FC<{}> = () => {
    return (
        <>
            <Card>
                <Card.Header>
                    Common Settings    
                </Card.Header>
                <Card.Body>
                    <p>
                        Common test page settings.
                    </p>    
                </Card.Body>    
            </Card>  
        </>
    );
}