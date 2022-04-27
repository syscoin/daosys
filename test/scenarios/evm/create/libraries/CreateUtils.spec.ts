import { expect } from 'chai';
import { ethers } from 'hardhat';
// import { describeBehaviorOfFactory } from '@solidstate/spec';
import {
  CreateUtilsMock,
  CreateUtilsMock__factory
} from '../../../../../typechain';

describe('Create2Utils', function () {
  
  let createUtils: CreateUtilsMock;

  beforeEach(async function () {
    const [deployer] = await ethers.getSigners();
    createUtils = await new CreateUtilsMock__factory(deployer).deploy();
  });

  // describeBehaviorOfFactory({ deploy: async () => instance });

  describe('internal', function () {
    describe('#_deploy', function () {
      describe('(bytes)', function () {
        it('deploys bytecode and returns deployment address', async function () {
          const initCode = createUtils.deployTransaction.data;

          const address = await createUtils.callStatic.deploy(initCode);
          expect(address).to.be.properAddress;

          await createUtils.deploy(initCode);

          expect(await ethers.provider.getCode(address)).to.equal(
            await ethers.provider.getCode(createUtils.address),
          );
        });

        describe('reverts if', function () {
          it('contract creation fails', async function () {
            const initCode = '0xfe';

            await expect(createUtils.deploy(initCode)).to.revertedWith(
              'CreateUtils: failed deployment',
            );
          });
        });
      });

      
    });

    
  });
});