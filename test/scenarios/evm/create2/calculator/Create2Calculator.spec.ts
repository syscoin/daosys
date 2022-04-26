import { expect } from 'chai';
import { ethers } from 'hardhat';
// import { describeBehaviorOfFactory } from '@solidstate/spec';
import {
  Create2Calculator,
  Create2Calculator__factory
} from '../../../../../typechain';

describe('Create2Calculator', function () {
  
  let instance: Create2Calculator;

  beforeEach(async function () {
    const [deployer] = await ethers.getSigners();
    instance = await new Create2Calculator__factory(deployer).deploy();
  });

  // describeBehaviorOfFactory({ deploy: async () => instance });

  describe('Create2Calculator', function () {

    describe('#calculateDeploymentAddress', function () {
      it('returns address of not-yet-deployed contract', async function () {
        const initCode = instance.deployTransaction.data;
        const initCodeHash = ethers.utils.keccak256(initCode);
        const salt = ethers.utils.randomBytes(32);

        expect(
          await instance.callStatic.calculateDeploymentAddress(
            instance.address,
            initCodeHash,
            salt
          ),
        ).to.equal(
          ethers.utils.getCreate2Address(instance.address, salt, initCodeHash),
        );
      });
    });
  });
});