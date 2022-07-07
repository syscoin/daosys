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
  
  // ERC165 test variables
  let erc165Mock: ERC165Mock;
  const erc165InterfaceID = "0x01ffc9a7";
  const supportsInterfaceFunctionSelector = "0x01ffc9a7";

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
  beforeEach(async function () {
    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    erc165Mock = await new ERC165Mock__factory(deployer).deploy();
    tracer.nameTags[erc165Mock.address] = "ERC165Mock";
  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                           SECTION Testing ERC165                           */
  /* -------------------------------------------------------------------------- */

  describe("ERC165", function () {

    describe("#constructor()", function () {
      it("provides ERC165 interface ID and function selectors", async function () {
        expect(await erc165Mock.ERC165InterfaceId()).to.equal(erc165InterfaceID);
      });
    });

    describe("#supportsInterface()", function () {
      describe("#(bytes4)", function () {
        it("Accurately reports lack of interface support.", async function () {
          expect(await erc165Mock.supportsInterface(invalidInterfaceId))
            .to.equal(false);
        });
        it("Accurately reports ERC165 interface support.", async function () {
          expect(await erc165Mock.supportsInterface(erc165InterfaceID))
            .to.equal(true);
        });
      });
    });

  });

  /* -------------------------------------------------------------------------- */
  /*                           !SECTION Testing ERC165                          */
  /* -------------------------------------------------------------------------- */
});
