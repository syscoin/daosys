import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Create2MetadataAdaptorMock,
  Create2MetadataAdaptorMock__factory,
  Create2DeploymentMetadataMock,
  Create2DeploymentMetadataMock__factory
} from '../../../../../../typechain';

describe('Create2MetadataAdaptor', function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";
  const Bytes4Zero = "0x00000000";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test Instances
  let create2MetadataAdaptorMock: Create2MetadataAdaptorMock;

  let create2Metadata: Create2DeploymentMetadataMock;

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

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    create2MetadataAdaptorMock = await new Create2MetadataAdaptorMock__factory(deployer).deploy();
    tracer.nameTags[create2MetadataAdaptorMock.address] = "Create2MetadataAdaptor";

    create2Metadata = await new Create2DeploymentMetadataMock__factory(deployer).deploy();
    tracer.nameTags[create2Metadata.address] = "Create2DeploymentMetadata";

  });

  describe('Create2MetadataAdaptor', function () {

    describe('Create2DeploymentMetadata', function () {

      describe('#getCreate2DeploymentMetadata', function () {
        describe('()', function () {
          it('Returns configured metadata ', async function () {
            const initCode = create2Metadata.deployTransaction.data;
            const initCodeHash = ethers.utils.keccak256(initCode);

            await create2Metadata.setCreate2DeploymentMetadata(
              deployer.address,
              initCodeHash
            );

            const metadata = await create2Metadata.getCreate2DeploymentMetadata();

            expect(metadata.deployerAddress).to.equal(deployer.address);
            expect(metadata.deploymentSalt).to.equal(initCodeHash);

          });
        });
      });
    });

    describe('Create2MetadataAdaptor', function () {

      describe('#_getCreate2Metadata', function () {
        describe('()', function () {
          it('Adaptor can store and read configured metadata ', async function () {
            const initCode = create2Metadata.deployTransaction.data;
            const initCodeHash = ethers.utils.keccak256(initCode);

            await create2MetadataAdaptorMock._initCreate2DeploymentMetadata(
              create2Metadata.address,
              initCodeHash
            );

            const metadata = await create2MetadataAdaptorMock._getCreate2Metadata(create2Metadata.address);

            expect(metadata.deployerAddress).to.equal(create2MetadataAdaptorMock.address);
            expect(metadata.deploymentSalt).to.equal(initCodeHash);

          });
        });
      });
    });

  });
});