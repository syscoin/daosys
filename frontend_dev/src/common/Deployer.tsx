import { ConstructorFragment, Interface, ParamType } from "@ethersproject/abi"
import { useEthers } from "@usedapp/core"
import { Contract, ContractFactory } from "ethers"
import React, { FC, useEffect, useState } from "react"
import { Button, Modal, ModalBody, ModalDialog, ModalHeader, ModalFooter } from "react-bootstrap"

enum ButtonLabelType {
    Deploy = "Deploy",
    Deploying = "Deploying",
    Deployed = "Deployed",
    NotDeployed = "Not Deployed"
}

export interface DeployerProps {
    contractInterface: Interface,
    bytecode: string
}

interface InputFragmentProps {
    inputParam: ParamType,
    onChange: (e: React.ChangeEvent<HTMLInputElement>) => void
}

const InputFragment = ({ inputParam, onChange }: InputFragmentProps) => {
    return (
        <div className="form-group mt-3">
            <label htmlFor={`param-${inputParam.name}`}>
                {inputParam.name}
            </label>
            <input className='form-control' id={`param-${inputParam.name}`} onChange={(e) => onChange(e)} defaultValue='' />
        </div>
    )
}

export const Deployer: FC<DeployerProps> = ({ contractInterface, bytecode }) => {
    const [buttonLabel, setButtonLabel] = useState<ButtonLabelType>(ButtonLabelType.Deploy)
    const [showModal, setShowModal] = useState<boolean>(false);
    const [constructorFragment, setContstructorFragment] = useState<ConstructorFragment | null>(null);
    const [params, setParams] = useState<any[]>([])
    const [deployedAddress, setDeployedAddress] = useState<string>('');


    useEffect(() => {
        setContstructorFragment(contractInterface.deploy);

        const paramsBook = [];

        setParams([]);

        for (const item of contractInterface.deploy.inputs) {
            paramsBook.push(null);
        }

        setParams(paramsBook);

    }, [contractInterface])

    const { library } = useEthers();

    const hideModalAction = () => setShowModal(false);
    const showModalAction = () => setShowModal(true);

    const updateParams = (value: string, index: number) => {
        const clonedParams = [...params];

        clonedParams[index] = value;

        setParams(clonedParams);
    }


    const runDeployContract = async () => {

        if (library) {
            const factory = new ContractFactory(
                contractInterface,
                bytecode,
                library.getSigner()
            )

            const deployedContract: Contract = await factory.deploy(...params)

            if (deployedContract) {
                setDeployedAddress(deployedContract.address)
            }
        }
    }




    return (
        <>
            <Modal show={showModal} onHide={hideModalAction}>
                <Modal.Header closeButton>
                    <Modal.Title>Deploy Contract</Modal.Title>
                </Modal.Header>

                <Modal.Body>
                    {
                        constructorFragment && <>
                            {constructorFragment.inputs.length > 0 &&
                                Object.keys(constructorFragment.inputs).map((value, index) => {
                                    return (<InputFragment key={`input-param-${index}`}
                                        inputParam={constructorFragment.inputs[index]}
                                        onChange={(e: React.ChangeEvent<HTMLInputElement>) => {
                                            updateParams(e.target.value, index);
                                        }}
                                    />)
                                })
                            }
                        </>
                    }
                </Modal.Body>

                <Modal.Footer>
                    <Button variant="primary" onClick={runDeployContract}>{buttonLabel}</Button>
                </Modal.Footer>
            </Modal>

            <Button onClick={showModalAction}>
                Deploy
            </Button>
        </>
    )
}

function e(e: any): React.ChangeEventHandler<HTMLInputElement> | undefined {
    throw new Error("Function not implemented.")
}
