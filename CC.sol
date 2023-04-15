// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract cc {
    mapping(address => uint) public balance;

    function addbalance(uint _n) external {
        balance[msg.sender] += _n;
    }
}
