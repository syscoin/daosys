import { expect } from 'chai';
import { ethers } from 'hardhat';
// import { describeBehaviorOfFactory } from '@solidstate/spec';
import {
  CreateUtilsMock,
  CreateUtilsMock__factory
} from '../../../../../typechain';

describe('Create2Utils', function () {
  
  let instance: CreateUtilsMock;

  beforeEach(async function () {
    const [deployer] = await ethers.getSigners();
    instance = await new CreateUtilsMock__factory(deployer).deploy();
  });

  // describeBehaviorOfFactory({ deploy: async () => instance });

  describe('__internal', function () {
    describe('#_deploy', function () {
      describe('(bytes)', function () {
        it('deploys bytecode and returns deployment address', async function () {
          const initCode = instance.deployTransaction.data;

          const address = await instance.callStatic['deploy(bytes)'](initCode);
          expect(address).to.be.properAddress;

          await instance['deploy(bytes)'](initCode);

          expect(await ethers.provider.getCode(address)).to.equal(
            await ethers.provider.getCode(instance.address),
          );
        });

        describe('reverts if', function () {
          it('contract creation fails', async function () {
            const initCode = '0xfe';

            await expect(instance['deploy(bytes)'](initCode)).to.revertedWith(
              'CreateUtils: failed deployment',
            );
          });
        });
      });

      
    });

    
  });
});