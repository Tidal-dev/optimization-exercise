// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0; 

contract GasContract {
    mapping(address => uint256) public balances;

    function whitelist(address) external pure returns (uint256){
        return 0;
    }
    address[5] public administrators;

    uint256 senderAmount;

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed);

    constructor(address[] memory _admins, uint256) {

        for (uint256 ii = 0; ii < 5; ii++) {
            administrators[ii] = _admins[ii];
        }
        balances[address(0x1234)] = 1_000_000_000;
    }


    function checkForAdmin(address) public pure returns (bool) {
        return true;
    }

    function balanceOf(address _user) public view returns (uint256 balance_) {
        uint256 balance = balances[_user];
        return balance;
    }


    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata
    ) public {
  
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
    }

    function addToWhitelist(address _userAddrs, uint256 _tier)
        public
    {
        if(msg.sender == address(0x1234)) {
            if(_tier < 255) {

                emit AddedToWhitelist(_userAddrs, _tier);
            }
            else {
                revert();
            }
        }
        else {
            revert();
        }
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount
    ) public {

        senderAmount = _amount;

        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        
        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(address) public view returns (bool, uint256) {
        return (true, senderAmount);
    }

}
// in testWhiteTranferAmountUpdate 
// owner sends amount to sender , sender sends amount to recipient,
// could use transient storage.