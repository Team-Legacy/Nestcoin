# Team-Legacy Task 1

Developing a system that allows batch transactions to ensure quick distribution of the created currency as efficiently as possible

Using the power of Web3 a solution has been created in form of a smart contract

## 1. Starting with the creation of the currency which we would call Nestcoin

Minting is the process of generating new coins by authenticating data, creating new blocks, and recording the information
onto the blockchain through a “proof of stake” protocol. Both cryptocurrency and Non-Fungible Tokens (NFTs) can be minted this way.

in the Nestcoin.sol contract there is a function called mint which is publicly accessible, this means the contract owner can call it anytime
the function requires two input and address and amount to be minted

The currency created (Nestcoin) is an Erc 20 token which means it will define six different implementation coding functions for the benefit
of other tokens within the Ethereum system. they include;

1. total supply
2. balance of
3. allowance
4. transfer
5. approve
6. transfer from

These code functions are integral for user/token implementation, specifically in determining the amount of tokens in circulation, storing
and returning balances, making transfer and withdrawal requests and granting approval, and agreeing to automated transfers.

## 2. The second feature in the contract is the Authorizable.sol

The most common and basic form of access control is the concept of ownership: there’s an account that is the owner of a contract and can do administrative tasks on it. This approach is perfectly reasonable for contracts that have a single administrative user.

There are two functions here to add and remove admin
Ownable left untouched then You introduce your own contract called Authorizable, which extends Ownable and adds the onlyAuthorized modifier.
This contract will keep a separate mapping for addresses that are authorized to perform actions. addAuthorized, removeAuthorized must only be marked with onlyOwner.

## 3.Bulksender.sol

This is the third feature in this contract that allows bulk sending of tokens of either the same value or of different values
The selfdestruct function. once selfdestruct is called, you can't interact with a Smart Contract anymore.On the surface it looks very similar
to our withdrawAllMoney function, with one major difference: Once you call destroySmartContract, the address of the Smart Contract will contain
no more code. You can still send transactions to the address and transfer Ether there, but there won't be any code that could send you the Ether back.


# 4. Scope of future work

Update of Etherscan code
Complete FrontEnd implementation of buying of tickets
Dvelopment of a Middleware for a self destroy inorder to protect our contract
