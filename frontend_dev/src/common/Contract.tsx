import { Interface } from "@ethersproject/abi";
import { Contract as eContract, ethers } from "ethers";
import React, { FC, useEffect, useState } from "react"
import { Card, Row } from "react-bootstrap";
import { ContractMethod } from "./ContractMethod";

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

    useEffect(() => {
        if (abiRaw !== null && '' !== deployedAddress) {
            const _interface = new ethers.utils.Interface(abiRaw.abi);

            const _tmpContract = new eContract(deployedAddress, _interface);

            setContract(_tmpContract);
            setCInterface(_interface)
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
                            <input onChange={(e) => setDeployedAddress(e.target.value)} type="text" id="contractAddress" className="form-control" placeholder="Enter deployed contract address." />
                        </Card.Footer>
                    </Card>


                    {(contract !== null && cInterface !== null) && <>
                        <Card className="mt-3">
                            <Card.Header>
                                Methods
                            </Card.Header>
                            <Card.Body>
                                {Object.keys(contract.functions).map((item, index) => {
                                    return <ContractMethod methodName={item} key={`contractMethod-${index}`} contractInterface={cInterface}/>
                                })}
                            </Card.Body>
                        </Card>
                    </>}



                </Card.Body>
            </Card>
        </>
    );
}