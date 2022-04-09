pragma solidity 0.8.13;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./Authorizable.sol";
import "./Nestcoin.sol";

contract BulkSender is Authorizable {
    using SafeMath for uint256;

    event LogTokenBulkSent(address from, uint256 total);
    event purchaseTickets(
        address indexed _from,
        uint256 value,
        bytes32 indexed uuid,
        uint256 time
    );
    Nestcoin nestcoin;

    constructor(address tokenAddress) {
        nestcoin = Nestcoin(tokenAddress);
    }
    //FUNCTION THAT TAKES IN AN ARRAY OF ADDRESS AND BULK TRANSFERS SAME AMOUNT TO ALL
    function AirdropSameValue(address[] calldata _to, uint256 _value)
        external
        onlyAuthorized
    {
        address from = msg.sender;
        require(_to.length <= 200, "exceed max allowed");
        uint256 sendAmount = _to.length.mul(_value);
        nestcoin.mint(
            address(this),
            sendAmount - nestcoin.balanceOf(address(this))
        );
        for (uint8 i = 0; i < _to.length; i++) {
            nestcoin.transfer(_to[i], _value);
        }
        emit LogTokenBulkSent(from, sendAmount);
    }
    
        //FUNCTION THAT TAKES IN AN ARRAY OF ADDRESS AND BULK TRANSFERS DIFFERENT AMOUNT TO ALL

    function AirdropDifferentValue(
        address[] calldata _to,
        uint256[] calldata _value
    ) external onlyAuthorized {
        address from = msg.sender;
        require(_to.length == _value.length, "invalid input");
        require(_to.length <= 200, "exceed max allowed");

        uint256 sendAmount;
        for (uint8 i = 0; i < _to.length; i++) {
            sendAmount.add(_value[i]);
        }
        nestcoin.mint(
            address(this),
            sendAmount - nestcoin.balanceOf(address(this))
        );

        for (uint8 i = 0; i < _to.length; i++) {
            nestcoin.transfer(_to[i], _value[i]);
        }
        emit LogTokenBulkSent(from, sendAmount);
    }

    //Buy of Tickets
    function purchaseTickets(uint256 _value, bytes32 uuid) public {
        nestcoin.transferFrom(msg.sender, address(this), _value);
        emit purchaseTickets(msg.sender, _value, uuid, block.timestamp);
    }
    //SELF DESTRUCT FUNTION THAT SENDS ALL TOKENS TO THE OWNER OF THE CONTRACT IN CASE OF ANY HACK
    function _destroyContract() private {
        selfdestruct(owner);
    }
}
