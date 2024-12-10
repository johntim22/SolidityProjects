// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundTransfer {
    address public sender = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public receiver = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    uint256 public constant requiredAmount = 5 ether;

    event TransactionSuccessful(address from, address to, uint256 amount);
    event TransactionFailed(string message, address from);

    modifier onlySender() {
        require(msg.sender == sender, "Only the designated sender can initiate this transaction.");
        _;
    }

    function sendFunds() public payable onlySender {
        if (msg.value == requiredAmount) {
            payable(receiver).transfer(msg.value);
            emit TransactionSuccessful(msg.sender, receiver, msg.value);
        } else {
            emit TransactionFailed("Transaction canceled. Sender unable to provide funds.", msg.sender);
            revert("Transaction canceled. Insufficient funds or incorrect amount provided.");
        }
    }

    // Allow the contract to receive funds (to avoid errors in fallback situations)
    receive() external payable {}

    fallback() external payable {}
}
