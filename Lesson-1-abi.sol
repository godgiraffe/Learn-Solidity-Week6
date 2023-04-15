// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.9 <0.9.0;

contract AbiTest {
    // abi.encode、abi.decode 的使用方法
    // abi.encode 和 abi.encodePacked 的差異
    // abi.encodeWithSignature 和 abi.encodeWithSelector 的差異和使用時機

    // msg.sender = 0x5b38da6a701c568545dcfcb03fcb875f56beddc4, _uint = 1;
    // 0x0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4
    // 0000000000000000000000000000000000000000000000000000000000000001

    // msg.sender = 0x5b38da6a701c568545dcfcb03fcb875f56beddc4, _uint = 255;
    // 0x0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4
    // 00000000000000000000000000000000000000000000000000000000000000ff ← 255 的 hex

    // 123
    // 0x000000000000000000000000000000000000000000000000000000000000007b
    function abiEncod1(uint256 _uint1) public pure returns(bytes memory){
        return abi.encode(_uint1);
    }
    // 123, 456
    // 0000 00000000000000000000 00000000000000000000 0000000000000000007b
    // 00000000000000000000000000000000000000000000000000000000000001c8
    function abiEncode2(uint256 _uint1, uint256 _uint2) public view returns (bytes memory) {
        return abi.encode(_uint1, _uint2);
    }

    function abiDecode(bytes memory data) public pure returns (address _addr, uint256 _number) {
        (_addr, _number) = abi.decode(data, (address, uint256));
    }

    function abiEncode(uint256 _uint) public view returns (bytes memory) {
        return abi.encode(msg.sender, _uint);
    }

    function abiEncodePacked(uint256 _uint) public view returns (bytes memory) {
        return abi.encodePacked(msg.sender, _uint);
    }

    function abiDecodePacked(bytes memory data) public pure returns (address _addr, uint256 _uint) {
        uint256 ADDRESS_LENGTH = 0x14;
        uint256 UINT256_LENGTH = 0x20;

        address x;
        uint y;
        assembly {
            x := mload(add(data, ADDRESS_LENGTH))
            y := mload(add(data, add(ADDRESS_LENGTH, UINT256_LENGTH)))
        }
        
        return (x,y);
    }
}
