// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

//have to be deploy in testnet
//import chainlink code
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

//send fund to contract = the funded contract is now the owner of that ether
contract FundMe {

    mapping(address => uint256) public addressToAmountFunded;
    //payable : function can be use to pay (assocciate with value(wei/gwei/etc.))
    function fund() public payable {
        //keywords in every contract call in every transaction :
        //msg.sender  :  sender of the function call
        //msg.value   : how much they send
        addressToAmountFunded[msg.sender] += msg.value;
        // what ETH -> USD conversion rate
    }

    function getVersion() public view returns (uint256) {
        //passed address of ETH/USD from doc.chain.link/ethereum data feeds
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    //return current price of ETH in terms of USD
    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        //latestRoundData() returns tuple of these data
        //(uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) = priceFeed.latestRoundData();
        (, int256 answer, , ,) = priceFeed.latestRoundData();
        //type casting
        return uint256(answer);
        //return as 8 decimals
        //e.g. 248255877123 = 2482.55877123 USD
    }

    // 10^9 wei = 1 gwei
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        //with 18 decimals
        return ethAmountInUsd;
    }
}