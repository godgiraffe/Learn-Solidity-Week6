// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

/**
 * 0. mesage to sign
 * 1. hash(message)
 * 2. sign(hash(message), private key) on offchain
 * 3. ecrecover(hash(message), signature)  == singer
 */


 /**
  * 1. 先將 message 拿去 hash
  * 2. 再將 hash 過的 message, 拿去跟 Ethereum 的 sined 字串，做 abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash)
  * 3. message 跟 私鑰 去產生簽章
  * 4. 從第 3 步驟的簽章中，解析出 v, r, s
  * 5. 把第 2 步驟的 EthSingedMessageHash 跟第 4 步驗的 v, r, s，丟進 ecrecover 會得到地址(公鑰) ←這個錢包地址，就是第三步驟拿私鑰去簽章的那個錢包
  * 6. 要驗算的話，有以下資料，即可確定該簽章，是為真的是那個錢包用私鑰簽的
  *    a. 簽章的錢包地址
  *    b. message 的明文
  *    c. message 跟 錢包的私鑰產生的簽章
  */
contract VerifySignature {

    function getMessageHash(
        string memory _message
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(_message));
    }

    function getEthSignedMessageHash(
        bytes32 _messageHash
    ) public pure returns (bytes32) {
        return
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    _messageHash
                )
            );
    }

    function recover(
        bytes32 _ethSignedMessageHash,
        bytes memory _sig
    ) public pure returns (address) {
      (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
      return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(bytes memory _sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
      require(_sig.length == 65, "invalid signature length");

      assembly {
        r := mload(add(_sig, 32))
        s := mload(add(_sig, 64))
        v := byte(0, mload(add(_sig, 96)))
      }
    }

    function Verify(
        address _signer,
        string memory _message,
        bytes memory _sig
    ) external pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(
            messageHash
        );

        return recover(ethSignedMessageHash, _sig) == _signer;
    }
}
