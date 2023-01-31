// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IB1 {
    function setVars(uint256 _number) external payable;
}

contract A1 {
    uint256 public number;
    address public msg_sender;
    uint256 public value;
    IB1 public b1;

    function setVars(address _b1, uint256 _number) public payable {
        b1 = IB1(_b1);
        b1.setVars{value: msg.value}(_number);
    }
}