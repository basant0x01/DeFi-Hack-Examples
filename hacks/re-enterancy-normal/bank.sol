// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// This is the simple simulation of DAO RE-ENTERANCY ATTACK

contract globalIMEBank{

   mapping(address => uint) public balances;

   function deposit() external payable {
      balances[msg.sender] += msg.value;
   }

   function withdraw() external payable {
      uint bal = balances[msg.sender];
      (bool success,) = msg.sender.call{value: bal}("");
      require(success,"GlobalIMEBank: transaction failed");
      balances[msg.sender] = 0;
   }

}
