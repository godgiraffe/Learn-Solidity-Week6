// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract A_Call {
    address public msgSender;
    address public txOrigin;

    function useCall(address addr) external {
        (bool success, bytes memory data) = addr.call(
            abi.encodeWithSignature("getMsgTx()")
        );
    }

    function useDelegatecall(address addr) external {
        (bool success3, bytes memory data3) = addr.delegatecall(
            abi.encodeWithSignature("getMsgTx()")
        );
    }

    function getMsgTx() public returns (bytes memory) {
        msgSender = msg.sender;
        txOrigin = tx.origin;
        return bytes("a");
    }

    function resetState() public {
        msgSender = address(0);
        txOrigin = address(0);
    }
}

contract B_Call {
    address public msgSender;
    address public txOrigin;

    function useCall(address addr) external {
        (bool success, bytes memory data) = addr.call(
            abi.encodeWithSignature("getMsgTx()")
        );
    }

    function useDelegatecall(address addr) external {
        (bool success3, bytes memory data3) = addr.delegatecall(
            abi.encodeWithSignature("getMsgTx()")
        );
    }

    function getMsgTx() public returns (bytes memory) {
        msgSender = msg.sender;
        txOrigin = tx.origin;
        return bytes("a");
    }

    function resetState() public {
        msgSender = address(0);
        txOrigin = address(0);
    }
}

contract C_Call {
    address public msgSender;
    address public txOrigin;

    function useCall(address addr) external {
        (bool success, bytes memory data) = addr.call(
            abi.encodeWithSignature("getMsgTx()")
        );
    }

    function useDelegatecall(address addr) external {
        (bool success3, bytes memory data3) = addr.delegatecall(
            abi.encodeWithSignature("getMsgTx()")
        );
    }

    function getMsgTx() public returns (bytes memory) {
        msgSender = msg.sender;
        txOrigin = tx.origin;
        return bytes("a");
    }

    function resetState() public {
        msgSender = address(0);
        txOrigin = address(0);
    }
}

contract Call {
    uint256 public a;
    address public msgSender;
    address public txOrigin;

    function calls(address addr, uint256 s) public {
        /* 
      To Do: Call setA()
      (bool success, bytes memory data) = ...
      */

        (bool success, bytes memory data) = addr.staticcall(
            abi.encodeWithSignature("setA(uint256)", s)
        );

        //   (bool success, bytes memory data) = A.setA();
        //   addr.call(bytes4(keccak256("setA(uint256)")), s);
        //   abi.encodeWithSignature("setA(uint256)", s);
        require(success, "1");
        /* 
      To Do: Call getA()
      (bool success, bytes memory data) = ...
      */

        (bool success2, bytes memory data2) = addr.staticcall(
            abi.encodeWithSignature("getA()")
        );
        uint256 a = abi.decode(data2, (uint256));
        require(a == s);
    }

    function useDelegatecall(address addr) external {
        (bool success3, bytes memory data3) = addr.delegatecall(
            abi.encodeWithSignature("getA()")
        );
    }
}

contract A {
    uint256 public a;
    address public msgSender;
    address public txOrigin;

    function setA(uint256 _a) public {
        a = _a;
    }

    function getA() public returns (uint256) {
        msgSender = msg.sender;
        txOrigin = tx.origin;
        return a;
    }
}

contract A_L3 {
    // uint256 public a = 0;
    


    function setA(uint256 newA) external {
        a = newA;
    }
}

contract B_L3 {
    uint8 public aa;
    uint64 public bb;
    uint256 public amount;

    function callSetA(address a) external {
        bytes memory hash = abi.encodeWithSignature("setA(uint256)", 512);
        (bool success, bytes memory data) = a.delegatecall(hash);
    }
}
