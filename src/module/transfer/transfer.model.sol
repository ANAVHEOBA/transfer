// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract TransferModel {
    // Owner of the contract
    address public owner;
    
    // Structure to store transfer details
    struct Transfer {
        address sender;
        uint256 amount;
        uint256 timestamp;
        bool isProcessed;
    }
    
    // Destination Coinbase address
    address public destinationAddress;
    
    // Transfer percentage (95% = 9500)
    uint256 public constant TRANSFER_PERCENTAGE = 9500;
    uint256 public constant PERCENTAGE_BASE = 10000;
    
    // Mapping to store transfers
    mapping(address => Transfer[]) public transfers;
    
    // Events for transfer tracking
    event TransferProcessed(address indexed sender, uint256 amount, uint256 timestamp);
    event DestinationUpdated(address indexed oldDestination, address indexed newDestination);
    event ETHReceived(address indexed sender, uint256 amount, string transferType);
    
    // Modifier to restrict functions to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // Virtual functions
    receive() external payable virtual;
    fallback() external payable virtual;
} 