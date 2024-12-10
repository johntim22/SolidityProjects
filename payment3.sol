// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TimedEthTransfer {
    address public immutable sender;
    address public immutable recipient;

    uint256 public constant initialTransferAmount = 5 ether;
    uint256 public constant secondTransferAmount = 20 ether;
    uint256 public constant finalTransferAmount = 25 ether;

    uint256 public firstTransferTime;
    uint256 public secondTransferTime;

    uint256 public transferredAmount;

    // Events for transfer logs
    event TransferCompleted(address indexed from, address indexed to, uint256 amount);
    event FundReceived(address indexed from, uint256 amount);

    constructor() {
        sender = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        recipient = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    }

    // Function to handle funding and transfer for the first installment
    function fundAndTransferInitial() external payable {
        require(msg.sender == sender, "Only the sender can fund");
        require(msg.value == initialTransferAmount, "Must fund exactly 5 ETH for the initial transfer");
        require(transferredAmount == 0, "Initial transfer already executed");

        // Transfer to recipient
        payable(recipient).transfer(initialTransferAmount);
        transferredAmount += initialTransferAmount;

        // Record the time of the first transfer
        firstTransferTime = block.timestamp;

        emit TransferCompleted(sender, recipient, initialTransferAmount);
    }

    // Function to handle funding and transfer for the second installment
    function fundAndTransferSecond() external payable {
        require(msg.sender == sender, "Only the sender can fund");
        require(msg.value == secondTransferAmount, "Must fund exactly 20 ETH for the second transfer");
        require(transferredAmount == initialTransferAmount, "Second transfer can only occur after the initial transfer");
        require(block.timestamp >= firstTransferTime + 10 minutes, "Second transfer not allowed yet");

        // Transfer to recipient
        payable(recipient).transfer(secondTransferAmount);
        transferredAmount += secondTransferAmount;

        // Record the time of the second transfer
        secondTransferTime = block.timestamp;

        emit TransferCompleted(sender, recipient, secondTransferAmount);
    }

    // Function to handle funding and transfer for the final installment
    function fundAndTransferFinal() external payable {
        require(msg.sender == sender, "Only the sender can fund");
        require(msg.value == finalTransferAmount, "Must fund exactly 25 ETH for the final transfer");
        require(transferredAmount == initialTransferAmount + secondTransferAmount, "Final transfer can only occur after the second transfer");
        require(block.timestamp >= secondTransferTime + 10 minutes, "Final transfer not allowed yet");

        // Transfer to recipient
        payable(recipient).transfer(finalTransferAmount);
        transferredAmount += finalTransferAmount;

        emit TransferCompleted(sender, recipient, finalTransferAmount);
    }

    // Fallback function to accept Ether
    receive() external payable {
        emit FundReceived(msg.sender, msg.value);
    }
}
