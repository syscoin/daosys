import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  MessengerMock,
  MessengerMock__factory,
  MonadMock,
  MonadMock__factory
} from '../../../../typechain';

describe("Monad Test Suite", function () {

  // Test Wallets
  let deployer: SignerWithAddress;
  
  let monad: MonadMock;

  // TestService test variables
  let messenger: MessengerMock;
  const IMessengerInterfaceId = "0xf8e6c6ac";
  const setMessageFunctionSelector = '0x368b8772';
  const getMessageFunctionSelector = '0xce6d41de';

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    monad = await new MonadMock__factory(deployer).deploy() as MonadMock;
    tracer.nameTags[monad.address] = "Monad";

    messenger = await new MessengerMock__factory(deployer).deploy();
    tracer.nameTags[messenger.address] = "Messenger";

  });

  describe("Monad", function () {
    describe("#delegateMonad()", function () {
      describe("#( Monad.Op,bytes)", function () {
        it("Test case", async function () {
          await monad.delegateCallWithData(
            {
              operator: messenger.address,
              operation: setMessageFunctionSelector
            },
            ethers.utils.keccak256(
              ethers.utils.toUtf8Bytes("Hello World!")
            )
          )

          const result = await monad.callStatic.delegateCallNoData(
            {
              operator: messenger.address,
              operation: getMessageFunctionSelector
            }
          )
          
          // expect(
          //   result.returnData
          // ).to.equal(
          //   ethers.utils.keccak256(
          //     ethers.utils.toUtf8Bytes("Hello World!")
          //   )
          // );
        });
      });
    });
  });

});