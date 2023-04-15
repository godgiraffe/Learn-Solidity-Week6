// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract ReceiveAndFallback {
    event ReceiveEvent();
    event FallbackEvent();
    receive() external payable{
        emit ReceiveEvent();
    }

    fallback(bytes calldata aa) external payable returns(bytes memory){
        emit FallbackEvent();
        return aa;
    }

    // data != 0, value != 0, FallbackEvent
    // data != 0, value = 0, FallbackEvent
    // data = 0, value = 0, ReceiveEvent
    // data = 0, value != 0, ReceiveEvent
}