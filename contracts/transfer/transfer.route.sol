// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./transfer.controller.sol";
import "./transfer.crud.sol";
import "./transfer.schema.sol";

contract TransferRoute is TransferController {
    constructor(address _destinationAddress) TransferController(_destinationAddress) {
    }

    // Override process incoming transfer to add storage
    function processIncomingTransfer(address sender, uint256 amount) public virtual override {
        super.processIncomingTransfer(sender, amount);
        _storeTransfer(sender, amount);
    }

    // Implement interface functions
    function getTransferCount(address user) public view override returns (uint256) {
        return transfers[user].length;
    }
    
    function hasPendingTransfer(address user) public view override returns (bool) {
        Transfer[] storage userTransfers = transfers[user];
        for(uint i = 0; i < userTransfers.length; i++) {
            if(!userTransfers[i].isProcessed) {
                return true;
            }
        }
        return false;
    }

    // Store transfer function from CRUD
    function _storeTransfer(address sender, uint256 amount) internal {
        Transfer memory newTransfer = Transfer({
            sender: sender,
            amount: amount,
            timestamp: block.timestamp,
            isProcessed: false
        });
        
        transfers[sender].push(newTransfer);
    }

    // Receive and fallback functions
    receive() external payable override {
        processIncomingTransfer(msg.sender, msg.value);
    }

    fallback() external payable override {
        processIncomingTransfer(msg.sender, msg.value);
    }
} 