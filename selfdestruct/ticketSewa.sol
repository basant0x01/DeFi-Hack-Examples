// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// The goal of this lottery is to allow players to buy tickets for 1 Ether each.
// The lottery will select a winner when 10 tickets are sold.
// The winner can withdraw the total balance.

// 1. Deploy Lottery contract.
// 2. Players (say Alice and Bob) buy tickets by sending 1 Ether each.
// 3. Deploy Attack contract with address of Lottery.
// 4. Call Attack.attack sending 5 Ether. This will break the lottery.
// No winner can be selected.

// What happened?
// The attacker's action increases the balance of the Lottery contract to 5.1 Ether,
// causing it to exceed the 10 ticket limit. The lottery cannot select a winner.

contract Lottery {
    uint256 public constant ticketPrice = 1 ether;
    uint256 public constant maxTickets = 3;
    address public winner;
    uint256 public ticketCount;

    function buyTicket() public payable {
        require(msg.value == ticketPrice, "Ticket costs 1 Ether");
        require(ticketCount < maxTickets, "Maximum tickets sold");

        ticketCount++;

        if (ticketCount == maxTickets) {
            // If max tickets reached, pick a winner randomly
            winner = msg.sender; // Simplified winner selection for this example
        }
    }

    function claimReward() public {
        require(msg.sender == winner, "Not the winner");

        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}