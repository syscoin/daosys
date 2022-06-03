import React, { FC } from 'react';
import './App.css';
import { Button, Col, Container, Row } from 'react-bootstrap';
import { useEthers } from '@usedapp/core';
import { AppForConnected } from './AppForConnected';
import { ConfigureLocalNetwork } from './ConfigureLocalNetwork';

export const App: FC<{}> = () => {
  const { account, activateBrowserWallet } = useEthers()

  

  return (
    <Container fluid>
      <Row>
        <Col sm={6}>
          <h1 className="mt-3">Contracts Playground.</h1>
        </Col>
        <Col sm={6}>
          <ConfigureLocalNetwork/>
        </Col>
      </Row>




      {!account && <>
        <Button variant='success' onClick={() => activateBrowserWallet()}>
          Connect wallet
        </Button>


      </>}

      {account && <>
        <AppForConnected />
      </>}

    </Container>
  )
}
