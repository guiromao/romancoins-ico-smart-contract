//ICO for Roman Coins

pragma solidity ^0.4.11 

contract romancoins_ico {
    
    //max number of roman coins
    uint public max_romancoins = 1000000;
    
    //conversion rate of usd to roman coins 
    uint public usd_to_romancoins = 100;
    
    //total romancoins bought by investors
    uint public total_romancoins_bought = 0;
    
    //equity functions
    mapping(address => uint) equity_romancoins;
    mapping(address => uint) equity_usd;
    
    //check if investor can buy Roman Coins 
    modifier can_buy_romancoins(uint usd_investment){
        require(usd_investment / usd_to_romancoins + total_romancoins_bought <= max_romancoins);
        _;
    }
    
    //returns investment value in Roman Coins 
    function equity_in_romancoins(address investor) external constant returns (uint) {
        return equity_romancoins[investor];
    } 
    
    //returns investment value in USD 
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    } 
    
    //buying function for Roman Coins 
    function buy_romancoins(address investor, uint usd_investment) external can_buy_romancoins(usd_investment) {
        uint bought_romancoins = usd_investment / usd_to_romancoins;
        equity_romancoins[investor] += bought_romancoins;
        equity_usd[investor] += bought_romancoins * usd_to_romancoins;
        total_romancoins_bought += bought_romancoins;
    }
    
    //selling Roman Coins 
    function sell_romancoins(address investor, uint romancoins_sold) external {
        equity_romancoins[investor] -= romancoins_sold;
        equity_usd[investor] = equity_romancoins[investor] * usd_to_romancoins;
        total_romancoins_bought -= romancoins_sold;
    }
    
}