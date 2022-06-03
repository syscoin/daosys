import { FunctionFragment, Interface, ParamType } from "@ethersproject/abi"
import { count } from "console"
import React, { FC, useEffect, useState } from "react"
import { Button, Card } from "react-bootstrap"

export interface ContractMethodProps {
    methodName: string,
    contractInterface: Interface
}

export const ContractMethod: FC<ContractMethodProps> = (props: ContractMethodProps) => {
    const [inputs, setInputs] = useState<ParamType[] | null>(null);
    const [outputs, setOutputs] = useState<{}>({});
    const [stateMutability, setStateMutability] = useState<string>('');
    const [params, setParams] = useState<any[]>([]);

    // const callMethod = async (params) => {

    // }

    const changeParamsState = (index: number, value: any) => {
        const paramsClone = params;

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
                <Card.Footer>
                    <Button variant="primary">
                        Execute

                    </Button>

                    <p>
                        {params.map((item, index) => <li key={`param-${index}`}>{item}</li>)}
                    </p>
                </Card.Footer>
            </Card>
        </>
    )
}