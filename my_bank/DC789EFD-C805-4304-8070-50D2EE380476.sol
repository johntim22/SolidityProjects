pragma solidity ^0.5.8;

contract MyBank {
    uint8 private clientNum;
    mapping (address => uint) private balances;
    address public owner;

    event LogDepositMade(address indexed accountAddress, uint amount);

    constructor() public payable {
        require(msg.value == 30 ether, "30 ether initial funding required");
        owner = msg.sender;
        clientNum = 0;
    }

    function enroll() public returns (uint) {
        if (clientNum < 3) {
            clientNum++;
            balances[msg.sender] = 10 ether;
        }
        return balances[msg.sender];
    }

    function deposit() public payable returns (uint) {
        balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }

    function withdraw(uint withdrawAmount) public returns (uint remainingBal) {
        if (withdrawAmount <= balances[msg.sender]) {
            balances[msg.sender] -= withdrawAmount;
            msg.sender.transfer(withdrawAmount);
        }
        return balances[msg.sender];
    }

    function balance() public view returns (uint) {
        return balances[msg.sender];
    }

    function depositsBalance() public view returns (uint) {
        return address(this).balance;
    }
}
