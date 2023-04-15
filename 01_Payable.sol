// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract Payable {


    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    // 接收 ether
    function deposit() external payable {

    }
    
    // 取得此合約帳戶的 balance
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}