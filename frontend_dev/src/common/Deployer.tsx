import React, {FC, useState} from "react"
import { Button } from "react-bootstrap"

enum ButtonLabelType {
    Deploy = "Deploy",
    Deploying = "Deploying",
    Deployed = "Deployed",
    NotDeployed = "Not Deployed"
}

export interface DeployerProps {
    path: string
}


export const Deployer: FC<DeployerProps> = ({path: string = ''}) => {
    const [buttonLabel, setButtonLabel] = useState<ButtonLabelType>(ButtonLabelType.Deploy)




    return (
        <Button>
            {buttonLabel}
        </Button>
    )
}