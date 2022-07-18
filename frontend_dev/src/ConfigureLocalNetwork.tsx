import React, { FC } from "react"
import { Button } from "react-bootstrap"
import { Hardhat, useEthers, useNetwork } from "@usedapp/core"
import { ethers } from "ethers"

const _localNetwork = {
    chainId: "0x7a69",
    chainName: 'Hardhat testnet',
    nativeCurrency: {
        name: 'ETH',
        symbol: 'ETH',
        decimals: 18
    },
    rpcUrls: ['http://127.0.0.1:8545'],
    blockExplorerUrls: ['http://127.0.0.1:8545/exp/']
}

export const ConfigureLocalNetwork: FC<{}> = () => {

    const { library } = useEthers();

    const addNetwork = async () => {
        if (library) {
            const result = await library?.send(
                "wallet_addEthereumChain",
                [
                    _localNetwork
                ]
            );
            console.log(result);
        } else {
            console.warn("No library")
        }

        
    };

    return (
        <Button variant="primary" className="mt-3" onClick={() => addNetwork()}>
            Add local network to Metamask
        </Button>
    )
}