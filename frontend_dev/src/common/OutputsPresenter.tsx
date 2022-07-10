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
                    {Object.keys(props.results).map((item, index) => {

                        let value = props.results[item];

                        if (typeof value === 'object' && '_isBigNumber' in value) {
                            value = ethers.utils.formatUnits(value).toString()
                        }

                        return <li key={index}>
                            {value}
                        </li>
                    })}
                </ul>
            </div>
        </>}

    </>)
}