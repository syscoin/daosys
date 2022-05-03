import { expect } from 'chai';
import {
  ethers,
  tracer
} from 'hardhat';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Create2DeploymentMetadataMock,
  Create2DeploymentMetadataMock__factory,
  FactoryMock,
  FactoryMock__factory
} from '../../../../../typechain';

describe('Create2DeploymentMetadata', function () {
  
  // Test Wallets
  let deployer: SignerWithAddress;
  
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

});