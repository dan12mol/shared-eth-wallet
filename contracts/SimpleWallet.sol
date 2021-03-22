pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SimpleWallet is Ownable {
    mapping(address => uint256) public allowance;

    function addAllowance(address _who, uint256 _amount) public onlyOwner {
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint256 _amount) {
        require(
            owner() == msg.sender || allowance[msg.sender] >= _amount,
            "You are not allowed"
        );
        _;
    }

    function reduceAllowance(address _who, uint256 _amount) internal {
        allowance[_who] -= _amount;
    }

    function withdrawMoney(address payable _to, uint256 _amount)
        public
        ownerOrAllowed(_amount)
    {
        require(
            _amount <= address(this).balance,
            "There are not enough funds stored in the smart contract"
        );
        if (owner() != msg.sender) {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }

    receive() external payable {}

    fallback() external {}
}
