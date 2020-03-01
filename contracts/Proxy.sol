pragma solidity ^0.5.3;
import "./Storage.sol";

/**
* @title Proxy
* This contract delegate's calls to Logic implementation contract with the help of its fallback function.
* also enables Logic implementation contract to be upgraded.
 */
contract Proxy is Storage {

    
    /**
     * @dev constructor that sets the owner address
     */
    constructor() public {
        owner = msg.sender;
        teacher = msg.sender;
    }
    
  /**
    * @dev Modifier - ensures caller is owner
    *
     */
    modifier onlyOwner() {
        require (msg.sender == owner);
        _;
    }


    /**
     * @dev Upgrades the Course contract address
     * @param _newCourse address of new/updated course contract
     */
    function upgradeTo(address _newCourse) external onlyOwner 
    {
        require(course != _newCourse);
        _setCourse(_newCourse);
    }
    
    /**
     * @dev Fallback function allowing to perform a delegatecall 
     * to the given 'course' contract. This function will return 
     * whatever the 'course' call returns
     */
    function () payable external {
        address impl = course;
        require(impl != address(0));
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize)
            let result := delegatecall(gas, impl, ptr, calldatasize, 0, 0)
            let size := returndatasize
            returndatacopy(ptr, 0, size)
            
            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }
    
    /**
     * @dev Sets the address of the current course
     * @param _newCourse address of the new course version
     */
    function _setCourse(address _newCourse) internal {
        course = _newCourse;
    }
}
