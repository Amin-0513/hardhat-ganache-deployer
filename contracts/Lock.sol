// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract Solidity {

    address public owner;

    uint public nextId = 1;
    uint public constant REGISTRATION_FEE = 1 ether;

    modifier validCNIC(string memory _cnic) {
        bytes memory b = bytes(_cnic);
        require(b.length == 13, "CNIC must be 13 digits");
        for (uint i = 0; i < b.length; i++) {
            require(b[i] >= 0x30 && b[i] <= 0x39, "CNIC must contain digits only");
        }
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "This action is performed only by the owner. You are not the owner.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    struct Student {
        uint id;
        string studentName;
        string fatherName;
        uint age;
        string cnic;
        address studentAddress;
    }

    mapping(address => Student) public students;
    address[] public allStudentAddresses;

    function registerStudent( string memory _studentName, string memory _fatherName, uint _age, string memory _cnic ) external payable validCNIC(_cnic) {
        require(msg.value == REGISTRATION_FEE, "Registration fee must be 1 ether");
        require(msg.sender != owner, "Owner cannot register");
        require(students[msg.sender].id == 0, "Student already registered");

        // Transfer registration fee to owner
        (bool success, ) = owner.call{value: msg.value}("");
        require(success, "Fee transfer failed");

        students[msg.sender] = Student({
            id: nextId,
            studentName: _studentName,
            fatherName: _fatherName,
            age: _age,
            cnic: _cnic,
            studentAddress: msg.sender
        });

        allStudentAddresses.push(msg.sender);
        nextId++;
    }

    function getStudentByAddress(address _studentAddress) external view returns ( uint id, string memory studentName, string memory fatherName, uint age, string memory cnic)
    {
        Student memory s = students[_studentAddress];
        require(s.id != 0, "Student does not exist");
        return (s.id, s.studentName, s.fatherName, s.age, s.cnic);
    }

    function getAllStudents() external view onlyOwner returns (Student[] memory) {
        Student[] memory result = new Student[](allStudentAddresses.length);
        for (uint i = 0; i < allStudentAddresses.length; i++) {
            result[i] = students[allStudentAddresses[i]];
        }
        return result;
    }
}
