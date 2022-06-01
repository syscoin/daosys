import React, { FC, useEffect, useState } from "react";
import { Button, Card } from "react-bootstrap";
import { json } from "stream/consumers";

export type LeftBarCallbackOnSelected = (selectedElement: string) => void;

export interface LeftBarProps {
    onSelected: LeftBarCallbackOnSelected
}


export interface APIResponseResult {
    basename: string,
    fullPath: string
}


export const LeftBar: FC<LeftBarProps> = (props) => {
    const [contracts, setContracts] = useState<APIResponseResult[] | null>(null);
    const [filteredContracts, setFilteredContracts] = useState<APIResponseResult[] | null>(null);
    const [searchCriteria, setSearchCriteria] = useState<string>('');

    useEffect(() => {
        const filteredPrep: APIResponseResult[] = [];

        if (null === contracts) {
            return;
        }

        for (const item of contracts) {
            if (item.basename.toLowerCase().includes(searchCriteria)) {
                filteredPrep.push(item);
            }
        }

        setFilteredContracts(filteredPrep)


    }, [searchCriteria]);

    useEffect(() => {

        const loadContractsList = async () => {
            const data = await fetch('http://localhost:4545/abi/contracts')
            const json = await data.json();

            return json;
        }

        loadContractsList().then(json => {
            setContracts(json)
            setFilteredContracts(json)
        }).catch(e => console.debug(e));
    }, []);


    return (

        <>
            <Card>
                <Card.Header>
                    <input value={searchCriteria} placeholder="Search for contracts" type="text" className="form-control" id="inputSearchContractsLeftBar" onChange={(e) => setSearchCriteria(e.target.value)} />
                </Card.Header>
                <Card.Body>

                    {filteredContracts && filteredContracts.map((item, index) => {
                        return <div key={'lbar' + index}>
                            <Button variant="default" onClick={() => props.onSelected(item.fullPath)}>{item.basename}</Button>
                            <hr />
                        </div>
                    })}
                </Card.Body>
            </Card>
        </>
    )
}