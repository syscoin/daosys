import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  ERC1155IndexingVaultStorageMock,
  ERC1155IndexingVaultStorageMock__factory
} from '../../../../../../../typechain';

/* -------------------------------------------------------------------------- */
/*                     SECTION ERC1155IndexingVaultStorage Test Suite                    */
/* -------------------------------------------------------------------------- */

describe("ERC1155IndexingVaultStorage Test Suite", function () {

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let testMock: ERC1155IndexingVaultStorageMock;
  const testUint256 = 1;
  const structSlot = "0xb751ae2859b84df1a5e98491df1b09d6e33a4dcb2c6fc1b387366a4738d7ec2e";

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

    testMock = await new ERC1155IndexingVaultStorageMock__factory(deployer).deploy() as ERC1155IndexingVaultStorageMock;
    tracer.nameTags[testMock.address] = "ERC1155IndexingVaultStorage";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                      SECTION Testing ERC1155IndexingVaultStorage                      */
  /* -------------------------------------------------------------------------- */

  describe("::ERC1155IndexingVaultStorage", function () {

    describe("#structSlot()", function () {
      describe("())", function () {
        it("Struct Slot is consistent.", async function () {
          expect(await testMock.structSlot())
            .to.equal(structSlot);
        });
      });
    });

    describe("#getUnderlyingToken()", function () {
      describe("(uint256)", function () {
        describe("#setUnderlyingToken()", function () {
          describe("(uint256,address)", function () {
            it("Can set, get, and delete address using uint256 key.", async function () {
              await testMock
                .setUnderlyingToken(
                  testUint256,
                  testMock.address
                );
              expect(await testMock.getUnderlyingToken(testUint256)).to.equal(testMock.address);
            });
          });
        });
      });
    });

  });

  /* -------------------------------------------------------------------------- */
  /*                      !SECTION Testing ERC1155IndexingVaultStorage                     */
  /* -------------------------------------------------------------------------- */

});

/* -------------------------------------------------------------------------- */
/*                    !SECTION ERC1155IndexingVaultStorage Test Suite                    */
/* -------------------------------------------------------------------------- */