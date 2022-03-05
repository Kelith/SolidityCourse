// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;
// importing the oracle for price feed
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";



contract FundMe {

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address owner;
    // Gets called on deploy
    constructor() public {
        owner = msg.sender;
    }

    // payable means you can send ether with the func
    function fund() public payable {
        // I want people to send minimum 50$
        uint256 minimumUSD = 50*10**18;
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more!");
        // msg.sender is the caller of the function and msg.value is the amount payed.
        // those 2 variables are associated with every transaction
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256){
        // https://docs.chain.link/docs/ethereum-addresses/ 
        // to get the address of the price feed for Rinkeby
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    // The latestRoundData function is implemented in the chainlink aggregatorv3interface
    function getPrice() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = priceFeed.latestRoundData();            //returns a tuple
        return uint256(answer);
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        // gweeeei :)
        uint256 ethAmountInUsd = (ethPrice * ethAmount)/10**18;
        return ethAmountInUsd;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Those are not your ETHs!");
        _;
    }

    function withdraw() payable onlyOwner public {
        // "this" refers to the contract we're in.     
        msg.sender.transfer(addres(this).balance);
        for (uint256 i=0; i<funders.length; i++){
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[];
    }
}