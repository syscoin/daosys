import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Create2DeploymentMetadataMock,
  Create2DeploymentMetadataMock__factory,
  Create2MetadataFactoryMock,
  Create2MetadataFactoryMock__factory
} from '../../../../../../typechain';

describe('Create2MetadataFactory', function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";
  const Bytes4Zero = "0x00000000";

  // Test Wallets
  let deployer: SignerWithAddress;

  let create2MetadataFactory: Create2MetadataFactoryMock;

  let create2Metadata: Create2DeploymentMetadataMock;
  let newCreate2Metadata: Create2DeploymentMetadataMock;

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
    
    create2MetadataFactory = await new Create2MetadataFactoryMock__factory(deployer).deploy();
    tracer.nameTags[create2MetadataFactory.address] = "Create2Metadata Factory";

    create2Metadata = await new Create2DeploymentMetadataMock__factory(deployer).deploy();
    tracer.nameTags[create2Metadata.address] = "Create2DeploymentMetadata";

  });

  describe('Create2MetadataFactory', function () {

    describe('Create2DeploymentMetadata', function () {

      describe('#getCreate2DeploymentMetadata', function () {
        describe('()', function () {
          it('Returns configured metadata ', async function () {
            const creationCode = create2Metadata.deployTransaction.data;
            const codeHash = ethers.utils.keccak256(creationCode);

            await create2Metadata.setCreate2DeploymentMetadata(
              deployer.address,
              codeHash
            );

            const metadata = await create2Metadata.getCreate2DeploymentMetadata();

            expect(metadata.deployerAddress).to.equal(deployer.address);
            expect(metadata.deploymentSalt).to.equal(codeHash);

          });
        });
      });
    });

    describe("Create2MetadataFactory", function () {
      it("#_deployWithMetadata.", async function () {
        it("(bytes,bytes32).", async function () {
          it("Accurately sets Create2DeploymentMetadata as part of deployment.", async function () {

            const creationCode = create2Metadata.deployTransaction.data;
            const codeHash = ethers.utils.keccak256(creationCode);

            const newContractAddress = await create2MetadataFactory
              .callStatic.__deployWithMetadata(creationCode, codeHash);
            expect(newContractAddress).to.be.properAddress;

            await create2MetadataFactory.__deployWithMetadata(creationCode, codeHash);

            newCreate2Metadata = await ethers.getContractAt("Create2DeploymentMetadataMock", newContractAddress) as Create2DeploymentMetadataMock;
            tracer.nameTags[create2Metadata.address] = "New Create2Metadata Contract";

            expect(await ethers.provider.getCode(newCreate2Metadata.address)).to.equal(
              await ethers.provider.getCode(create2Metadata.address)
            );

            const metadata = await newCreate2Metadata.getCreate2DeploymentMetadata();

            expect(metadata.deployerAddress).to.equal(create2MetadataFactory.address);
            expect(metadata.deploymentSalt).to.equal(codeHash);

          });
        });
      });
    });

  });
});