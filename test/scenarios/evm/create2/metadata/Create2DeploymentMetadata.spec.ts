import { expect } from 'chai';
import {
  ethers,
  tracer
} from 'hardhat';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Create2DeploymentMetadataMock,
  Create2DeploymentMetadataMock__factory
} from '../../../../../typechain';

describe('Create2DeploymentMetadata', function () {
  
  // Test Wallets
  let deployer: SignerWithAddress;
  
  let instance: Create2DeploymentMetadataMock;

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {
    [deployer] = await ethers.getSigners();
    instance = await new Create2DeploymentMetadataMock__factory(deployer).deploy();
  });

  describe('Create2DeploymentMetadata', function () {

    describe('#getCreate2DeploymentMetadata', function () {
      describe('()', function () {
        it('Returns configured metadata ', async function () {
          const initCode = instance.deployTransaction.data;
          const initCodeHash = ethers.utils.keccak256(initCode);
          // const salt = ethers.utils.randomBytes(32);

          await instance.setCreate2DeploymentMetadata(
            deployer.address,
            initCodeHash
          );

          const metadata = await instance.getCreate2DeploymentMetadata();

          expect(metadata.deployerAddress).to.equal(deployer.address);
          expect(metadata.deploymentSalt).to.equal(initCodeHash);

        });
      });
    });
  });
});