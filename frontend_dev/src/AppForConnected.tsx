import React, { FC, useState } from 'react'
import { Card, Col, Row } from 'react-bootstrap'
import { LeftBar } from './common/LeftBar'
import { Contract } from './common/Contract'
import { RightBar } from './common/RightBar'

export const AppForConnected: FC<{}> = () => {
    const [selectedContract, setSelectedContract] = useState<string>('');

    return (
        <>
            <Row className='mt-3'>
                <Col sm={3} md={3} xs={3}>
                    <LeftBar onSelected={(selected) => setSelectedContract(selected)} />
                </Col>
                <Col sm={7} md={7} xs={7}>
                    <Contract path={selectedContract}/>
                </Col>
                <Col sm={2} md={2} xs={2}>
                    <RightBar/>    
                </Col>
            </Row>
        </>
    )
}