import React, { FC } from "react";
import { Falsy } from "@usedapp/core/dist/esm/src/model/types";

export interface OutputsPresenterProps {
    error: boolean,
    message?: any | Falsy,
    results: any | Falsy
}

export const OutputsPresenter: FC<OutputsPresenterProps> = (props) => {

    if (props.error) {
        return (<>
            <div className = "alert alert-danger">
                <p>
                    {JSON.stringify(props.results, null , 4)}
                </p>    
            </div>
        </>)
    }

    return (<>
        <div className="alert alert-primary">
            
            {(typeof props.results !== 'undefined' && props.results.length > 0) && Object.keys(props.results).map( (item , index )=> {
                return <>
                    # {index} - {item}
                </>
            })}
        </div>
    </>)
}