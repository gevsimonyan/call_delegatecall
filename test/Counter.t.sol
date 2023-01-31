// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/A1.sol";
import "../src/A2.sol";
import "../src/A3.sol";

import "../src/B1.sol";
import "../src/B2.sol";
import "../src/B3.sol";
import "forge-std/console2.sol";

contract CounterTest is Test {

    // enum A {
    //     A, // 0
    //     B, // 1
    //     C // 2
    // }

    // A public a; // A

    B1 public b1;
    A1 public a1;

    B2 public b2;
    A2 public a2;

    B3 public b3;
    A3 public a3;

    function setUp() public {

        b1 = new B1();
        a1 = new A1();

        b2 = new B2();
        a2 = new A2();

        b3 = new B3();
        a3 = new A3();
    }

    function testABI() public {

        // ecrecover();

        // encode/decode
        address addr = address(1);
        uint256 num = 11223344;
        bytes memory encode_data = abi.encode(addr, num);

        console.log("======================");
        console.log("address is: ", addr);
        console.log("uint256 is: ", num);
        console.log("======================");

        console.log();

        console.log("======================");
        console.log("Encode function output");
        console2.logBytes(encode_data);
        console.log("======================");

        console.log();

        (address addr1, uint256 num1) = abi.decode(encode_data, (address, uint256));
        console.log("address1 is: ", addr1);
        console.log("num1: ", num1);

        // abi.encodePacked

        bytes memory packed_data = abi.encodePacked(addr, num);
        
        console.log("======================");
        console.log("Encode packed function output");
        console2.logBytes(packed_data);
        console.log("======================");
        
        console.log();

        console.log("======================");
        console.log("encode Packed");
        console2.logBytes(abi.encodePacked("Hello World"));
        console.log("encode");
        console2.logBytes(abi.encode("Hello World"));
        console.log("======================");

        console.log();

        // keccak256
        bytes32 keccak_output = keccak256(abi.encodePacked("Helo World")); 
        console.log("======================");
        console.log("Keccak output");
        console2.logBytes32(keccak_output);
        console.log("======================");

        // call function via selector
        bytes memory payload1 = abi.encodeWithSignature("functionName(address, uint256)", addr, num);
        bytes memory payload2 = abi.encodeWithSelector(
            bytes4(keccak256(bytes("functionName(address, uint256)"))),
            addr,
            num
        );

        console.log();

        console.log("======================");
        console.log("Payload1");
        console2.logBytes(payload1);
        console.log("======================");

        console.log();

        console.log("======================");
        console.log("Payload2");
        console2.logBytes(payload2);
        console.log("======================");

    }

    function testCallInterface() public {
        console.log("===================================================");
        console.log("A1 before call number:     ", a1.number());
        console.log("A1 before call msg_sender: ", a1.msg_sender());
        console.log("A1 before call value:      ", a1.value());
        console.log("-----------------------------------------------------------------");
        console.log("B1 before call number:     ", b1.number());
        console.log("B1 before call msg_sender: ", b1.msg_sender());
        console.log("B1 before call value:      ", b1.value());
        console.log("===================================================");
        console.log();
        
        a1.setVars{value: 2222}(address(b1), 1111);
        
        console.log();
        console.log("===================================================");
        console.log("A1 after call number:     ", a1.number());
        console.log("A1 after call msg_sender: ", a1.msg_sender());
        console.log("A1 after call value:      ", a1.value());
        console.log("-----------------------------------------------------------------");
        console.log("B1 after call number:     ", b1.number());
        console.log("B1 after call msg_sender: ", b1.msg_sender());
        console.log("B1 after call value:      ", b1.value());
        console.log("===================================================");
    }

    function testCallViaCall() public {
        console.log("===================================================");
        console.log("A2 before call number:     ", a2.number());
        console.log("A2 before call msg_sender: ", a2.msg_sender());
        console.log("A2 before call value:      ", a2.value());
        console.log("-----------------------------------------------------------------");
        console.log("B2 before call number:     ", b2.number());
        console.log("B2 before call msg_sender: ", b2.msg_sender());
        console.log("B2 before call value:      ", b2.value());
        console.log("===================================================");
        console.log();

        a2.setVars{value: 2222}(address(b2), 1111);

        console.log();
        console.log("===================================================");
        console.log("A2 after call number:     ", a2.number());
        console.log("A2 after call msg_sender: ", a2.msg_sender());
        console.log("A2 after call value:      ", a2.value());
        console.log("-----------------------------------------------------------------");
        console.log("B2 after call number:     ", b2.number());
        console.log("B2 after call msg_sender: ", b2.msg_sender());
        console.log("B2 after call value:      ", b2.value());
        console.log("===================================================");
    }

    function testCallViaDelegateeCall() public {
        console.log("===================================================");
        console.log("A3 before call number:     ", a3.number());
        console.log("A3 before call msg_sender: ", a3.msg_sender());
        console.log("A3 before call value:      ", a3.value());
        console.log("===================================================");
        console.log("-----------------------------------------------------------------");
        console.log("===================================================");
        console.log("B3 before call number:     ", b3.number());
        console.log("B3 before call msg_sender: ", b3.msg_sender());
        console.log("B3 before call value:      ", b3.value());
        console.log("===================================================");
        console.log();
        
        a3.setVars{value: 2222}(address(b3), 1111);
        
        console.log();
        console.log("===================================================");
        console.log("A3 after call number:     ", a3.number());
        console.log("A3 after call msg_sender: ", a3.msg_sender());
        console.log("A3 after call value:      ", a3.value());
        console.log("===================================================");
        console.log("-----------------------------------------------------------------");
        console.log("===================================================");
        console.log("B3 after call number:     ", b3.number());
        console.log("B3 after call msg_sender: ", b3.msg_sender());
        console.log("B3 after call value:      ", b3.value());
        console.log("===================================================");
    }
}
