// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract SimpleStorage {
    
    // this will get initialized to 0!
    uint256 salary;
    bool favoriteBool;
    
    struct Employee {
        uint256 salary;
        string name;
    }
    
    Employee[] public employee;
    mapping(string => uint256) public nameTosalary;
    
    function store(uint256 _salary) public {
        salary = _salary;
    }
    
    function retrieve() public view returns(uint256) {
        return salary;
    }
    
    function addPerson(string memory _name, uint256 _salary) public{
        employee.push(Employee(_salary, _name));
        nameTosalary[_name] = _salary;
    }    
    
}