pragma solidity 0.8.13;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Authorizable.sol";

// learn more: https://docs.openzeppelin.com/contracts/3.x/erc20

contract Nestcoin is ERC20, Authorizable {
    constructor() ERC20("Nestcoin", "NCN") {
        _mint(msg.sender, 1000000 * 10**18);
    }

    function mint(address to, uint256 amount) public onlyAuthorized {
        _mint(to, amount);
    }
}
