// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./BaseVestingWalletFactory.sol";

/**
 * @title VestingWalletWithCliffAndClawbackFactory
 * @dev Factory for VestingWalletWithCliffAndClawback. See VestingWalletWithCliffAndClawback.sol for details.
 */
contract VestingWalletWithCliffAndClawbackFactory is BaseVestingWalletFactory {

    /**
     * @dev Creates, logs, and registers a new VestingWalletWithCliffAndClawback.
     */
    function create(
        address ownerAddress,
        address beneficiaryAddress,
        uint64 startTimestamp,
        uint64 durationSeconds,
        uint64 cliffDurationSeconds
    ) public virtual returns (address) {
        return _create(
            ownerAddress,
            beneficiaryAddress,
            startTimestamp,
            durationSeconds,
            cliffDurationSeconds
        );
    }
}
