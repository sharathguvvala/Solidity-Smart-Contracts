// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Salary{
    struct Employee {
        uint salary;
        uint timePeriod;
        bool paid;
    }
    mapping (address => Employee) public employees;
    address public manager;
    constructor (){
        manager = msg.sender;
    }
    function addEmployee(address employeeAddress, uint _timePeriod) external payable{
        require(msg.sender == manager, 'You dont have access to add employee!');
        if(msg.sender.balance < msg.value){
            revert('You dont have enough funds!');
        }
        require(!(employees[employeeAddress].salary > 0), 'Employe already exists!');
        require(msg.value > 0, 'Salary should be greater than zero!');
        employees[employeeAddress] = Employee(msg.value, block.timestamp+_timePeriod, false);
    }
    function withdrawSalary() external{
        Employee storage employee = employees[msg.sender];
        require(employee.timePeriod <= block.timestamp, 'You cannot withdraw salary yet!');
        if(msg.sender == manager){
            require(false, 'You are the manager!');
        }
        else if(employee.paid==false){
            payable(msg.sender).transfer(employee.salary);
            employee.paid = true;
        }
        else{
            require(false, 'You have already withdrawn your salary!');
        }
    }
}