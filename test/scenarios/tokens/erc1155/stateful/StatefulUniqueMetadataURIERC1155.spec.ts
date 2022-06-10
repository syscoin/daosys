import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  StatefulUniqueMetadataURIERC1155,
  StatefulUniqueMetadataURIERC1155__factory
} from '../../../../../typechain';

/* -------------------------------------------------------------------------- */
/*                SECTION StatefulUInt256CounterMock Test Suite               */
/* -------------------------------------------------------------------------- */

describe("StatefulUniqueURIERC1155 Test Suite", function () {

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let statefulUniqueMetadataURIERC1155: StatefulUniqueMetadataURIERC1155;

  const testURI = "https://test.uri";

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

    statefulUniqueMetadataURIERC1155 = await new StatefulUniqueMetadataURIERC1155__factory(deployer).deploy() as StatefulUniqueMetadataURIERC1155;
    expect(statefulUniqueMetadataURIERC1155.address).to.be.properAddress;
    tracer.nameTags[statefulUniqueMetadataURIERC1155.address] = "StatefulUniqueMetadataURIERC1155";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                          SECTION Testing Messenger                         */
  /* -------------------------------------------------------------------------- */

  describe("::StatefulUniqueURIERC1155", function () {

    describe("#lastMintedTokenID()", function () {
      describe("#()", function () {
        it("Reports tokenID value of last minted token accurately.", async function () {
          expect(await statefulUniqueMetadataURIERC1155.lastMintedTokenID())
            .to.equal("0");
        });

        describe("Reports tokenID value of last minted token accurately after a minting event.", function () {
          describe("#mint()", function () {
            describe("(string,address)", function () {

              it("Iterates and returns next count value correctly.", async function () {
                await statefulUniqueMetadataURIERC1155.mint(testURI, deployer.address);
                expect(await statefulUniqueMetadataURIERC1155.lastMintedTokenID())
                  .to.equal("1");
              });

            });
          });
        });

      });
    });

    describe("#nextToBeMintedTokenID()", function () {
      describe("#()", function () {
        it("Reports tokenID value of next to be minted token accurately.", async function () {
          expect(await statefulUniqueMetadataURIERC1155.nextToBeMintedTokenID())
            .to.equal("1");
        });

        describe("Reports tokenID value of last minted token accurately after a minting event.", function () {
          describe("#mint()", function () {
            describe("(string,address)", function () {

              it("Iterates and returns next count value correctly.", async function () {
                await statefulUniqueMetadataURIERC1155.mint(testURI, deployer.address);
                expect(await statefulUniqueMetadataURIERC1155.nextToBeMintedTokenID())
                  .to.equal("2");
              });

            });
          });
        });

      });
    });

    describe("#uri()", function () {
      describe("#(uint256)", function () {

        describe("Reports uri last minted token accurately after a minting event.", function () {
          describe("#mint()", function () {
            describe("(string,address)", function () {

              it("Iterates and returns next count value correctly.", async function () {
                await statefulUniqueMetadataURIERC1155.mint(testURI, deployer.address);
                expect(await statefulUniqueMetadataURIERC1155.uri("1"))
                  .to.equal(testURI);
              });

            });
          });
        });

      });
    });

  });

  /* -------------------------------------------------------------------------- */
  /*               !SECTION StatefulUInt256CounterMock Test Suite               */
  /* -------------------------------------------------------------------------- */

});