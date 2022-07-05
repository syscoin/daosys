import React, {FC, useState} from "react"
import { Button } from "react-bootstrap"

enum ButtonLabelType {
    Deploy = "Deploy",
    Deploying = "Deploying",
    Deployed = "Deployed",
    NotDeployed = "NotDeployed"
}


export const Deployer: FC<{}> = () => {
    const [buttonLabel, setButtonLabel] = useState<ButtonLabelType>(ButtonLabelType.Deploy)


    return (
        <Button>
            {buttonLabel}
        </Button>
    )
}