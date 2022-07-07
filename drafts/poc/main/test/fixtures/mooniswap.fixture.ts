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
    MooniMockERC20
} from '../../typechain';
import { debug, trace } from 'console';
import exp from 'constants';
import { 
    BigNumber, 
    ethers 
} from 'ethers';

export interface mooniswapInitializeArgs {
    deployer: SignerWithAddress
}

export const initializeMooniswap = async (params: mooniswapInitializeArgs) => {
    return await new MooniFactory__factory(params.deployer).deploy();
}

export interface mooniswapPairCreateArgs {
    factory: MooniFactory,
    token0: IERC20,
    token1: IERC20,
}

export const createMooniswapPair = async (params: mooniswapPairCreateArgs): Promise<Mooniswap> => {
    const tx = await params.factory.deploy(
        params.token0.address,
        params.token1.address
    )

    const pool = await params.factory.pools(params.token0.address, params.token1.address);

    return new Mooniswap__factory().attach(pool);
}

export interface addLiquidityArgs {
    sender: SignerWithAddress,
    mooniswap: Mooniswap,
    tokenList: IERC20[],
    amountList: BigNumber[]
}

//TODO: do some logic to support native ethereum
//TODO: add min amounts support
export const addLiquidity = async (params: addLiquidityArgs): Promise<[ethers.ContractTransaction[], ethers.ContractTransaction]> => {
    expect(params.tokenList.length === params.amountList.length)

    const mooni = params.mooniswap
    let approvals: ethers.ContractTransaction[] = []

    for(let i=0; i < params.amountList.length; i++){
        approvals.push( await params.tokenList[i].connect(params.sender).approve(mooni.address, params.amountList[i]) )
    }
    const deposit = await mooni.connect(params.sender).deposit(params.amountList, [0, 0], {value: ethers.utils.parseEther("0")});

    return [approvals, deposit]
}

export interface removeLiquidityArgs {}

export const removeLiquidity = () => {}

export interface mooniPoolTokenArgs {
    signer: SignerWithAddress,
    mooniPool: Mooniswap,
    //TODO: can I turn this into a variable outside the interface?
    tokenObjects: (ERC20Managed | MooniMockERC20 | WETH9)[]
}

//TODO: seems like tokens are always sorted, use sort from mooniswap instead
export const getMooniPoolIERC20s = async (params: mooniPoolTokenArgs): Promise<IERC20[]> => {
    const poolTokens = await params.mooniPool.connect(params.signer).getTokens()
    const PoolTokenObjects = poolTokens.map(x => params.tokenObjects.find(obj => obj.address === x) as unknown as IERC20)
    return PoolTokenObjects
}

export interface mooniPoolDecimalArgs extends mooniPoolTokenArgs {
    tokenAmounts: string[]
}

//TODO seems like tokens are always sorted, use sort from mooniswap instead
export const getMooniPoolDecimals = async (params: mooniPoolDecimalArgs): Promise<BigNumber[]> => {
    const poolTokens = await params.mooniPool.connect(params.signer).getTokens()
    let decimalList = poolTokens.map(async (x) => {
        return (await params.tokenObjects.find(obj => obj.address === x)!.decimals());
    })

    let tokenAmountsFormatted: BigNumber[] = []
    for(let i = 0; i < decimalList.length; i++){
        tokenAmountsFormatted.push(ethers.utils.parseUnits(params.tokenAmounts[i], await decimalList[i]))
    }
    return tokenAmountsFormatted
}