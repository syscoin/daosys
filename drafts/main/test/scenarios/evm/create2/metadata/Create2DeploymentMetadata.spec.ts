import { expect } from 'chai';
import {
  ethers,
  tracer
} from 'hardhat';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Create2DeploymentMetadataMock,
  Create2DeploymentMetadataMock__factory,
} from '../../../../../typechain';

describe('Create2DeploymentMetadata', function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";
  const Bytes4Zero = "0x00000000";
  const ICreate2DeploymentMetadataInterfaceId = '0x2f6fb0fb';
  const initCreate2DeploymentMetadataFunctionSelector = '0x016772e7';
  const getCreate2DeploymentMetadataFunctionSelector = '0x2e08c21c';
  const IERC165InterfaceId = "0x01ffc9a7";
  const supportsInterfaceFunctionSelector = "0x01ffc9a7";
  
  // Test Wallets
  let deployer: SignerWithAddress;

  // Test instances
  let create2Metadata: Create2DeploymentMetadataMock;

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {
    [deployer] = await ethers.getSigners();

    create2Metadata = await new Create2DeploymentMetadataMock__factory(deployer).deploy();
    tracer.nameTags[create2Metadata.address] = "Create2DeploymentMetadata";
  });

  describe('Create2DeploymentMetadata', function () {

    describe("Validate interface and function selector computation", function () {
      it("ICreate2DeploymentMetadataInterfaceId.", async function () {
        expect(await create2Metadata.ICreate2DeploymentMetadataInterfaceId())
          .to.equal(ICreate2DeploymentMetadataInterfaceId);
      });
      it("initCreate2DeploymentMetadataFunctionSelector.", async function () {
        expect(await create2Metadata.initCreate2DeploymentMetadataFunctionSelector())
          .to.equal(initCreate2DeploymentMetadataFunctionSelector);
      });
      it("getCreate2DeploymentMetadataFunctionSelector.", async function () {
        expect(await create2Metadata.getCreate2DeploymentMetadataFunctionSelector())
          .to.equal(getCreate2DeploymentMetadataFunctionSelector);
      });
      it("IDelegateServiceInterfaceId.", async function () {
        expect(await create2Metadata.IERC165InterfaceId())
          .to.equal(IERC165InterfaceId);
      });
      it("getServiceDefFunctionSelector.", async function () {
        expect(await create2Metadata.supportsInterfaceFunctionSelector())
          .to.equal(supportsInterfaceFunctionSelector);
      });
    });

    describe("#supportsInterface()", function () {
      describe("#(bytes4)", function () {
        it("Accurately reports lack of interface support.", async function () {
          expect(await create2Metadata.supportsInterface(invalidInterfaceId))
            .to.equal(false);
        });
        it("Accurately reports ERC165 interface support.", async function () {
          expect(await create2Metadata.supportsInterface(IERC165InterfaceId))
            .to.equal(true);
        });
        it("Accurately reports ICreate2DeploymentMetadata interface support.", async function () {
          expect(await create2Metadata.supportsInterface(ICreate2DeploymentMetadataInterfaceId))
            .to.equal(true);
        });
      });
    });

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

    describe('#initCreate2DeploymentMetadata', function () {
      describe('(bytes32)', function () {

        it('Accurately sets metadata.', async function () {
          const creationCode = create2Metadata.deployTransaction.data;
          const codeHash = ethers.utils.keccak256(creationCode);

          await create2Metadata.connect(deployer).initCreate2DeploymentMetadata(
            codeHash
          );

          const metadata = await create2Metadata.getCreate2DeploymentMetadata();

          expect(metadata.deployerAddress).to.equal(deployer.address);
          expect(metadata.deploymentSalt).to.equal(codeHash);

        });

        it('Reverts once metadata is set.', async function () {
          const creationCode = create2Metadata.deployTransaction.data;
          const codeHash = ethers.utils.keccak256(creationCode);

          await create2Metadata.connect(deployer).initCreate2DeploymentMetadata(
            codeHash
          );

          const metadata = await create2Metadata.getCreate2DeploymentMetadata();

          expect(metadata.deployerAddress).to.equal(deployer.address);
          expect(metadata.deploymentSalt).to.equal(codeHash);

          await expect(
            create2Metadata.connect(deployer).initCreate2DeploymentMetadata(
              codeHash
            )
          ).to.be.revertedWith("Immutable:: This function is immutable.");

          const metadataRecheck = await create2Metadata.getCreate2DeploymentMetadata();

          expect(metadataRecheck.deployerAddress).to.equal(deployer.address);
          expect(metadataRecheck.deploymentSalt).to.equal(codeHash);

        });

      });
      
    });



  });

});