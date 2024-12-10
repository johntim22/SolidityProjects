// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TimedEthTransfer {
    address public immutable sender;
    address public immutable recipient;
    uint256 public immutable totalAmount;
    uint256 public immutable initialTransfer;
    uint256 public immutable secondTransfer;
    uint256 public immutable finalTransfer;
    
    uint256 public immutable deploymentTime;

    uint256 public transferredAmount;

    // Events for transfer logs
    event TransferCompleted(address indexed from, address indexed to, uint256 amount);

    // Constructor to set sender, recipient, and initial parameters
    constructor() payable {
        sender = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        recipient = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;

        totalAmount = 50 ether;
        initialTransfer = 5 ether;
        secondTransfer = 20 ether;
        finalTransfer = 25 ether;

        require(msg.value == totalAmount, "Contract must be funded with exactly 50 ETH");

        deploymentTime = block.timestamp;
    }

    // Function to execute the initial transfer immediately
    function executeInitialTransfer() external {
        require(msg.sender == sender, "Only the sender can execute transfers");
        require(transferredAmount == 0, "Initial transfer already executed");

        payable(recipient).transfer(initialTransfer);
        transferredAmount += initialTransfer;

        emit TransferCompleted(sender, recipient, initialTransfer);
    }

    // Function to execute the second transfer after 10 minutes
    function executeSecondTransfer() external {
        require(msg.sender == sender, "Only the sender can execute transfers");
        require(transferredAmount == initialTransfer, "Second transfer can only occur after the initial transfer");
        require(block.timestamp >= deploymentTime + 2 minutes, "Second transfer not allowed yet");

        payable(recipient).transfer(secondTransfer);
        transferredAmount += secondTransfer;

        emit TransferCompleted(sender, recipient, secondTransfer);
    }

    // Function to execute the final transfer after 20 minutes
    function executeFinalTransfer() external {
        require(msg.sender == sender, "Only the sender can execute transfers");
        require(transferredAmount == initialTransfer + secondTransfer, "Final transfer can only occur after the second transfer");
        require(block.timestamp >= deploymentTime + 3 minutes, "Final transfer not allowed yet");

        payable(recipient).transfer(finalTransfer);
        transferredAmount += finalTransfer;

        emit TransferCompleted(sender, recipient, finalTransfer);
    }

    // Fallback function to accept Ether
    receive() external payable {}
}
