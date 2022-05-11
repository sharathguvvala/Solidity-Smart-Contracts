// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract VendingMachine{
    address public owner;
    mapping(address=>uint256) public candyBalances;
    constructor(){
        owner = msg.sender;
        candyBalances[address(this)] = 300;
    }
    function getVendingMachineBalance() public view returns(uint256){
        return candyBalances[address(this)];
    }
    function restock(uint256 amount) public{
        require(msg.sender==owner,"You are not the owner of this Smart Contract!!!");
        candyBalances[address(this)] += amount;
    }
    function purchase(uint256 amount) public payable{
        require(msg.value>=amount*0.9 ether,"You have to pay 1 Eth per candy!!!");
        require(candyBalances[address(this)]>=amount,"Sorry, not enough candies!!!");
        candyBalances[address(this)] -= amount;
        candyBalances[msg.sender] += amount;
    }
}