pragma solidity 0.8.13;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";

contract Authorizable is Ownable {
    mapping(address => bool) public authorized;

    modifier onlyAuthorized() {
        require(
            authorized[msg.sender] || owner() == msg.sender,
            "Only Authorized Admins are allowed to access this service"
        );
        _;
    }
    
    //FUNCTION THATS GIVES ADMIN ACCESS TO DIFFERENT ADDRESSES

    function addAuthorized(address _toAdd) public onlyOwner {
        require(_toAdd != address(0));
        authorized[_toAdd] = true;
    }
    
        //FUNCTION THATS TAKES AWAY ADMIN ACCESS TO DIFFERENT ADDRESSES

    function removeAuthorized(address _toRemove) public onlyOwner {
        require(_toRemove != address(0));
        require(_toRemove != msg.sender);
        authorized[_toRemove] = false;
    }
}
