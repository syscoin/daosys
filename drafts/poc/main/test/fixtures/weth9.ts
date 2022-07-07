import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { BigNumber } from "ethers";
import { ethers } from "hardhat";
import { WETH9 } from "../../typechain";

export const deployWETH9 = async (deployer: SignerWithAddress, initialAmount?: BigNumber): Promise<WETH9> => {
    const weth9Factory = await ethers.getContractFactory('WETH9');
    const weth9 = await weth9Factory.deploy();

    await weth9.deployed();

    console.log(`\u2705 WETH9 deployed to ${weth9.address}`);

    if (initialAmount) {
        await deployer.sendTransaction({ to: weth9.address, value: initialAmount });
        console.log(`   - initial amount of WETH9 was loaded.`);
    }

    return weth9;
}