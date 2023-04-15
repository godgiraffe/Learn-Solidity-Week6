// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Test {
    event Gc(bytes indexed rawPassword);
    event Log(bytes _to, bytes amount);

    function transfer(address _to, uint256 _amount) external {
        bytes memory encodeTo = abi.encode(_to);
        bytes memory encodeAmount = abi.encode(_amount);
        emit Log(encodeTo, encodeAmount);
    }

    function encodeStringPacked() public pure returns (bytes memory) {
        bytes memory someString = abi.encodePacked("some string");
        return someString;
    }

    function encodeStringBytes() public pure returns (bytes memory) {
        bytes memory someString = bytes("some string");
        return someString;
    }

    

    function getRawPassword() external {
        address tc = 0xDe495DaD76502b1f1B733162be2eb01A29c3F68a;
        (, bytes memory rawPassword) = tc.call(abi.encodeWithSignature("getEncodePassword()"));

        emit Gc(rawPassword);
    }

    // rawPassword = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470
    function decodePassword() external pure returns(bytes32) {
        bytes memory rawPassword = "0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470";
        bytes32 encodePassword = abi.decode(rawPassword, (bytes32));
        return encodePassword; // 0x3078633564323436303138366637323333633932376537646232646363373033
        // 我 bytes32 出來的是這個 = = 0x617070776f726b732e7363686f6f6c2e342f31302e656e636f64650000000000
    }
}
