import React from 'react';
import ReactDOM from 'react-dom/client';
import 'bootstrap/dist/css/bootstrap.min.css';
import { App } from './App';
import reportWebVitals from './reportWebVitals';
import { Config, DAppProvider, Localhost, Hardhat, Mainnet } from '@usedapp/core'

const config: Config = {
  readOnlyChainId: Mainnet.chainId,
  readOnlyUrls: {
    // [Hardhat.chainId]: "http://127.0.0.1:8545",
    [Mainnet.chainId]: "https://mainnet.infura.io/v3/0b2c497ed2cc49d4b2f327e712176cbb"
  },
  multicallAddresses: [
    // "0xdac17f958d2ee523a2206206994597c13d831ec7",
    Mainnet.multicallAddress
  ]
}

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);
root.render(
  <React.StrictMode>
    <DAppProvider config={config}>
      <App />
    </DAppProvider>

  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
