import { FunctionFragment, Interface, ParamType } from "@ethersproject/abi"
import { useEthers } from "@usedapp/core"
import { Falsy } from "@usedapp/core/dist/esm/src/model/types"
import { Contract } from "ethers"
import React, { FC, useEffect, useState } from "react"
import { Button, Card, Col, Row } from "react-bootstrap"
import { OutputsPresenter, OutputsPresenterProps } from "./OutputsPresenter"

export interface ContractMethodProps {
    methodName: string,
    contractInterface: Interface,
    contractInstance: Contract
}

export const ContractMethod: FC<ContractMethodProps> = (props: ContractMethodProps) => {
    const [inputs, setInputs] = useState<ParamType[] | null>(null);
    const [outputs, setOutputs] = useState<{}>({});
    const [stateMutability, setStateMutability] = useState<string>('');
    const [params, setParams] = useState<any[]>([]);
    const [errorDetails, setErrorDetails] = useState<string>('');
    const [results, setResults] = useState<{ error: boolean, message?: any | Falsy, results: any | Falsy } | Falsy>(null);

   
    const { library } = useEthers();


    const execute = async () => {

        const contract = props.contractInstance;
        console.log(contract);
        console.log(props.methodName)
        let funcName = props.methodName.substring(0, props.methodName.indexOf('(')) ?? props.methodName;

        if (funcName === '' ) {
            funcName = props.methodName
        }

        console.log(funcName)
        try {
            const response = await contract.functions[funcName](...params)
            setResults({ error: false, results: response });
        } catch (e) {
            console.log(e)
            setResults({ error: true, results: e });
        }



        // console.log(props.contractInstance.address);

        // console.log("Executing method. "+ props.methodName.substring(0, props.methodName.indexOf('(')));

        // if (params.length > 0) {

        //     console.log(params);

        //     await send(...params)
        // } else {
        //     await send();
        // }

    }

    const changeParamsState = (index: number, value: any) => {
        const paramsClone = [...params];

        paramsClone[index] = value

        setParams(paramsClone);
    }

    useEffect(() => {
        const _function: FunctionFragment = props.contractInterface.getFunction(props.methodName);

        setInputs(_function.inputs)
        setOutputs(_function.outputs ?? {})
        setStateMutability(_function.stateMutability);

        if (_function.inputs.length > 0) {
            const _params = [];
            for (const inputItem of _function.inputs) {
                _params.push(null);
            }

            setParams(_params);
        }
    }, [props]);

    return (
        <>
            <Card className="mt-3">
                <Card.Header>
                    {props.methodName} <i>{stateMutability}</i>
                </Card.Header>
                {(inputs && inputs.length > 0) && <>
                    <Card.Body>
                        {inputs?.map((item, index) => {

                            return (
                                <div className="form-group" key={`inputMethod-${props.methodName}-${index}`}>
                                    <label htmlFor={`inputMethod-${props.methodName}-${index}`}
                                    >
                                        {item.name} ({item.baseType})
                                    </label>
                                    <input id={`inputMethod-${props.methodName}-${index}`} type="text" className="form-control"
                                        onChange={(e: any) => {
                                            console.debug(e.target.value)
                                            changeParamsState(index, e.target.value)
                                        }}
                                    />
                                </div>
                            )
                        })}
                    </Card.Body>
                </>}
                <Card.Footer>

                    {errorDetails.length > 3 && <>
                        <div className="alert alert-danger">
                            {errorDetails}
                        </div>
                    </>}

                    <Button variant="primary" onClick={() => execute()}>
                        Execute

                    </Button>
                    <hr />
                    <Row>
                        <Col sm={12}>
                            <h4>Input</h4>
                            <ul>
                                {params.map((item, index) => <li key={`param-${index}`}>{item}</li>)}
                            </ul>
                        </Col>
                    </Row>
                    <Row>
                        <Col sm={12}>
                            <h4>Output</h4>
                            <OutputsPresenter {...results as OutputsPresenterProps} />
                        </Col>
                    </Row>

                </Card.Footer>
            </Card>
        </>
    )
}