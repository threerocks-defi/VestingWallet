// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./VestingWalletWithClawback.sol";
import "./VestingWalletWithCliff.sol";
import "./VestingWalletWithReleaseGuard.sol";

/**
 * @title VestingWalletWithCliffAndClawback
 * @dev This contract builds on OpenZeppelin's VestingWallet. See comments in VestingWallet for base details.
 *
 * This contract adds the following functionality:
 *   - Add `owner`: contract is `Ownable2Step`
 *   - Add clawbacks: contract `owner` can clawback any unvested tokens
 *   - Add post-clawback sweeps: contract `owner` can sweep any excess tokens sent to the contract after clawback
 *   - Add a vesting cliff: `beneficiary` cannot claim any vested tokens until a cliff duration has elapsed
 *   - Add a release guard: only `beneficiary` can release vested funds; no one can force funds upon `beneficiary`
 */
contract VestingWalletWithCliffAndClawback is
    VestingWalletWithClawback,
    VestingWalletWithCliff,
    VestingWalletWithReleaseGuard
{

    /**
     * @dev Set the cliff and owner.
     * @dev Set the beneficiary, start timestamp, and vesting duration within VestingWallet base class.
     */
    constructor(
        address ownerAddress,
        address beneficiaryAddress,
        uint64 startTimestamp,
        uint64 durationSeconds,
        uint64 cliffDurationSeconds
    ) payable 
        VestingWallet(beneficiaryAddress, startTimestamp, durationSeconds)
        VestingWalletWithCliff(cliffDurationSeconds)
        VestingWalletWithClawback(ownerAddress)
    {
        // solhint-disable-previous-line no-empty-blocks
    }

    /// @inheritdoc VestingWalletWithClawback
    function releasable() public view override(VestingWallet, VestingWalletWithClawback) returns (uint256) {
        return super.releasable();
    }

    /// @inheritdoc VestingWalletWithClawback
    function releasable(address token)
        public
        view
        override(VestingWallet, VestingWalletWithClawback)
        returns (uint256)
    {
        return super.releasable(token);
    }

    /// @inheritdoc VestingWalletWithReleaseGuard
    function release() public override(VestingWallet, VestingWalletWithReleaseGuard) {
        return super.release();
    }

    /// @inheritdoc VestingWalletWithReleaseGuard
    function release(address token) public override(VestingWallet, VestingWalletWithReleaseGuard) {
        return super.release(token);
    }

    /// @inheritdoc VestingWalletWithCliff
    function _vestingSchedule(uint256 totalAllocation, uint64 timestamp)
        internal
        view
        virtual
        override(VestingWallet, VestingWalletWithCliff)
        returns (uint256)
    {
        return super._vestingSchedule(totalAllocation, timestamp);
    }
}
