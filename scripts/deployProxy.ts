// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";
import {
    MessengerDelegateService,
    MessengerDelegateService__factory,
    ServiceProxyMock,
    ServiceProxyMock__factory
} from "../typechain"
import { InjectFrontend } from "./common/frontendInject";

async function main() {

    const [deployer] = await ethers.getSigners()
    const messenger: MessengerDelegateService = await new MessengerDelegateService__factory(deployer).deploy();


    const proxy: ServiceProxyMock = await new ServiceProxyMock__factory(deployer).deploy();


    const proxyAsMessenger: MessengerDelegateService = await ethers.getContractAt("MessengerDelegateService", proxy.address) as MessengerDelegateService;


    const contracts = {
        "messenger": messenger.address,
        "proxy": proxy.address,
        "proxyAsMessenger": proxyAsMessenger.address,
    };

    InjectFrontend(contracts, __dirname + "/../frontend_dev/src/contracts.json");
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
