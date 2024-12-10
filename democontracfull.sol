// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract mydemo1 {

     uint256 public samplenumber;
     string public mas1;
     event Log(string _message);

    function reset() public {
        samplenumber=0;
    }

    function add() public {
        samplenumber++;
    }

  function check() public {
    if (samplenumber>10){
        mas1="value greatet than 10";
    } else {
        mas1="value lower than 10";
    }
    // This line will print the message to Remix's console:
    emit Log(mas1);
}

}
