// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Script, console2} from "forge-std/Script.sol";
import {EntryPoint} from "lib/account-abstraction/contracts/core/EntryPoint.sol";

contract HelperConfig is Script {
    error HelperConfig__InvalidChainId();

    struct NetworkConfig {
        address entryPoint;
        address account;
        address usdc;
    }

    uint256 constant ETH_MAINNET_CHAIN_ID = 1;
    uint256 constant ETH_SEPOLIA_CHAIN_ID = 11155111;
    uint256 constant ZKSYNC_SEPOLIA_CHAIN_ID = 300;
    uint256 constant LOCAL_CHAIN_ID = 31337;
    address constant BURNER_WALLET = 0xfa982ec76127c2Bf01Fc987ce7460c31A3Cf5119;
    // address constant FOUNDRY_DEFAULT_WALLET =0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38;
    uint256 constant ARBITRUM_MAINNET_CHAIN_ID = 42_161;
    uint256 constant ZKSYNC_MAINNET_CHAIN_ID = 324;
    address constant ANVIL_DEFAULT_ACCOUNT =
        0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    NetworkConfig public localNetworkConfig;
    mapping(uint256 chainId => NetworkConfig) public networkConfigs;

    constructor() {
        networkConfigs[ETH_SEPOLIA_CHAIN_ID] = getEthSepoliaConfig();
        networkConfigs[ETH_MAINNET_CHAIN_ID] = getEthMainnetConfig();
        networkConfigs[ZKSYNC_MAINNET_CHAIN_ID] = getZkSyncEthSepoliaConfig();
        networkConfigs[ARBITRUM_MAINNET_CHAIN_ID] = getArbMainnetConfig();
    }

    function getConfig() public returns (NetworkConfig memory) {
        return getConfigByChainId(block.chainid);
    }

    function getConfigByChainId(
        uint256 chainId
    ) public returns (NetworkConfig memory) {
        if (chainId == LOCAL_CHAIN_ID) {
            return getOrCreateAnvilEthConfig();
        } else if (networkConfigs[chainId].account == address(0)) {
            return networkConfigs[chainId];
        } else {
            revert HelperConfig__InvalidChainId();
        }
    }

    function getEthMainnetConfig() public pure returns (NetworkConfig memory) {
        // This is v7
        return
            NetworkConfig({
                entryPoint: 0x0000000071727De22E5E9d8BAf0edAc6f37da032,
                usdc: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,
                account: BURNER_WALLET
            });
        // https://blockscan.com/address/0x0000000071727De22E5E9d8BAf0edAc6f37da032
    }

    function getEthSepoliaConfig() public pure returns (NetworkConfig memory) {
        return
            NetworkConfig({
                entryPoint: 0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789,
                usdc: 0x53844F9577C2334e541Aec7Df7174ECe5dF1fCf0,
                account: BURNER_WALLET
            });
    }

    function getZkSyncEthSepoliaConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        return
            NetworkConfig({
                entryPoint: address(0),
                usdc: address(0),
                account: BURNER_WALLET
            });
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        if (localNetworkConfig.account != address(0)) {
            return localNetworkConfig;
        }

        /// deploy mocks
        console2.log("Deploying Mocks also");
        vm.startBroadcast(ANVIL_DEFAULT_ACCOUNT);
        EntryPoint entryPoint = new EntryPoint();
        vm.stopBroadcast();

        localNetworkConfig = NetworkConfig({
            entryPoint: address(entryPoint),
            usdc: address(0x53844F9577C2334e541Aec7Df7174ECe5dF1fCf0),
            account: ANVIL_DEFAULT_ACCOUNT
        });

        return localNetworkConfig;
    }

    function getArbMainnetConfig() public pure returns (NetworkConfig memory) {
        return
            NetworkConfig({
                entryPoint: 0x0000000071727De22E5E9d8BAf0edAc6f37da032,
                usdc: 0xaf88d065e77c8cC2239327C5EDb3A432268e5831,
                account: BURNER_WALLET
            });
    }
}
