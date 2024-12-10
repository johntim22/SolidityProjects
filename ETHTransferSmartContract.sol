// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EthTransferCancun {
    address public immutable sender;
    address public immutable recipient;
    uint256 public immutable amount;

    // Event to log transfer details
    event TransferCompleted(address indexed from, address indexed to, uint256 amount);

    // Constructor to set sender, recipient, and amount
    constructor() payable {
        sender = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        recipient = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
        amount = 12 ether;

        require(msg.value == amount, "Contract must be funded with exactly 12 ETH");
    }

    // Function to execute the transfer
    function executeTransfer() external {
        require(msg.sender == sender, "Only the sender can execute the transfer");
        require(address(this).balance >= amount, "Insufficient contract balance");

        payable(recipient).transfer(amount);

        emit TransferCompleted(sender, recipient, amount);
    }

    // Fallback function to accept Ether
    receive() external payable {}
}
