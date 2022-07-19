import React, { FC } from "react";
import { Falsy } from "@usedapp/core/dist/esm/src/model/types";
import { ethers } from "ethers"

export interface OutputsPresenterProps {
    error: boolean,
    message?: any | Falsy,
    results: any | Falsy
}

export const OutputsPresenter: FC<OutputsPresenterProps> = (props) => {

    if (props.error) {
        return (<>
            <div className="alert alert-danger">
                <p>
                    {JSON.stringify(props.results, null, 4)}
                </p>
            </div>
        </>)
    }

    return (<>
        {(typeof props.results !== 'undefined' && props.results.length > 0) && <>
            <div className="alert alert-primary">
                <ul>
                    {props.results.map((item: any, index: number) => {

                        let value = props.results[index];

                        if (typeof value === 'object' && '_isBigNumber' in value) {
                            value = ethers.utils.formatUnits(value).toString()
                        }

                        if (typeof value === 'boolean') {
                            value = value === true ? 'true' : 'false';
                        }

                        return <li key={index}>
                            #{index} - {value}
                        </li>
                    })}
                </ul>
            </div>
        </>}

    </>)
}