// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

contract FundMe {

    mapping(address => uint256) public addressToAmountFunded;
    //payable : function can be use to pay (assocciate with value(wei/gwei/etc.))
    function fund() public payable {
        //keywords in every contract call in every transaction :
        //msg.sender  :  sender of the function call
        //msg.value   : how much they send
        addressToAmountFunded[msg.sender] += msg.value;

    }
}