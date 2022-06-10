import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { expect } from 'chai';
import {
    Mooniswap,
    MooniFactory,
    MooniFactory__factory,
    Mooniswap__factory,
    ERC20__factory,
    ERC20,
    ERC20Managed,
    ERC20Managed__factory,
    WETH9,
    WETH9__factory,
    IERC20,
    MooniMockERC20,
    UniswapV2Factory__factory,
    UniswapV2Pair__factory,
    UniswapV2Pair,
    UniswapV2Factory
} from '../../typechain';
import { debug, trace } from 'console';
import exp from 'constants';
import { Contract, Signer } from 'ethers';
import {
    BigNumber,
    ethers
} from 'ethers';


export function sqrt(n: BigNumber) {
    const ONE = BigNumber.from(1);
    const TWO = BigNumber.from(2);
    let x = BigNumber.from(n);
    let z = x.add(ONE).div(TWO);
    let y = x;
    while (z.sub(y).isNegative()) {
        y = z;
        z = x.div(z).add(z).div(TWO);
    }
    return y;
}

export function expandToNDecimals(n: number, d: number): BigNumber {
    return BigNumber.from(n).mul(BigNumber.from(10).pow(d));
}

export interface uniswapPairInitializeArgs {
    deployer: SignerWithAddress
}



export const createUniswapPair = async (params: uniswapPairInitializeArgs): Promise<[UniswapV2Factory, UniswapV2Pair, ERC20Managed, ERC20Managed]> => {
    let token0 = await new ERC20Managed__factory(params.deployer).deploy(
        "TK0",
        "TK0",
        18,
        ethers.utils.parseEther("10000")
    );

    let token1 = await new ERC20Managed__factory(params.deployer).deploy(
        "TK1",
        "TK1",
        18,
        ethers.utils.parseEther("10000")
    );

    let uniswap = await new UniswapV2Factory__factory(params.deployer).deploy(params.deployer.address);

    await uniswap.createPair(token0.address, token1.address);
    const poolAddress = await uniswap.getPair(token0.address, token1.address);
    let tokenPair = new Contract(
        poolAddress,
        JSON.stringify(UniswapV2Pair__factory.abi),
        params.deployer
    ).connect(params.deployer) as unknown as UniswapV2Pair;

    let tokenA = await tokenPair.token0()

    if (tokenA == token0.address) {
        return [uniswap, tokenPair, token0, token1]
    } else {
        return [uniswap, tokenPair, token1, token0]
    }
}

