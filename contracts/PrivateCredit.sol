// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract testTen{
    address public owner;
     mapping(address=>uint256) private credits;
     mapping(address=>uint256) private lastTimestamp;

     event scoreUpdated(address user,uint256 tiestamp);

    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"Only owner can execute");
        _;
    }

    function updateScore(address user, uint256 score,uint256 timestamp) public onlyOwner{
        credits[user]=score;
        lastTimestamp[user]=timestamp;
        emit scoreUpdated(user, timestamp);

    }

    function getCreditScore(address user) onlyOwner view public returns(uint256) {
        return credits[user];
    }
    function getLastTimestamp(address user) onlyOwner view public returns(uint256) {
        return lastTimestamp[user];
    }
}

