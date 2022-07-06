import { Interface } from "@ethersproject/abi";
import { connectContractToSigner, useEthers } from "@usedapp/core/dist/esm/src/hooks";
import { Contract as eContract, ethers } from "ethers";
import React, { FC, useEffect, useState } from "react"
import { Card, Col, Row } from "react-bootstrap";
import { ContractMethod } from "./ContractMethod";
import { Falsy } from "@usedapp/core/dist/esm/src/model/types";
import { Error } from "./UI/Error";
import { Deployer } from "./Deployer";

export interface ContractProps {
    path: string
}

export interface ArtifactInterface {
    _format: string,
    contractName: string,
    abi: [],
    bytecode: string,
    deployedBytecode: string,
    linkReferences: {},
    deployedLinkReferences: {}
}

export const Contract: FC<ContractProps> = ({ path }) => {

    const [abiRaw, setAbiRaw] = useState<ArtifactInterface | null>(null);
    const [contract, setContract] = useState<eContract | null>(null);
    const [cInterface, setCInterface] = useState<Interface | null>(null);
    const [deployedAddress, setDeployedAddress] = useState<string>('');
    const [errors, setErrors] = useState<string | Falsy>(null);

    const {library} = useEthers();


    useEffect(() => {
        if (abiRaw !== null && '' !== deployedAddress && library) {
            const _interface = new ethers.utils.Interface(abiRaw.abi);

            try {
                const _tmpContract = new eContract(deployedAddress, _interface);
                const connectedContract = connectContractToSigner(_tmpContract, undefined, library.getSigner())
                
                setContract(connectedContract);
                setCInterface(_interface)
            } catch (e) {
                setErrors(String(e))
            }
        }
    }, [abiRaw, deployedAddress]);

    useEffect(() => {
        const fetchAbi = async () => {
            const data = await fetch(`http://localhost:4545/abi/read?fullPath=${path}`)
            const json = await data.json();

            return json;
        }

        if ('' !== path) {
            fetchAbi().then((response) => {
                setAbiRaw(response)
                setDeployedAddress('')
                setContract(null)
                setCInterface(null)
            }).catch(e => console.debug(e));
        }
    }, [path]);


    if (null === abiRaw) {
        return (
            <>
                <Card>
                    <Card.Header>
                        Information
                    </Card.Header>
                    <Card.Body>
                        <div className="alert alert-danger">
                            <p>
                                Please select contract interface before interaction with it.
                            </p>
                        </div>
                    </Card.Body>
                </Card>
            </>
        )
    }



    return (
        <>
            <Card>
                <Card.Header>Contract interaction</Card.Header>
                <Card.Body>
                    <Card>
                        <Card.Header>
                            {abiRaw?.contractName}
                        </Card.Header>
                        <Card.Footer>
                            <Row>
                                <Col sm={3}>
                                    <Deployer/>    
                                </Col>
                            </Row>
                            <hr/>
                            {String(errors).length > 0 && <Error message={errors} hideAfter={3} onHide = {async () => setErrors('') }/>}
                            <input onChange={(e) => setDeployedAddress(e.target.value)} value={deployedAddress} type="text" id="contractAddress" className="form-control" placeholder="Enter deployed contract address." />
                        </Card.Footer>
                    </Card>


                    {(contract !== null && cInterface !== null) && <>
                        <Card className="mt-3">
                            <Card.Header>
                                Methods
                            </Card.Header>
                            <Card.Body>
                                {Object.keys(contract.functions).map((item, index) => {
                                    return <ContractMethod contractInstance={contract} methodName={item} key={`contractMethod-${index}`} contractInterface={cInterface}/>
                                })}
                            </Card.Body>
                        </Card>
                    </>}



                </Card.Body>
            </Card>
        </>
    );
}