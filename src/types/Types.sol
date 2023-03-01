// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

////////////////////////////////////////////////////////////////
//                           Global                           //
////////////////////////////////////////////////////////////////

/// @notice A dedicated type for a hash.
type Hash is bytes32;

/// @notice A dedicated type for a scalar gas value.
type Gas is uint64;

/// @notice A dedicated type for a timestamp value.
/// @dev Unit: seconds
type Timestamp is uint64;

/// @notice A dedicated type for a duration value.
/// @dev Unit: seconds
type Duration is uint64;

////////////////////////////////////////////////////////////////
//                          Structs                           //
////////////////////////////////////////////////////////////////

/// @notice OutputProposal represents a commitment to the L2 state. The timestamp is the L1
///       timestamp that the output root is posted. This timestamp is used to verify that the
///       finalization period has passed since the output root was submitted.
/// @custom:field outputRoot    Hash of the L2 output.
/// @custom:field timestamp     Timestamp of the L1 block that the output root was submitted in.
/// @custom:field l2BlockNumber L2 block number that the output corresponds to.
struct OutputProposal {
    Hash outputRoot;
    uint128 timestamp;
    uint128 l2BlockNumber;
}

/// @notice Struct representing the elements that are hashed together to generate an output root
///       which itself represents a snapshot of the L2 state.
/// @custom:field version                  Version of the output root.
/// @custom:field stateRoot                Root of the state trie at the block of this output.
/// @custom:field messagePasserStorageRoot Root of the message passer storage trie.
/// @custom:field latestBlockhash          Hash of the block this output was generated from.
struct OutputRootProof {
    bytes32 version;
    Hash stateRoot;
    Hash messagePasserStorageRoot;
    Hash latestBlockhash;
}

/// @notice Struct representing a deposit transaction (L1 => L2 transaction) created by an end
///       user (as opposed to a system deposit transaction generated by the system).
/// @custom:field from        Address of the sender of the transaction.
/// @custom:field to          Address of the recipient of the transaction.
/// @custom:field isCreation  True if the transaction is a contract creation.
/// @custom:field value       Value to send to the recipient.
/// @custom:field mint        Amount of ETH to mint.
/// @custom:field gasLimit    Gas limit of the transaction.
/// @custom:field data        Data of the transaction.
/// @custom:field l1BlockHash Hash of the block the transaction was submitted in.
/// @custom:field logIndex    Index of the log in the block the transaction was submitted in.
struct UserDepositTransaction {
    address from;
    address to;
    bool isCreation;
    uint256 value;
    uint256 mint;
    Gas gasLimit;
    bytes data;
    Hash l1BlockHash;
    uint256 logIndex;
}

/// @notice Struct representing a withdrawal transaction.
/// @custom:field nonce    Nonce of the withdrawal transaction
/// @custom:field sender   Address of the sender of the transaction.
/// @custom:field target   Address of the recipient of the transaction.
/// @custom:field value    Value to send to the recipient.
/// @custom:field gasLimit Gas limit of the transaction.
/// @custom:field data     Data of the transaction.
struct WithdrawalTransaction {
    uint256 nonce;
    address sender;
    address target;
    uint256 value;
    uint256 gasLimit;
    bytes data;
}
