// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./transfer.model.sol";

abstract contract TransferCRUD is TransferModel {
    // Function to store a new transfer
    function _storeTransfer(address sender, uint256 amount) internal {
        Transfer memory newTransfer = Transfer({
            sender: sender,
            amount: amount,
            timestamp: block.timestamp,
            isProcessed: false
        });
        
        transfers[sender].push(newTransfer);
    }
    
    // Function to get number of transfers for an address
    function getTransferCount(address user) public view virtual returns (uint256) {
        return transfers[user].length;
    }
    
    // Function to check if address has unprocessed transfers
    function hasPendingTransfer(address user) public view virtual returns (bool) {
        Transfer[] storage userTransfers = transfers[user];
        for(uint i = 0; i < userTransfers.length; i++) {
            if(!userTransfers[i].isProcessed) {
                return true;
            }
        }
        return false;
    }
} 