// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract A2 {
    uint256 public number;
    address public msg_sender;
    uint256 public value;

    function setVars(address _contract,uint256 _number) public payable {
        (bool success, bytes memory data) = _contract.call{value: msg.value}(
            abi.encodeWithSignature("setVars(uint256)", _number) 
        );
    }
}


