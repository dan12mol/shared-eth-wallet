pragma solidity ^0.5.13;

contract SimpleWallet {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You are not allowed");
        _;
    }

    function withdrawMoney(address payable _to, uint256 _amount)
        public
        onlyOwner
    {
        _to.transfer(_amount);
    }

    function() external payable {}
}
