// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./transfer.model.sol";

abstract contract TransferController is TransferModel {
    constructor(address _destinationAddress) {
        require(_destinationAddress != address(0), "Invalid destination address");
        destinationAddress = _destinationAddress;
        owner = msg.sender;
    }
    
    // Function to calculate transfer amount (95%)
    function _calculateTransferAmount(uint256 amount) internal pure returns (uint256) {
        return (amount * TRANSFER_PERCENTAGE) / PERCENTAGE_BASE;
    }
    
    // Function to process transfer
    function _processTransfer() internal {
        require(destinationAddress != address(0), "Destination not set");
        require(address(this).balance > 0, "No balance to transfer");
        
        uint256 amountToTransfer = _calculateTransferAmount(address(this).balance);
        
        // Transfer 95% to destination
        (bool success, ) = destinationAddress.call{value: amountToTransfer}("");
        require(success, "Transfer failed");
        
        emit TransferProcessed(msg.sender, amountToTransfer, block.timestamp);
    }
    
    // Function to handle incoming transfers
    function processIncomingTransfer(address sender, uint256 amount) public virtual {
        emit ETHReceived(sender, amount, "transfer");
        _processTransfer();
    }
    
    // Receive function
    receive() external payable virtual override {
        processIncomingTransfer(msg.sender, msg.value);
    }
    
    // Fallback function
    fallback() external payable virtual override {
        processIncomingTransfer(msg.sender, msg.value);
    }
    
    // Function to update destination address
    function setDestinationAddress(address newDestination) external onlyOwner {
        require(newDestination != address(0), "Invalid destination address");
        address oldDestination = destinationAddress;
        destinationAddress = newDestination;
        emit DestinationUpdated(oldDestination, newDestination);
    }
} 