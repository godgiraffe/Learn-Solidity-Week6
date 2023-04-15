// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IAbiEncodeDecode {
    function submitEncodeData(bytes calldata data) external;

    function submitDecodeData(bytes32 data) external;
}

contract HackByAbi {
    address immutable public owner;
    constructor() {
        owner = msg.sender;
    }

    struct Payment {
        address receiver;
        uint256 amount;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "sorry, you're not owner");
        _;
    }

    function createData() public view onlyOwner returns(bytes memory){
        address sender = address(this);
        Payment memory payment = Payment({
            receiver: msg.sender,
            amount: 0.25 ether
        });

        string memory encodepassword = "appworks.school.4/10.encode";
        bytes32 _password;
        assembly {
            _password := mload(add(encodepassword, 32))
        }
        bytes memory data = abi.encode(sender, payment, _password);
        return data;
    }

    function decodeData(bytes memory _data) external view onlyOwner returns(address, Payment memory, bytes memory) {
        (address sender, Payment memory payment, bytes memory _password) = abi.decode(_data, (address, Payment, bytes));
        return (sender, payment, _password);
    }

    function callSubmitEncodeData() external onlyOwner returns (bool) {
        // https://sepolia.etherscan.io/address/0x4Ba9e675f6B21014B698A06Eb3E8f885513ff151
        address hackAddr = 0x4Ba9e675f6B21014B698A06Eb3E8f885513ff151;

        bytes memory data = createData();

        (bool success, ) = hackAddr.call(abi.encodeWithSignature("submitEncodeData(bytes)", data));
        return (success);
    }
}
