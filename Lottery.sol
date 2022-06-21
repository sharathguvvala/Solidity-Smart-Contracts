// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Lottery{
    address public owner;
    address payable[] public players;
    uint public lotteryId;
    mapping (uint => address payable) public lotteryWinners;
    constructor(){
        owner = msg.sender;
        lotteryId = 1;
    }
    modifier onlyOwner(){
        require(msg.sender==owner,"You are not the owner of this Smart Contract!!!");
        _;
    }
    modifier joinOnlyOneTime(){
        uint flag;
        for(uint i=0; i<players.length; i++){
            if(players[i]==msg.sender){
                flag = 1;
            }
            else{
                flag = 0;
            }
        }
        require(flag==0,"You have already joined the lottery!!!");
        _;
    }
    function joinLottery() public payable joinOnlyOneTime{
        require(msg.value > 2.9 ether,"You have to pay 3 Eth to join lottery!!!");
        players.push(payable(msg.sender));
    }
    function generateRandomNumber() public view returns(uint){
        return uint(keccak256(abi.encodePacked(owner,block.timestamp)));
    }
    function pickWinner() public onlyOwner{
        uint index = generateRandomNumber() % players.length;
        players[index].transfer(address(this).balance);
        lotteryWinners[lotteryId] = players[index];
        lotteryId++;
        players = new address payable[](0);
    }
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    function getPlayers() public view returns(address payable[] memory){
        return players;
    }
}