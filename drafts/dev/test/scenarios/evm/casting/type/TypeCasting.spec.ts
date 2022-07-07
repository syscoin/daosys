import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  TypeCastingMock,
  TypeCastingMock__factory
} from '../../../../../typechain';

describe('TypeCasting', function () {


  // Test Wallets
  let deployer: SignerWithAddress;
  
  let typeCasting: TypeCastingMock;
  const ITypeCastingInterfaceId = '0x12e8858e';
  const bytes4ToBytes32FunctionSelector = '0x12e8858e';

  beforeEach(async function () {
    const [deployer] = await ethers.getSigners();
    typeCasting = await new TypeCastingMock__factory(deployer).deploy();
  });

  describe('TypeCasting', function () {

    describe("Validate interface and function selector computation", function () {
      describe("TypeCastingMock", function () {
        it("ITypeCastingInterfaceId.", async function () {
          expect(await typeCasting.ITypeCastingInterfaceId())
            .to.equal(ITypeCastingInterfaceId);
        });
        it("bytes4ToBytes32FunctionSelector.", async function () {
          expect(await typeCasting.bytes4ToBytes32FunctionSelector())
            .to.equal(bytes4ToBytes32FunctionSelector);
        });
      });

    });

    describe('#bytes4ToBytes32', function () {
      describe('(bytes4)', function () {
        it('returns expected result of casting a byte4 value to a bytes32 value', async function () {
          // const initCode = typeCasting.deployTransaction.data;
          // const initCodeHash = ethers.utils.keccak256(initCode);
          // const salt = ethers.utils.randomBytes(32);

          expect(
            await typeCasting.bytes4ToBytes32(
              bytes4ToBytes32FunctionSelector
            )
          ).to.equal(
            ethers.BigNumber.from(bytes4ToBytes32FunctionSelector).shl(224).toHexString()
            // bytes4ToBytes32FunctionSelector
          );
        });
      });
    });
  });
});