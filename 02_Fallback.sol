// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;


contract Fallback {
/*
- fallback() 是當你呼叫的函數不存在於智能合約時會被調用的特殊函數。
- 回退函數主要用於接收直接發送的以太幣。
- 接收(recevie)函數與回退(fallback)函數的差別在於接收函數只有在接收到空的message.data時才會被調用。

- 要懂啥是 msg.dta

fallback() or receive()?

    Ether is sent to contract
                |
        is msg.data empty?
             /      \
receive() exits?    fallback()
          /    \
        yes    no
        /        \
    receive()     fallback()
*/
    event Log(string func, address sender, uint value, bytes data);
    // 蠻常用於直接接收 ether，所以會在這邊加上 payable
    // msg.data 有值，就執行 fallback()
    // 沒值的話，有 receive() 就執行 receive()，沒 receive() 的話，就執行 fallback()
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    // receive 是強制需要 payable 
    receive() external payable{
        // 這邊如果輸入 msg.data，會有錯，理由是： receive 不能輸入 msg.data
        // 根本理由是 msg.ata 為空時，才會進來 receive()
        emit Log("receive", msg.sender, msg.value, "");
    }
}