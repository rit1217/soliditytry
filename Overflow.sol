// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract Overflow {

    function overflow() public view returns (uint8) {
        //uint8 max number 255
        uint8 big = 255; // uint8 big = 255 + uint8(100); = 99
        return big;
    }
}