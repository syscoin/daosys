/**
 * 
 * Mooniswap manager mock spec test.
 * 
 * 
 */

import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { deploy } from "@openzeppelin/hardhat-upgrades/dist/utils";
import { expect } from "chai";
import { BigNumberish } from "ethers";
import { ethers } from "hardhat";
import { ERC20, ERC20Managed, ERC20ManagedMock, ERC20ManagedMock__factory, ERC20Managed__factory, ERC20__factory, MooniFactory, Mooniswap, MooniswapManagerInternal, MooniswapManagerInternalMock, MooniswapManagerInternalMock__factory, MooniswapManagerInternal__factory, MooniswapManagerMock, MooniswapManagerMock__factory, WETH9 } from "../../../../../typechain";
import { MooniswapManagerInterface } from "../../../../../typechain/contracts/protocols/mooniswap/adaptors/liquidity/MooniswapManager";
import { addLiquidity, createMooniswapPair, initializeMooniswap } from "../../../../fixtures/mooniswap.fixture";
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

        weth9 = await deployWETH9(deployer, ethers.utils.parseEther("50"));

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

        it("all contracts has correct addresses", async () => {
            expect(weth9.address).is.properAddress;
            expect(stablecoin.address).is.properAddress;
            expect(mooniswap.address).is.properAddress;
            expect(mooniswapPair0.address).is.properAddress;
            expect(manager.address).is.properAddress;
        });

        it("factory and pair address match", async () => {
            expect(await manager.getMooniswapFactoryAddress()).equal(mooniswap.address);
            expect(await manager.getMooniswapPoolAddress()).equal(mooniswapPair0.address);
        })
    });

    describe("::workWithLiquidity", async () => {
        it("can provide liquidity for mooniswap", async () => {

            await weth9.connect(deployer).transfer(
                manager.address,
                ethers.utils.parseEther("10")
            );

            await stablecoin.connect(deployer).transfer(
                manager.address,
                ethers.utils.parseEther("10000")
            );
            
            await manager.connect(deployer).deposit(
                [weth9.address, stablecoin.address],
                [ethers.utils.parseEther("10"), ethers.utils.parseEther("1000")],
                [ethers.utils.parseEther("1"), ethers.utils.parseEther("1")]
            ).catch(e => console.error(e));
            
            // console.log(await mooniswapPair0.connect(deployer).balanceOf(manager.address));

            expect(await weth9.balanceOf(mooniswapPair0.address)).equal(ethers.utils.parseEther("10"));
            expect(await stablecoin.balanceOf(mooniswapPair0.address)).equal(ethers.utils.parseEther("1000"));
            expect(await mooniswapPair0.connect(deployer).balanceOf(manager.address)).equal(ethers.utils.parseEther("1000"));
        });


        it("can perform swap operation", async () => {

            await weth9.connect(deployer).transfer(
                manager.address,
                ethers.utils.parseEther("10")
            );

            await stablecoin.connect(deployer).transfer(
                manager.address,
                ethers.utils.parseEther("10000")
            );
            
            await manager.connect(deployer).deposit(
                [weth9.address, stablecoin.address],
                [ethers.utils.parseEther("10"), ethers.utils.parseEther("1000")],
                [ethers.utils.parseEther("1"), ethers.utils.parseEther("1")]
            ).catch(e => console.error(e));
            
            // console.log(await mooniswapPair0.connect(deployer).balanceOf(manager.address));

            expect(await weth9.balanceOf(mooniswapPair0.address)).equal(ethers.utils.parseEther("10"));
            expect(await stablecoin.balanceOf(mooniswapPair0.address)).equal(ethers.utils.parseEther("1000"));
            expect(await mooniswapPair0.connect(deployer).balanceOf(manager.address)).equal(ethers.utils.parseEther("1000"));

            // perform trade action

            await weth9.connect(deployer).transfer(manager.address, ethers.utils.parseEther("10"));

            expect(await weth9.balanceOf(manager.address)).equals(ethers.utils.parseEther("10"));

            await manager.connect(deployer).swap(
                weth9.address, ethers.utils.parseEther("10"), ethers.utils.parseEther("1"), manager.address
            ).catch(e => console.error(e));
        });
    });
});