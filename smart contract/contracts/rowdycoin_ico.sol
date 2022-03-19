// Rowdycoins ico

pragma solidity ^0.4.11;

contract rowdycoin_ico {
    // Introducing the maximum number of Rowdycoins available for sale
    uint public max_rowdycoins = 1000000;

    // Introducing the USD to Rowdycoins conversion rate

    uint public usd_to_rowdycoins = 1000;

    // Introducing the total number of Rowdycoins that have been bought by the investers

    uint public total_rowdycoins_bought = 0;

    // Mapping from the investor address to its equity to Rowdycoins and USD

    mapping(address => uint) equity_rowdycoins;
    mapping(address => uint) equity_usd;

    // Checking if an investor can by Rowdycoins

    modifier can_buy_rowdycoins(uint usd_invested) {
        require(usd_invested * usd_to_rowdycoins + total_rowdycoins_bought < max_rowdycoins);
        _;
    }

    // Getting the equity in Rowdycoins of an investor

    function equity_in_rowdycoins(address investor) external constant returns (uint rowdycoins) {
       return equity_rowdycoins[investor];
    }

    // Getting the equity in USD of an investor

    function equity_in_usd(address investor) external constant returns (uint usd_amount) {
       return equity_usd[investor];
    }

    // Buying Rowdycoins

    function buy_rowdycoins(address investor, uint usd_invested) external
    can_buy_rowdycoins(usd_invested) {
        uint rowdycoins_bought = usd_invested * usd_to_rowdycoins;
        equity_rowdycoins[investor] += rowdycoins_bought;
        equity_usd[investor] = equity_rowdycoins[investor] / 1000;
        total_rowdycoins_bought += rowdycoins_bought;
    }

    // Selling Rowdycoins
    function sell_rowdycoins(address investor, uint rowdycoins_sold) external {
        equity_rowdycoins[investor] -= rowdycoins_sold;
        equity_usd[investor] = equity_rowdycoins[investor] / 1000;
        total_rowdycoins_bought -= rowdycoins_sold;
    }
}
