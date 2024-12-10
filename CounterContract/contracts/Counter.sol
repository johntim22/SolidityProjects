pragma solidity ^0.5.0;

contract Counter {
    // State variable to store the counter value
    int256 public count;

    // Constructor to set the initial value
    constructor() public {
        count = 5; // Initial value
    }

    // Function to add a value to the counter
    function add(int256 value) public {
        count += value;
    }

    // Function to subtract a value from the counter
    function subtract(int256 value) public {
        count -= value;
    }

    // Function to reset the counter to the initial value
    function reset() public {
        count = 5;
    }
}
