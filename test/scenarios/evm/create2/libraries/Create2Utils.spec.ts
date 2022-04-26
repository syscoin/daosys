import { expect } from 'chai';
import { ethers } from 'hardhat';
// import { describeBehaviorOfFactory } from '@solidstate/spec';
import {
  Create2UtilsMock,
  Create2UtilsMock__factory
} from '../../../../../typechain';

describe('Factory', function () {
  
  let instance: Create2UtilsMock;

  beforeEach(async function () {
    const [deployer] = await ethers.getSigners();
    instance = await new Create2UtilsMock__factory(deployer).deploy();
  });

  // describeBehaviorOfFactory({ deploy: async () => instance });

  describe('__internal', function () {
    describe('#_deployWithSalt', function () {

      describe('(bytes,bytes32)', function () {
        it('deploys bytecode and returns deployment address', async function () {
          const initCode = await instance.deployTransaction.data;
          const initCodeHash = ethers.utils.keccak256(initCode);
          const salt = ethers.utils.randomBytes(32);

          const address = await instance.callStatic['deployWithSalt(bytes,bytes32)'](
            initCode,
            salt,
          );
          expect(address).to.equal(
            await instance.callStatic.calculateDeploymentAddress(
              instance.address,
              initCodeHash,
              salt,
            ),
          );

          await instance['deployWithSalt(bytes,bytes32)'](initCode, salt);

          expect(await ethers.provider.getCode(address)).to.equal(
            await ethers.provider.getCode(instance.address),
          );
        });

        describe('reverts if', function () {
          it('contract creation fails', async function () {
            const initCode = '0xfe';
            const salt = ethers.utils.randomBytes(32);

            await expect(
              instance['deployWithSalt(bytes,bytes32)'](initCode, salt),
            ).to.revertedWith('Create2Utils: failed deployment');
          });

          it('salt has already been used', async function () {
            const initCode = instance.deployTransaction.data;
            const salt = ethers.utils.randomBytes(32);

            await instance['deployWithSalt(bytes,bytes32)'](initCode, salt);

            await expect(
              instance['deployWithSalt(bytes,bytes32)'](initCode, salt),
            ).to.be.revertedWith('Create2Utils: failed deployment');
          });
        });
      });
    });

    describe('#_calculateDeploymentAddress', function () {
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