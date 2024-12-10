// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PaymentFullDemo {
    address public immutable sender;
    address public immutable reciever;
    uint256 public immutable amount;

    event TransferComplete(address indexed sender, address indexed reciever, uint256 amount);

    //constructor() payable {
      //  sender=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
      //  reciever=0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
      //  amount= 90 ether;

      //  require(msg.value==amount, "Contract must be funded first with 90 ETH exactly!");
   // }

    function executetransfer() external {
        require(msg.sender==sender,"Only the sender can perform transactions");
        require(address(this).balance >= amount, "Insufficient contract balance");

        payable(reciever).transfer(amount);

        emit TransferComplete(sender, reciever, amount);
    }

    receive() external payable { }

}
