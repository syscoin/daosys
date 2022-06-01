import { Contract } from "ethers";
import { Interface } from "ethers/lib/utils";
import { stringify } from "querystring";
import React, { FC, useEffect, useState } from "react"
import { Row, Col, Card } from "react-bootstrap";

export interface CommonFormProps {
    contractLabel: string,
    contractABI?: Interface;


}

export const CommonForm: FC<CommonFormProps> = (props: CommonFormProps) => {

    const [contractAddress, setContractAddress] = useState<string>('');
    const [contractInstance, setContractInstance] = useState<Contract | null>(null);


    useEffect(() => {
        if (props.contractABI && contractAddress) {
            const _contract = new Contract(contractAddress, props.contractABI);
            setContractInstance(_contract);
        }
    }, [contractAddress]);




    return (
        <Card>
            <Card.Header>
                {props.contractLabel}
            </Card.Header>
            <Card.Body>
                <Row>
                    <Col sm={4} md={4}>
                        <input type={'text'} className={'form-control'} value={contractAddress} onChange={(e) => setContractAddress(e.target.value)} />
                    </Col>
                    <Col sm={4} md={4}>
                        <select>
                            <option value="">Select metohd</option>
                        </select>
                    </Col>
                </Row>
            </Card.Body>
        </Card>

    );
}