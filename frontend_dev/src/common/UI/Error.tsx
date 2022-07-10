import { Falsy } from "@usedapp/core/dist/esm/src/model/types";
import React, { FC, useEffect, useState } from "react"

export interface ErrorPropsInterface {
    message: string | Falsy,
    hideAfter?: number,
    onHide: () => {}
}

export const Error: FC<ErrorPropsInterface> = ({message, hideAfter = 3, onHide = () => {}}) => {

    const [show, setShow] = useState<boolean>(false);

    useEffect(() => {
        setShow(true)

        const tm = setTimeout(() => {
            
            setShow(false);

            clearTimeout(tm)


            onHide();
        }, hideAfter * 1000)


    }, [message, hideAfter])


    if (!show || String(message).length < 1 ) {
        return (<></>)
    }

    return (
        <>
            <div className="alert alert-danger mt-2 mb-2">
                {message}
            </div>
        </>
    )
}