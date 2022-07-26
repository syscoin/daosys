import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { 
  ERC165Mock,
  ERC165Mock__factory
} from '../../../../typechain';

describe('ERC165', function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;
  
  // Test instances
  let erc165Mock: ERC165Mock;
  const IERC165InterfaceId = "0x01ffc9a7";
  const supportsInterfaceFunctionSelector = "0x01ffc9a7";

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {
    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    erc165Mock = await new ERC165Mock__factory(deployer).deploy();
    tracer.nameTags[erc165Mock.address] = "ERC165Mock";
  });

  describe("ERC165", function () {

    describe("Validate interface and function selector computation", function () {
      it("IERC165InterfaceId.", async function () {
        expect(await erc165Mock.IERC165InterfaceId())
          .to.equal(IERC165InterfaceId);
      });
      it("supportsInterfaceFunctionSelector.", async function () {
        expect(await erc165Mock.supportsInterfaceFunctionSelector())
          .to.equal(supportsInterfaceFunctionSelector);
      });

    });

    describe("Validate implementation of IERC165.", function () {
      it("Accurately reports lack of interface support.", async function () {
        expect(await erc165Mock.supportsInterface(invalidInterfaceId))
          .to.equal(false);
      });
      it("Accurately reports ERC165 interface support.", async function () {
        expect(await erc165Mock.supportsInterface(IERC165InterfaceId))
          .to.equal(true);
      });
    });

  });
  
});
