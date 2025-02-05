# Account Abstraction with MinimalAccount

## Description
- This project demonstrates the concept of Account Abstraction using a custom Ethereum account (MinimalAccount). It includes smart contracts and tests to manage and validate user operations through account abstraction, leveraging the concept of a minimal proxy contract.

## Overview
- Account Abstraction: In traditional Ethereum, accounts are either externally owned accounts (EOAs) or smart contracts. This project aims to introduce a more flexible way of managing Ethereum accounts through the use of smart contracts, allowing for the abstracting of transaction validation and execution.
  
- MinimalAccount: A simple contract that supports basic functions like executing transactions, validating user operations, and interacting with ERC-20 tokens like USDC.
  
# Setup
- To run the tests and deploy the contracts, make sure you have Foundry installed on your local machine. You will also need to set up some necessary environment variables or configuration for Ethereum test networks and deployments.

# Libraries and Helpers:

- Forge Standard (forge-std): This is the testing framework used to deploy and run tests.
- OpenZeppelin: Used for ERC20 mock implementation and cryptographic utilities.
- Account Abstraction Libraries: Used for creating and validating user operations.
- HelperConfig: Manages the configuration related to deployment and entry point setup for the contract.

 # Technologies Used
- Solidity: The smart contracts are written in Solidity, which is the language used for developing Ethereum-based applications.
- Foundry: A fast, portable, and modular framework for Ethereum application development, used here for deploying contracts and testing.
- OpenZeppelin: A library of secure, community-vetted smart contracts, used here for ERC20 implementation and cryptographic utilities.
- Ethereum: The decentralized platform used for deploying and interacting with the smart contracts.
- EntryPoint: The contract responsible for processing user operations, including signing, validation, and execution of transactions.

# Contracts

## MinimalAccount.sol
- A basic contract that allows users to execute transactions, manage their balances, and interact with the Ethereum network.

- Key Functions:

- execute(address dest, uint256 value, bytes memory functionData): Allows the owner of the MinimalAccount to execute transactions.
- validateUserOp(PackedUserOperation memory packedUserOp, bytes32 userOpHash, uint256 missingAccountFunds): Validates a signed user operation.

 # Scripts
  
## DeployMinimal.s.sol
- A deployment script for the MinimalAccount contract, deploying the contract to a specified Ethereum network.

## SendPackedUserOp.s.sol
- This script handles the signing and packing of user operations. It uses the EntryPoint contract to process user operations, ensuring the integrity of the transaction process.

## HelperConfig.s.sol
- This helper script manages the configuration for deploying and interacting with the Ethereum test network. It includes setup for EntryPoint, the contract that handles the execution of user operations.

# Testing
# MinimalAccountTest.t.sol
- Main functions:
  
##  1. testOwnerCanExecuteComands
- This test ensures that the owner of the MinimalAccount can successfully execute a transaction, such as minting USDC tokens for the account.
 
- It:  
- Mints USDC tokens for the MinimalAccount contract.
  
- Ensure the balance of MinimalAccount is updated accordingly.
  
## 2. testNonOwnerCannotExecuteCommands
- This test checks that only the owner or the entry point can execute commands. Non-owners should be reverted with an error.

- It:
- Attempts to mint USDC tokens for the MinimalAccount from a non-owner address.
 
- Ensure the transaction reverts with MinimalAccount__NotFromEntryPointOrOwner.
  
## 3. testRecoverSignedOp
- This test validates the ability to recover a signed user operation and ensures the signer is the owner of the MinimalAccount.
  
- It:
- Creates an user operation and sign it.
  
- Recover the signer from the signature and verify that it matches the owner of the MinimalAccount.
  
## 4. testValidationOfUserOps
- This test verifies that the user operation validation function works correctly and that the return value indicates a successful validation.
- It:
- Generate and sign a user operation.
  
- Validate the user operation and ensure the validation data is correct.

## 5. testEntryPointCanExecuteCommands
-This test checks that the EntryPoint contract can correctly execute operations and handle user operations.
- It:

- Execute a mint operation via the EntryPoint.

- Verify that the operation is processed correctly.

  # Important:
  - It also has version of this account abstraction and some tests on the ZkSybc chain, but on zksync it doesn't need the data to be sent to an altmempool so it makes a bit easier, but since you script on ZkSync are not working i just won't cover much of it.

# Key Concepts
## User Operations (UserOp)
- In account abstraction, a UserOp is a packed operation that contains all the details needed to execute a transaction. It is signed by the user, validated, and executed by the entry point contract.

## EntryPoint Contract
- The EntryPoint contract is a crucial component in account abstraction, as it handles the logic for validating and executing user operations.

# Contributions
## Feel free to contribute by:

- Reporting issues with the contract or tests.
- Suggesting new features or optimizations.
- Submitting pull requests for bug fixes or improvements.

# License
- MIT 

