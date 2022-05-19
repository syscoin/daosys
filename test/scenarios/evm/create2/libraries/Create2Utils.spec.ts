import { expect } from 'chai';
import { ethers } from 'hardhat';
// import { describeBehaviorOfFactory } from '@solidstate/spec';
import {
  Create2UtilsMock,
  Create2UtilsMock__factory
} from '../../../../../typechain';

describe('Factory', function () {
  
  let create2Utils: Create2UtilsMock;

  beforeEach(async function () {
    const [deployer] = await ethers.getSigners();
    create2Utils = await new Create2UtilsMock__factory(deployer).deploy();
  });

  // describeBehaviorOfFactory({ deploy: async () => create2Utils });

  describe('__internal', function () {
    describe('#_deployWithSalt', function () {

      describe('(bytes,bytes32)', function () {
        it('deploys bytecode and returns deployment address', async function () {
          const initCode = await create2Utils.deployTransaction.data;
          const initCodeHash = ethers.utils.keccak256(initCode);
          const salt = ethers.utils.randomBytes(32);

          const address = await create2Utils.callStatic.deployWithSalt(initCode, salt);
          expect(address).to.equal(
            await create2Utils.callStatic.calculateDeploymentAddress(
              create2Utils.address,
              initCodeHash,
              salt,
            ),
          );

          await create2Utils.deployWithSalt(initCode, salt);

          expect(await ethers.provider.getCode(address)).to.equal(
            await ethers.provider.getCode(create2Utils.address),
          );
          
        });

        describe('reverts if', function () {
          it('contract creation fails', async function () {
            const initCode = '0xfe';
            const salt = ethers.utils.randomBytes(32);

            await expect(
              create2Utils.deployWithSalt(initCode, salt),
            ).to.revertedWith('Create2Utils: failed deployment');

          });

          it('salt has already been used', async function () {
            const initCode = create2Utils.deployTransaction.data;
            const salt = ethers.utils.randomBytes(32);

            await create2Utils.deployWithSalt(initCode, salt);

            await expect(
              create2Utils.deployWithSalt(initCode, salt),
            ).to.be.revertedWith('Create2Utils: failed deployment');

          });
        });
      });
    });

    describe('#_calculateDeploymentAddress', function () {
      it('returns address of not-yet-deployed contract', async function () {
        const initCode = create2Utils.deployTransaction.data;
        const initCodeHash = ethers.utils.keccak256(initCode);
        const salt = ethers.utils.randomBytes(32);

        expect(
          await create2Utils.callStatic.calculateDeploymentAddress(
            create2Utils.address,
            initCodeHash,
            salt
          ),
        ).to.equal(
          ethers.utils.getCreate2Address(create2Utils.address, salt, initCodeHash),
        );

      });

      it('calculated address of not-yet-deployed contract matches deployed contract', async function () {
        const initCode = create2Utils.deployTransaction.data;
        const initCodeHash = ethers.utils.keccak256(initCode);
        const salt = ethers.utils.randomBytes(32);

        expect(
          await create2Utils.callStatic.calculateDeploymentAddress(
            create2Utils.address,
            initCodeHash,
            salt
          ),
        ).to.equal(
          ethers.utils.getCreate2Address(create2Utils.address, salt, initCodeHash),
        );

        const address = await create2Utils.callStatic.deployWithSalt(initCode, salt);

        await create2Utils.deployWithSalt(initCode, salt);

        expect(address).to.equal(
          await create2Utils.callStatic.calculateDeploymentAddress(
            create2Utils.address,
            initCodeHash,
            salt,
          ),
        );

      });
    });
  });
});