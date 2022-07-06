import {
    ethers,
    tracer
} from 'hardhat';
import { assert, expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
    ERC20VariableGonUFragments__factory,
    ERC20VariableGonUFragments
} from '../../../../../typechain';

describe("ERC20VariableGonUFragments", function () {

    let deployer: SignerWithAddress;
    let indexToken: ERC20VariableGonUFragments;

    /* -------------------------------------------------------------------------- */
    /*                        SECTION Before All Test Hook                        */
    /* -------------------------------------------------------------------------- */

    before(async function () {
        // Tagging address(0) as "System" in logs.
        tracer.nameTags[ethers.constants.AddressZero] = "System";
    })

    /* -------------------------------------------------------------------------- */
    /*                       !SECTION Before All Test Hook                        */
    /* -------------------------------------------------------------------------- */

    /* -------------------------------------------------------------------------- */
    /*                        SECTION Before Each Test Hook                       */
    /* -------------------------------------------------------------------------- */
/*     beforeEach(async function () {
        [deployer] = await ethers.getSigners();
        expect(deployer.address).to.be.properAddress;
        tracer.nameTags[deployer.address] = "Deployer";

        indexToken = await new ERC20VariableGonUFragments__factory(deployer).deploy();
        tracer.nameTags[indexToken.address] = "Indexing Token";

        expect(await indexToken.connect(deployer).setMonetaryPolicy(deployer.address))
            .to.emit(indexToken, "LogMonetaryPolicyUpdated")
            .withArgs(deployer.address);
    });

    describe("::ERC20VariableGonUFragments", function () {
        describe("#totalSupply()", function () {
            it("test default logic", async function () {
                expect(await indexToken.totalSupply()).to.equal(
                    ethers.utils.parseUnits("50000000", 9)
                );
            });
        });
    });

    describe("::ERC20VariableGonUFragments", function () {
        describe("#balanceOf(address)", function () {
            it("test default logic", async function () {
                expect(await indexToken.balanceOf(deployer.address)).to.equal(
                    // MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY) / INITIAL_FRAGMENTS_SUPPLY
                    ethers.BigNumber.from("0x38D0B7E1200000")
                );
            });
        });
    });

    describe("::ERC20VariableGonUFragments", function () {
        describe("#scaledBalanceOf(address)", function () {
            it("test default logic with balance", async function () {
                const w0_expect = "0xffffffffffffffffffffffffffffffffffffffffffffffffff872dfbb25b0000"
                const w1_expect = "0x0"
                const { 0: w0, 1: w1 } = await indexToken.scaledBalanceOf(deployer.address);
                assert.equal(w0._hex, ethers.BigNumber.from(w0_expect)._hex);
                assert.equal(w1._hex, ethers.BigNumber.from(w1_expect)._hex);
            });

            it("test default logic without balance", async function () {
                const w0_expect = "0x0"
                const w1_expect = "0x0"
                const { 0: w0, 1: w1 } = await indexToken.scaledBalanceOf(ethers.constants.AddressZero);
                assert.equal(w0._hex, ethers.BigNumber.from(w0_expect)._hex);
                assert.equal(w1._hex, ethers.BigNumber.from(w1_expect)._hex);
            });
        });
    });

    describe("::ERC20VariableGonUFragments", function () {
        describe("#scaledTotalSupply()", function () {
            it("test default logic", async function () {
                const w0_expect = "0xffffffffffffffffffffffffffffffffffffffffffffffffff872dfbb25b0000"
                const w1_expect = "0x0"
                const { 0: w0, 1: w1 } = await indexToken.scaledTotalSupply();
                assert.equal(w0._hex, ethers.BigNumber.from(w0_expect)._hex);
                assert.equal(w1._hex, ethers.BigNumber.from(w1_expect)._hex);
            });
        });
    });
    
    describe("::ERC20VariableGonUFragments", function () {
        describe("#rebase(uint256, int256)", function () {
            it("test dummy rebase", async function () {
                const initial_supply = ethers.utils.parseUnits("50000000", 9);
                const epoch = ethers.BigNumber.from(1);
                const delta = ethers.BigNumber.from(0);
                
                
                expect(await indexToken.connect(deployer).rebase(epoch, delta))
                    .to.emit(indexToken, "logRebase")
                    .withArgs(1, initial_supply)
                expect(await indexToken.totalSupply()).to.equal(
                    initial_supply
                );
            });

            it("double supply", async function () {
                const initial_supply = ethers.utils.parseUnits("50000000", 9);
                const epoch = ethers.BigNumber.from(1);
                const delta = ethers.BigNumber.from(initial_supply);
                
                
                expect(await indexToken.connect(deployer).rebase(epoch, delta))
                    .to.emit(indexToken, "logRebase")
                    .withArgs(1, initial_supply.mul(2))
                expect(await indexToken.totalSupply()).to.equal(
                    initial_supply.mul(2)
                );
            });
        });
    });
    
    describe("::ERC20VariableGonUFragments", function () {
        describe("setLPInfluencedGonSupply(uint256)", function () {
            it("Increase gons, check balance", async function () {
                const delta = ethers.BigNumber.from("0x1234");
                const initial_gon_balance = ethers.BigNumber.from("0x38D0B7E1200000");
                const w0_expect = "0xffffffffffffffffffffffffffffffffffffffffffffffffff872dfbb25b1234"
                const w1_expect = "0x0"

                await indexToken.connect(deployer).setLPInfluencedGonSupply(delta);
                const { 0: w0, 1: w1 } = await indexToken.scaledTotalSupply();
                assert.equal(w0._hex, ethers.BigNumber.from(w0_expect)._hex);
                assert.equal(w1._hex, ethers.BigNumber.from(w1_expect)._hex);

                expect(await indexToken.balanceOf(deployer.address)).to.equal(
                    initial_gon_balance
                );
            });


            it("Increase gons to force overflow into other word, check balance", async function () {
                const initial_gon_balance = ethers.BigNumber.from("0x38D0B7E1200000");
                const extra_val = "0x1000000000000000000000000000000000000000000000000000000000000000"
                const delta = ethers.BigNumber.from(extra_val);
                const w0_expect = "0x0fffffffffffffffffffffffffffffffffffffffffffffffff872dfbb25b0000"
                const w1_expect = "0x1"

                await indexToken.connect(deployer).setLPInfluencedGonSupply(delta);
                const { 0: w0, 1: w1 } = await indexToken.scaledTotalSupply();
                assert.equal(w0._hex, ethers.BigNumber.from(w0_expect)._hex);
                assert.equal(w1._hex, ethers.BigNumber.from(w1_expect)._hex);

                expect(await indexToken.balanceOf(deployer.address)).to.equal(
                    initial_gon_balance
                );
            });
        });
    }); */
});