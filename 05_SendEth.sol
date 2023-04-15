// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract SendEth {
    constructor() payable {}

    receive() external payable {}

    function sendViaTransfer(address payable _to) external payable {
        // gas	37750 gas
        // transaction cost	32826 gas
        // execution cost	11394 gas
        // 剩餘 gas : 2260
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable {
        // gas	37778 gas
        // transaction cost	32850 gas
        // execution cost	11418 gas
        // 剩餘 gas : 2260
        bool sent = _to.send(123);
        require(sent, "send failed");
    }

    function sendViaCall(address payable _to) external payable {
        // gas	38040 gas
        // transaction cost	33078 gas
        // execution cost	11646 gas
        // 剩餘 gas : 6521
        (bool success, ) = _to.call{value: 123}("");
        require(success, "call failed");
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}
