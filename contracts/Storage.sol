pragma solidity ^0.5.3;

/**
* @title Storage
* this contract stores the storage structure and inherited by both Proxy and Logic contract i.e: CourseV1
 */
contract Storage {
    // Teacher - teaching Course
    address public teacher;
    // Owner of proxy contract
    address public owner;
    // Course - smartcontract address
    address internal course;
    // mapping (student => marks)
    mapping (address => uint) internal marks;
    // totall students enrolled in Course
    uint public totallStudents;
}