// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract SaveGas {
  uint public n;

  function noCache() external view returns(uint){
    uint s;
    for (uint256 i = 0; i < n; i++) {
      s = s +1;
    }
    return s;
  }

  function Cache()  external view returns(uint) {
    uint s;
    uint _n;
    for (uint256 i = 0; i < _n; i++) {
      s = s +1;
    }
    return s;
  }
}