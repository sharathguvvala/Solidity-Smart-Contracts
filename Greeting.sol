// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Greeting {
    string public name;
    string public greetingPrefix = "Hello ";
    constructor(string memory _name){
        name = _name;
    }
    function setName(string memory newName) public {
        name = newName;
    }
    function getName() public view returns(string memory){
        return string(abi.encodePacked(greetingPrefix,name));
    }
}