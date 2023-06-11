// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// This is the simple simulation of DAO RE-ENTERANCY ATTACK

contract globalIMEBank{
   
   // mapping for checking balances using account address.
   mapping(address => uint) public balances;
   
   // deposite function will deposit balance to the contract from account
   function deposit() external payable {
      balances[msg.sender] += msg.value;
   }
   
   // withdraw function will withdraw all the deposited funds and set the account owner balance as 0;
   function withdraw() external payable {
      uint bal = balances[msg.sender];
      (bool success,) = msg.sender.call{value: bal}("");
      require(success,"GlobalIMEBank: transaction failed");
      balances[msg.sender] = 0;
   }

}
