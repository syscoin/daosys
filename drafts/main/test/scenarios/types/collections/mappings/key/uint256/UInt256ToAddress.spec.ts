import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  UInt256ToAddressMock,
  UInt256ToAddressMock__factory
} from '../../../../../../../typechain';

/* -------------------------------------------------------------------------- */
/*                     SECTION UInt256ToAddress Test Suite                    */
/* -------------------------------------------------------------------------- */

describe("UInt256ToAddress Test Suite", function () {

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let uint256ToAddressMock: UInt256ToAddressMock;
  const testUint256 = 1;
  // const structSlot = "0x42e24435b7c25a1073dd558f30e27eb94d98c60df1b6389b2705455a0212bbba";

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

    uint256ToAddressMock = await new UInt256ToAddressMock__factory(deployer).deploy() as UInt256ToAddressMock;
    tracer.nameTags[uint256ToAddressMock.address] = "UInt256ToAddress";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                      SECTION Testing UInt256ToAddress                      */
  /* -------------------------------------------------------------------------- */

  describe("UInt256ToAddress", function () {

    // describe("Validate structSlot consistency", function () {
    //   it("getStructSlot().", async function () {
    //     expect(await uint256Mock.getStructSlot())
    //       .to.equal(structSlot);
    //   });
    // });

    describe("#unmapValue()", function () {
      describe("(uint256)", function () {
        describe("#queryValue()", function () {
          describe("(uint256)", function () {
            describe("#mapValue()", function () {
              describe("(uint256,address)", function () {
                it("Can set, get, and delete address using uint256 key.", async function () {
                  await uint256ToAddressMock
                    .mapValue(
                      testUint256,
                      uint256ToAddressMock.address
                    );
                  expect(await uint256ToAddressMock.queryValue(testUint256)).to.equal(uint256ToAddressMock.address);

                  await uint256ToAddressMock
                    .unmapValue(
                      testUint256
                    );
                  expect(
                    await uint256ToAddressMock.queryValue(testUint256)
                  ).to.equal(
                    ethers.constants.AddressZero
                  );
                });
              });
            });
          });
        });
      });
    });

  });

  /* -------------------------------------------------------------------------- */
  /*                      !SECTION Testing UInt256ToAddress                     */
  /* -------------------------------------------------------------------------- */

});

/* -------------------------------------------------------------------------- */
/*                    !SECTION UInt256ToAddress Test Suite                    */
/* -------------------------------------------------------------------------- */