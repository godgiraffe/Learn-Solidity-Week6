// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IAbiEncodeDecode {
    function submitEncodeData(bytes calldata data) external;
}

contract StealEthers {
    event recordThis(address, address);
    IAbiEncodeDecode private abiEncodeDecode;
    address immutable owner;
    bytes32 public _password = "appworks.school.4/10.encode";
    // bytes32 _password = 0x3078633564323436303138366637323333633932376537646232646363373033;

    struct Payment {
        address receiver;
        uint256 amount;
    }

    constructor() {
        // https://sepolia.etherscan.io/address/0x4Ba9e675f6B21014B698A06Eb3E8f885513ff151#code
        abiEncodeDecode = IAbiEncodeDecode(0x4Ba9e675f6B21014B698A06Eb3E8f885513ff151);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "sorry, you're not owner");
        _;
    }

    function callSubmitEncodeData(bytes memory data) public onlyOwner{
        abiEncodeDecode.submitEncodeData(data);
    }

    function prepareAndCallSubmitEncodeData() public onlyOwner{
        uint256 amount = 0.25 ether;
        Payment memory payment = Payment(
            msg.sender,
            amount
        );
        bytes memory data = abi.encode(address(this), payment, _password);
        callSubmitEncodeData(data);
    }


    function returnSelfAddress() view external returns(address)  {
        return address(this);
    }
}
