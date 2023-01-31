// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract B3 {
    uint256 public number;
    address public msg_sender;
    uint256 public value;

    function setVars(uint256 _number) public payable {
        number = _number;
        msg_sender = msg.sender;
        value = msg.value;
    }
}