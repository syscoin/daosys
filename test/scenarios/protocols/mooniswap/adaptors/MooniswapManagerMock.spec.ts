/**
 * 
 * Mooniswap manager mock spec test.
 * 
 * 
 */

import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { deploy } from "@openzeppelin/hardhat-upgrades/dist/utils";
import { expect } from "chai";
import { ethers } from "hardhat";
import { ERC20, ERC20Managed, ERC20ManagedMock, ERC20ManagedMock__factory, ERC20Managed__factory, ERC20__factory, MooniFactory, Mooniswap, MooniswapManagerInternal, MooniswapManagerInternalMock, MooniswapManagerInternalMock__factory, MooniswapManagerInternal__factory, MooniswapManagerMock, MooniswapManagerMock__factory, WETH9 } from "../../../../../typechain";
import { MooniswapManagerInterface } from "../../../../../typechain/contracts/protocols/mooniswap/adaptors/liquidity/MooniswapManager";
import { createMooniswapPair, initializeMooniswap } from "../../../../fixtures/mooniswap.fixture";
import { deployWETH9 } from "../../../../fixtures/weth9";

describe("MooniswapManagerMock", async () => {
    let deployer: SignerWithAddress;
    let weth9: WETH9;
    let stablecoin: ERC20ManagedMock;
    let mooniswap: MooniFactory;
    let mooniswapPair0: Mooniswap;
    let manager: MooniswapManagerInternalMock;

    beforeEach(async () => {
        const signers = await ethers.getSigners();

        deployer = signers[0]

        weth9 = await deployWETH9(deployer, ethers.utils.parseEther("10000000"));

        const stablecoinFactory: ERC20ManagedMock__factory = new ERC20ManagedMock__factory(deployer);
        stablecoin = await stablecoinFactory.deploy(
            "STABLE",
            "STABLE",
            18,
            ethers.utils.parseEther("1000000")
        );

        await stablecoin.deployed();

        mooniswap = await initializeMooniswap({
            deployer: deployer
        });

        mooniswapPair0 = await createMooniswapPair({
            token0: weth9,
            token1: stablecoin,
            factory: mooniswap
        })

        const managerFactory: MooniswapManagerInternalMock__factory = new MooniswapManagerInternalMock__factory(deployer);

        manager = await managerFactory.deploy(
            mooniswap.address,
            mooniswapPair0.address
        );
    });


    describe("::contractDetails", async () => {

        beforeEach(async () => {}) 

        it("all contracts has correct addresses", async () => {
            expect(weth9.address).is.properAddress;
            expect(stablecoin).is.properAddress;
            expect(mooniswap).is.properAddress;
            expect(mooniswapPair0).is.properAddress;
            expect(manager).is.properAddress;
        });
    });

    describe("::views", async () => {
        // it("::getMooniswapFactoryAddress()", async () => {
        //     // @ts-ignore
        //     expect(await manager.functions['getMooniswapFactoryAddress']()).is.properAddress;
        // });
    })
});