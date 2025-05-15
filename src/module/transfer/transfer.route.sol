// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./transfer.controller.sol";
import "./transfer.crud.sol";
import "./transfer.schema.sol";

contract TransferRoute is TransferController, TransferCRUD, ITransferSchema {
    // Constructor to pass destination address to parent
    constructor(address _destinationAddress) TransferController(_destinationAddress) {
        // Constructor body can be empty as we just need to pass the parameter to parent
    }

    // Override process incoming transfer to add storage
    function processIncomingTransfer(address sender, uint256 amount) public override(TransferController, ITransferSchema) {
        super.processIncomingTransfer(sender, amount);
        _storeTransfer(sender, amount);
    }

    // Implement interface functions
    function getTransferCount(address user) public view override(TransferCRUD, ITransferSchema) returns (uint256) {
        return super.getTransferCount(user);
    }
    
    function hasPendingTransfer(address user) public view override(TransferCRUD, ITransferSchema) returns (bool) {
        return super.hasPendingTransfer(user);
    }

    // Receive and fallback functions will automatically call processIncomingTransfer
    receive() external payable override(TransferController, TransferModel) {
        processIncomingTransfer(msg.sender, msg.value);
    }

    fallback() external payable override(TransferController, TransferModel) {
        processIncomingTransfer(msg.sender, msg.value);
    }
} 