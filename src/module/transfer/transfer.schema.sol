// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITransferSchema {
    // Events
    event ETHReceived(address indexed sender, uint256 amount, string transferType);
    event TransferProcessed(address indexed sender, uint256 amount, uint256 timestamp);
    
    // Core functions
    function getTransferCount(address user) external view returns (uint256);
    function hasPendingTransfer(address user) external view returns (bool);
    function processIncomingTransfer(address sender, uint256 amount) external;
} 