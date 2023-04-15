// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ICC {
    function addbalance(uint _n) external;
}

contract TestInterface {
    function add(uint _n, address _addr) external {
        ICC(_addr).addbalance(_n);
    }
}