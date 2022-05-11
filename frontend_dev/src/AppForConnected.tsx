import React, { FC } from 'react'
import { Card, Col, Row } from 'react-bootstrap'
import { CommonSettings } from './common/CommonSettings'
import { Contracts } from './common/Contracts'

export const AppForConnected: FC<{}> = () => {
    return (
        <>
            <Row className="mt-2">
                <Col sm={6} md={6}>
                    <Contracts />
                </Col>
                <Col sm={6} md={6}>
                    <CommonSettings/>    
                </Col>
            </Row>
        </>
    )
}