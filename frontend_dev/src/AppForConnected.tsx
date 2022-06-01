import React, { FC, useState } from 'react'
import { Card, Col, Row } from 'react-bootstrap'
import { LeftBar } from './common/LeftBar'
import { Contract } from './common/Contract'

export const AppForConnected: FC<{}> = () => {
    const [selectedContract, setSelectedContract] = useState<string>('');

    return (
        <>
            <Row className='mt-3'>
                <Col sm={4} md={4} xs={4}>
                    <LeftBar onSelected={(selected) => setSelectedContract(selected)} />
                </Col>
                <Col sm={8} md={8} xs={8}>
                    <Contract path={selectedContract}/>
                </Col>
            </Row>
        </>
    )
}