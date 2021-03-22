pragma solidity ^0.5.13;

contract SimpleWallet {
    function withdrawMoney(address payable _to, uint256 _amount) public {
        _to.transfer(_amount);
    }

    function() external payable {}
}
