
// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;
// pragma experimental ABIEncoderV2;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// OpenZeppelin Contracts (last updated v4.7.0) (utils/Address.sol)



library Address {
   
    function isContract(address account) internal view returns (bool) {
        
        return account.code.length > 0;
    }

    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

   
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, "Address: low-level call failed");
    }

    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    function verifyCallResultFromTarget(
        address target,
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        if (success) {
            if (returndata.length == 0) {
                // only check isContract if the call was successful and the return data is empty
                // otherwise we already know that it was a contract
                require(isContract(target), "Address: call to non-contract");
            }
            return returndata;
        } else {
            _revert(returndata, errorMessage);
        }
    }

    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            _revert(returndata, errorMessage);
        }
    }

    function _revert(bytes memory returndata, string memory errorMessage) private pure {
        // Look for revert reason and bubble it up if present
        if (returndata.length > 0) {
            // The easiest way to bubble the revert reason is using memory via assembly
            /// @solidity memory-safe-assembly
            assembly {
                let returndata_size := mload(returndata)
                revert(add(32, returndata), returndata_size)
            }
        } else {
            revert(errorMessage);
        }
    }
}


// OpenZeppelin Contracts (last updated v4.6.0) (utils/math/SafeMath.sol)

library SafeMath {
   
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}



// OpenZeppelin Contracts (last updated v4.7.0) (utils/math/Math.sol)

library Math {
    enum Rounding {
        Down, // Toward negative infinity
        Up, // Toward infinity
        Zero // Toward zero
    }

    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }

    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b) / 2 can overflow.
        return (a & b) + (a ^ b) / 2;
    }

    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b - 1) / b can overflow on addition, so we distribute.
        return a == 0 ? 0 : (a - 1) / b + 1;
    }

    function mulDiv(
        uint256 x,
        uint256 y,
        uint256 denominator
    ) internal pure returns (uint256 result) {
        unchecked {
            // 512-bit multiply [prod1 prod0] = x * y. Compute the product mod 2^256 and mod 2^256 - 1, then use
            // use the Chinese Remainder Theorem to reconstruct the 512 bit result. The result is stored in two 256
            // variables such that product = prod1 * 2^256 + prod0.
            uint256 prod0; // Least significant 256 bits of the product
            uint256 prod1; // Most significant 256 bits of the product
            assembly {
                let mm := mulmod(x, y, not(0))
                prod0 := mul(x, y)
                prod1 := sub(sub(mm, prod0), lt(mm, prod0))
            }

            // Handle non-overflow cases, 256 by 256 division.
            if (prod1 == 0) {
                return prod0 / denominator;
            }

            // Make sure the result is less than 2^256. Also prevents denominator == 0.
            require(denominator > prod1);

            ///////////////////////////////////////////////
            // 512 by 256 division.
            ///////////////////////////////////////////////

            // Make division exact by subtracting the remainder from [prod1 prod0].
            uint256 remainder;
            assembly {
                // Compute remainder using mulmod.
                remainder := mulmod(x, y, denominator)

                // Subtract 256 bit number from 512 bit number.
                prod1 := sub(prod1, gt(remainder, prod0))
                prod0 := sub(prod0, remainder)
            }

            // Factor powers of two out of denominator and compute largest power of two divisor of denominator. Always >= 1.
            // See https://cs.stackexchange.com/q/138556/92363.

            // Does not overflow because the denominator cannot be zero at this stage in the function.
            uint256 twos = denominator & (~denominator + 1);
            assembly {
                // Divide denominator by twos.
                denominator := div(denominator, twos)

                // Divide [prod1 prod0] by twos.
                prod0 := div(prod0, twos)

                // Flip twos such that it is 2^256 / twos. If twos is zero, then it becomes one.
                twos := add(div(sub(0, twos), twos), 1)
            }

            // Shift in bits from prod1 into prod0.
            prod0 |= prod1 * twos;

            // Invert denominator mod 2^256. Now that denominator is an odd number, it has an inverse modulo 2^256 such
            // that denominator * inv = 1 mod 2^256. Compute the inverse by starting with a seed that is correct for
            // four bits. That is, denominator * inv = 1 mod 2^4.
            uint256 inverse = (3 * denominator) ^ 2;

            // Use the Newton-Raphson iteration to improve the precision. Thanks to Hensel's lifting lemma, this also works
            // in modular arithmetic, doubling the correct bits in each step.
            inverse *= 2 - denominator * inverse; // inverse mod 2^8
            inverse *= 2 - denominator * inverse; // inverse mod 2^16
            inverse *= 2 - denominator * inverse; // inverse mod 2^32
            inverse *= 2 - denominator * inverse; // inverse mod 2^64
            inverse *= 2 - denominator * inverse; // inverse mod 2^128
            inverse *= 2 - denominator * inverse; // inverse mod 2^256

            // Because the division is now exact we can divide by multiplying with the modular inverse of denominator.
            // This will give us the correct result modulo 2^256. Since the preconditions guarantee that the outcome is
            // less than 2^256, this is the final result. We don't need to compute the high bits of the result and prod1
            // is no longer required.
            result = prod0 * inverse;
            return result;
        }
    }

    /**
     * @notice Calculates x * y / denominator with full precision, following the selected rounding direction.
     */
    function mulDiv(
        uint256 x,
        uint256 y,
        uint256 denominator,
        Rounding rounding
    ) internal pure returns (uint256) {
        uint256 result = mulDiv(x, y, denominator);
        if (rounding == Rounding.Up && mulmod(x, y, denominator) > 0) {
            result += 1;
        }
        return result;
    }

    function sqrt(uint256 a) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        // For our first guess, we get the biggest power of 2 which is smaller than the square root of the target.
        //
        // We know that the "msb" (most significant bit) of our target number `a` is a power of 2 such that we have
        // `msb(a) <= a < 2*msb(a)`. This value can be written `msb(a)=2**k` with `k=log2(a)`.
        //
        // This can be rewritten `2**log2(a) <= a < 2**(log2(a) + 1)`
        // → `sqrt(2**k) <= sqrt(a) < sqrt(2**(k+1))`
        // → `2**(k/2) <= sqrt(a) < 2**((k+1)/2) <= 2**(k/2 + 1)`
        //
        // Consequently, `2**(log2(a) / 2)` is a good first approximation of `sqrt(a)` with at least 1 correct bit.
        uint256 result = 1 << (log2(a) >> 1);

        // At this point `result` is an estimation with one bit of precision. We know the true value is a uint128,
        // since it is the square root of a uint256. Newton's method converges quadratically (precision doubles at
        // every iteration). We thus need at most 7 iteration to turn our partial result with one bit of precision
        // into the expected uint128 result.
        unchecked {
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            return min(result, a / result);
        }
    }

    /**
     * @notice Calculates sqrt(a), following the selected rounding direction.
     */
    function sqrt(uint256 a, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = sqrt(a);
            return result + (rounding == Rounding.Up && result * result < a ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 2, rounded down, of a positive value.
     * Returns 0 if given 0.
     */
    function log2(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 128;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 64;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 32;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 16;
            }
            if (value >> 8 > 0) {
                value >>= 8;
                result += 8;
            }
            if (value >> 4 > 0) {
                value >>= 4;
                result += 4;
            }
            if (value >> 2 > 0) {
                value >>= 2;
                result += 2;
            }
            if (value >> 1 > 0) {
                result += 1;
            }
        }
        return result;
    }

   
    function log2(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log2(value);
            return result + (rounding == Rounding.Up && 1 << result < value ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 10, rounded down, of a positive value.
     * Returns 0 if given 0.
     */
    function log10(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >= 10**64) {
                value /= 10**64;
                result += 64;
            }
            if (value >= 10**32) {
                value /= 10**32;
                result += 32;
            }
            if (value >= 10**16) {
                value /= 10**16;
                result += 16;
            }
            if (value >= 10**8) {
                value /= 10**8;
                result += 8;
            }
            if (value >= 10**4) {
                value /= 10**4;
                result += 4;
            }
            if (value >= 10**2) {
                value /= 10**2;
                result += 2;
            }
            if (value >= 10**1) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 10, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log10(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log10(value);
            return result + (rounding == Rounding.Up && 10**result < value ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 256, rounded down, of a positive value.
     * Returns 0 if given 0.
     *
     * Adding one to the result gives the number of pairs of hex symbols needed to represent `value` as a hex string.
     */
    function log256(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 16;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 8;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 4;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 2;
            }
            if (value >> 8 > 0) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 10, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log256(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log256(value);
            return result + (rounding == Rounding.Up && 1 << (result << 3) < value ? 1 : 0);
        }
    }
}



// OpenZeppelin Contracts v4.4.1 (utils/Counters.sol)


library Counters {
    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1;
        }
    }

    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1;
        }
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}


// OpenZeppelin Contracts (last updated v4.7.0) (utils/Strings.sol)


// import "./math/Math.sol";

/**
 * @dev String operations.
 */
library Strings {
    bytes16 private constant _SYMBOLS = "0123456789abcdef";
    uint8 private constant _ADDRESS_LENGTH = 20;

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) internal pure returns (string memory) {
        unchecked {
            uint256 length = Math.log10(value) + 1;
            string memory buffer = new string(length);
            uint256 ptr;
            /// @solidity memory-safe-assembly
            assembly {
                ptr := add(buffer, add(32, length))
            }
            while (true) {
                ptr--;
                /// @solidity memory-safe-assembly
                assembly {
                    mstore8(ptr, byte(mod(value, 10), _SYMBOLS))
                }
                value /= 10;
                if (value == 0) break;
            }
            return buffer;
        }
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) internal pure returns (string memory) {
        unchecked {
            return toHexString(value, Math.log256(value) + 1);
        }
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }

    /**
     * @dev Converts an `address` with fixed length of 20 bytes to its not checksummed ASCII `string` hexadecimal representation.
     */
    function toHexString(address addr) internal pure returns (string memory) {
        return toHexString(uint256(uint160(addr)), _ADDRESS_LENGTH);
    }
}


// OpenZeppelin Contracts (last updated v4.7.0) (utils/StorageSlot.sol)


library StorageSlot {
    struct AddressSlot {
        address value;
    }

    struct BooleanSlot {
        bool value;
    }

    struct Bytes32Slot {
        bytes32 value;
    }

    struct Uint256Slot {
        uint256 value;
    }

    /**
     * @dev Returns an `AddressSlot` with member `value` located at `slot`.
     */
    function getAddressSlot(bytes32 slot) internal pure returns (AddressSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `BooleanSlot` with member `value` located at `slot`.
     */
    function getBooleanSlot(bytes32 slot) internal pure returns (BooleanSlot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `Bytes32Slot` with member `value` located at `slot`.
     */
    function getBytes32Slot(bytes32 slot) internal pure returns (Bytes32Slot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }

    /**
     * @dev Returns an `Uint256Slot` with member `value` located at `slot`.
     */
    function getUint256Slot(bytes32 slot) internal pure returns (Uint256Slot storage r) {
        /// @solidity memory-safe-assembly
        assembly {
            r.slot := slot
        }
    }
}


// OpenZeppelin Contracts v4.4.1 (utils/Arrays.sol)


// import "./StorageSlot.sol";
// import "./math/Math.sol";

/**
 * @dev Collection of functions related to array types.
 */
library Arrays {
    using StorageSlot for bytes32;

    function findUpperBound(uint256[] storage array, uint256 element) internal view returns (uint256) {
        if (array.length == 0) {
            return 0;
        }

        uint256 low = 0;
        uint256 high = array.length;

        while (low < high) {
            uint256 mid = Math.average(low, high);

            // Note that mid will always be strictly less than high (i.e. it will be a valid array index)
            // because Math.average rounds down (it does integer division with truncation).
            if (unsafeAccess(array, mid).value > element) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }

        // At this point `low` is the exclusive upper bound. We will return the inclusive upper bound.
        if (low > 0 && unsafeAccess(array, low - 1).value == element) {
            return low - 1;
        } else {
            return low;
        }
    }

  
    function unsafeAccess(address[] storage arr, uint256 pos) internal pure returns (StorageSlot.AddressSlot storage) {
        bytes32 slot;
        // We use assembly to calculate the storage slot of the element at index `pos` of the dynamic array `arr`
        // following https://docs.soliditylang.org/en/v0.8.17/internals/layout_in_storage.html#mappings-and-dynamic-arrays.

        /// @solidity memory-safe-assembly
        assembly {
            mstore(0, arr.slot)
            slot := add(keccak256(0, 0x20), pos)
        }
        return slot.getAddressSlot();
    }

   
    function unsafeAccess(bytes32[] storage arr, uint256 pos) internal pure returns (StorageSlot.Bytes32Slot storage) {
        bytes32 slot;
        // We use assembly to calculate the storage slot of the element at index `pos` of the dynamic array `arr`
        // following https://docs.soliditylang.org/en/v0.8.17/internals/layout_in_storage.html#mappings-and-dynamic-arrays.

        /// @solidity memory-safe-assembly
        assembly {
            mstore(0, arr.slot)
            slot := add(keccak256(0, 0x20), pos)
        }
        return slot.getBytes32Slot();
    }

    /**
     * @dev Access an array in an "unsafe" way. Skips solidity "index-out-of-range" check.
     *
     * WARNING: Only use if you are certain `pos` is lower than the array length.
     */
    function unsafeAccess(uint256[] storage arr, uint256 pos) internal pure returns (StorageSlot.Uint256Slot storage) {
        bytes32 slot;
        // We use assembly to calculate the storage slot of the element at index `pos` of the dynamic array `arr`
        // following https://docs.soliditylang.org/en/v0.8.17/internals/layout_in_storage.html#mappings-and-dynamic-arrays.

        /// @solidity memory-safe-assembly
        assembly {
            mstore(0, arr.slot)
            slot := add(keccak256(0, 0x20), pos)
        }
        return slot.getUint256Slot();
    }
}


// OpenZeppelin Contracts v4.4.1 (utils/Timers.sol)


/**
 * @dev Tooling for timepoints, timers and delays
 */
library Timers {
    struct Timestamp {
        uint64 _deadline;
    }

    function getDeadline(Timestamp memory timer) internal pure returns (uint64) {
        return timer._deadline;
    }

    function setDeadline(Timestamp storage timer, uint64 timestamp) internal {
        timer._deadline = timestamp;
    }

    function reset(Timestamp storage timer) internal {
        timer._deadline = 0;
    }

    function isUnset(Timestamp memory timer) internal pure returns (bool) {
        return timer._deadline == 0;
    }

    function isStarted(Timestamp memory timer) internal pure returns (bool) {
        return timer._deadline > 0;
    }

    function isPending(Timestamp memory timer) internal view returns (bool) {
        return timer._deadline > block.timestamp;
    }

    function isExpired(Timestamp memory timer) internal view returns (bool) {
        return isStarted(timer) && timer._deadline <= block.timestamp;
    }

    struct BlockNumber {
        uint64 _deadline;
    }

    function getDeadline(BlockNumber memory timer) internal pure returns (uint64) {
        return timer._deadline;
    }

    function setDeadline(BlockNumber storage timer, uint64 timestamp) internal {
        timer._deadline = timestamp;
    }

    function reset(BlockNumber storage timer) internal {
        timer._deadline = 0;
    }

    function isUnset(BlockNumber memory timer) internal pure returns (bool) {
        return timer._deadline == 0;
    }

    function isStarted(BlockNumber memory timer) internal pure returns (bool) {
        return timer._deadline > 0;
    }

    function isPending(BlockNumber memory timer) internal view returns (bool) {
        return timer._deadline > block.number;
    }

    function isExpired(BlockNumber memory timer) internal view returns (bool) {
        return isStarted(timer) && timer._deadline <= block.number;
    }
}


// OpenZeppelin Contracts (last updated v4.7.0) (utils/math/SafeCast.sol)
// This file was procedurally generated from scripts/generate/templates/SafeCast.js.

library SafeCast {
  
    function toUint248(uint256 value) internal pure returns (uint248) {
        require(value <= type(uint248).max, "SafeCast: value doesn't fit in 248 bits");
        return uint248(value);
    }

   
    function toUint240(uint256 value) internal pure returns (uint240) {
        require(value <= type(uint240).max, "SafeCast: value doesn't fit in 240 bits");
        return uint240(value);
    }

    function toUint232(uint256 value) internal pure returns (uint232) {
        require(value <= type(uint232).max, "SafeCast: value doesn't fit in 232 bits");
        return uint232(value);
    }

    function toUint224(uint256 value) internal pure returns (uint224) {
        require(value <= type(uint224).max, "SafeCast: value doesn't fit in 224 bits");
        return uint224(value);
    }

    function toUint216(uint256 value) internal pure returns (uint216) {
        require(value <= type(uint216).max, "SafeCast: value doesn't fit in 216 bits");
        return uint216(value);
    }

    function toUint208(uint256 value) internal pure returns (uint208) {
        require(value <= type(uint208).max, "SafeCast: value doesn't fit in 208 bits");
        return uint208(value);
    }

    function toUint200(uint256 value) internal pure returns (uint200) {
        require(value <= type(uint200).max, "SafeCast: value doesn't fit in 200 bits");
        return uint200(value);
    }

    function toUint192(uint256 value) internal pure returns (uint192) {
        require(value <= type(uint192).max, "SafeCast: value doesn't fit in 192 bits");
        return uint192(value);
    }

    function toUint184(uint256 value) internal pure returns (uint184) {
        require(value <= type(uint184).max, "SafeCast: value doesn't fit in 184 bits");
        return uint184(value);
    }

    function toUint176(uint256 value) internal pure returns (uint176) {
        require(value <= type(uint176).max, "SafeCast: value doesn't fit in 176 bits");
        return uint176(value);
    }

    function toUint168(uint256 value) internal pure returns (uint168) {
        require(value <= type(uint168).max, "SafeCast: value doesn't fit in 168 bits");
        return uint168(value);
    }

    function toUint160(uint256 value) internal pure returns (uint160) {
        require(value <= type(uint160).max, "SafeCast: value doesn't fit in 160 bits");
        return uint160(value);
    }

    function toUint152(uint256 value) internal pure returns (uint152) {
        require(value <= type(uint152).max, "SafeCast: value doesn't fit in 152 bits");
        return uint152(value);
    }

    function toUint144(uint256 value) internal pure returns (uint144) {
        require(value <= type(uint144).max, "SafeCast: value doesn't fit in 144 bits");
        return uint144(value);
    }

    function toUint136(uint256 value) internal pure returns (uint136) {
        require(value <= type(uint136).max, "SafeCast: value doesn't fit in 136 bits");
        return uint136(value);
    }

    function toUint128(uint256 value) internal pure returns (uint128) {
        require(value <= type(uint128).max, "SafeCast: value doesn't fit in 128 bits");
        return uint128(value);
    }

   
    function toUint120(uint256 value) internal pure returns (uint120) {
        require(value <= type(uint120).max, "SafeCast: value doesn't fit in 120 bits");
        return uint120(value);
    }

   
    function toUint112(uint256 value) internal pure returns (uint112) {
        require(value <= type(uint112).max, "SafeCast: value doesn't fit in 112 bits");
        return uint112(value);
    }

   
    function toUint104(uint256 value) internal pure returns (uint104) {
        require(value <= type(uint104).max, "SafeCast: value doesn't fit in 104 bits");
        return uint104(value);
    }

    function toUint96(uint256 value) internal pure returns (uint96) {
        require(value <= type(uint96).max, "SafeCast: value doesn't fit in 96 bits");
        return uint96(value);
    }

   
    function toUint88(uint256 value) internal pure returns (uint88) {
        require(value <= type(uint88).max, "SafeCast: value doesn't fit in 88 bits");
        return uint88(value);
    }

  
    function toUint80(uint256 value) internal pure returns (uint80) {
        require(value <= type(uint80).max, "SafeCast: value doesn't fit in 80 bits");
        return uint80(value);
    }

    function toUint72(uint256 value) internal pure returns (uint72) {
        require(value <= type(uint72).max, "SafeCast: value doesn't fit in 72 bits");
        return uint72(value);
    }

  
    function toUint64(uint256 value) internal pure returns (uint64) {
        require(value <= type(uint64).max, "SafeCast: value doesn't fit in 64 bits");
        return uint64(value);
    }

    function toUint56(uint256 value) internal pure returns (uint56) {
        require(value <= type(uint56).max, "SafeCast: value doesn't fit in 56 bits");
        return uint56(value);
    }

   
    function toUint48(uint256 value) internal pure returns (uint48) {
        require(value <= type(uint48).max, "SafeCast: value doesn't fit in 48 bits");
        return uint48(value);
    }

    function toUint40(uint256 value) internal pure returns (uint40) {
        require(value <= type(uint40).max, "SafeCast: value doesn't fit in 40 bits");
        return uint40(value);
    }

   
    function toUint32(uint256 value) internal pure returns (uint32) {
        require(value <= type(uint32).max, "SafeCast: value doesn't fit in 32 bits");
        return uint32(value);
    }

   
    function toUint24(uint256 value) internal pure returns (uint24) {
        require(value <= type(uint24).max, "SafeCast: value doesn't fit in 24 bits");
        return uint24(value);
    }

    
    function toUint16(uint256 value) internal pure returns (uint16) {
        require(value <= type(uint16).max, "SafeCast: value doesn't fit in 16 bits");
        return uint16(value);
    }

    
    function toUint8(uint256 value) internal pure returns (uint8) {
        require(value <= type(uint8).max, "SafeCast: value doesn't fit in 8 bits");
        return uint8(value);
    }

    
    function toUint256(int256 value) internal pure returns (uint256) {
        require(value >= 0, "SafeCast: value must be positive");
        return uint256(value);
    }

   
    function toInt248(int256 value) internal pure returns (int248 downcasted) {
        downcasted = int248(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 248 bits");
    }

   
    function toInt240(int256 value) internal pure returns (int240 downcasted) {
        downcasted = int240(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 240 bits");
    }

    
    function toInt232(int256 value) internal pure returns (int232 downcasted) {
        downcasted = int232(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 232 bits");
    }

   
    function toInt224(int256 value) internal pure returns (int224 downcasted) {
        downcasted = int224(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 224 bits");
    }

   
    function toInt216(int256 value) internal pure returns (int216 downcasted) {
        downcasted = int216(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 216 bits");
    }

    
    function toInt208(int256 value) internal pure returns (int208 downcasted) {
        downcasted = int208(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 208 bits");
    }

   
    function toInt200(int256 value) internal pure returns (int200 downcasted) {
        downcasted = int200(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 200 bits");
    }

    
    function toInt192(int256 value) internal pure returns (int192 downcasted) {
        downcasted = int192(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 192 bits");
    }

   
    function toInt184(int256 value) internal pure returns (int184 downcasted) {
        downcasted = int184(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 184 bits");
    }

   
    function toInt176(int256 value) internal pure returns (int176 downcasted) {
        downcasted = int176(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 176 bits");
    }

   
    function toInt168(int256 value) internal pure returns (int168 downcasted) {
        downcasted = int168(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 168 bits");
    }

    
    function toInt160(int256 value) internal pure returns (int160 downcasted) {
        downcasted = int160(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 160 bits");
    }

    
    function toInt152(int256 value) internal pure returns (int152 downcasted) {
        downcasted = int152(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 152 bits");
    }

   
    function toInt144(int256 value) internal pure returns (int144 downcasted) {
        downcasted = int144(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 144 bits");
    }

    function toInt136(int256 value) internal pure returns (int136 downcasted) {
        downcasted = int136(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 136 bits");
    }

    
    function toInt128(int256 value) internal pure returns (int128 downcasted) {
        downcasted = int128(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 128 bits");
    }

   
    function toInt120(int256 value) internal pure returns (int120 downcasted) {
        downcasted = int120(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 120 bits");
    }

    function toInt112(int256 value) internal pure returns (int112 downcasted) {
        downcasted = int112(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 112 bits");
    }

    function toInt104(int256 value) internal pure returns (int104 downcasted) {
        downcasted = int104(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 104 bits");
    }

    
    function toInt96(int256 value) internal pure returns (int96 downcasted) {
        downcasted = int96(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 96 bits");
    }

    
    function toInt88(int256 value) internal pure returns (int88 downcasted) {
        downcasted = int88(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 88 bits");
    }

   
    function toInt80(int256 value) internal pure returns (int80 downcasted) {
        downcasted = int80(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 80 bits");
    }

   
    function toInt72(int256 value) internal pure returns (int72 downcasted) {
        downcasted = int72(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 72 bits");
    }

   
    function toInt64(int256 value) internal pure returns (int64 downcasted) {
        downcasted = int64(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 64 bits");
    }

    
    function toInt56(int256 value) internal pure returns (int56 downcasted) {
        downcasted = int56(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 56 bits");
    }

   
    function toInt48(int256 value) internal pure returns (int48 downcasted) {
        downcasted = int48(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 48 bits");
    }

    
    function toInt40(int256 value) internal pure returns (int40 downcasted) {
        downcasted = int40(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 40 bits");
    }

    
    function toInt32(int256 value) internal pure returns (int32 downcasted) {
        downcasted = int32(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 32 bits");
    }

    function toInt24(int256 value) internal pure returns (int24 downcasted) {
        downcasted = int24(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 24 bits");
    }

    function toInt16(int256 value) internal pure returns (int16 downcasted) {
        downcasted = int16(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 16 bits");
    }

    function toInt8(int256 value) internal pure returns (int8 downcasted) {
        downcasted = int8(value);
        require(downcasted == value, "SafeCast: value doesn't fit in 8 bits");
    }

    
    function toInt256(uint256 value) internal pure returns (int256) {
        // Note: Unsafe cast below is okay because `type(int256).max` is guaranteed to be positive
        require(value <= uint256(type(int256).max), "SafeCast: value doesn't fit in an int256");
        return int256(value);
    }
}



// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/draft-IERC20Permit.sol)


interface IERC20Permit {
   
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

   
    function nonces(address owner) external view returns (uint256);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
}


//=================================={IERC20}==============================

// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)


interface IERC20 {
    
    event Transfer(address indexed from, address indexed to, uint256 value);

   
    event Approval(address indexed owner, address indexed spender, uint256 value);

    
    function totalSupply() external view returns (uint256);

  
    function balanceOf(address account) external view returns (uint256);

    
    function transfer(address to, uint256 amount) external returns (bool);

    
    function allowance(address owner, address spender) external view returns (uint256);

   
    function approve(address spender, uint256 amount) external returns (bool);

   
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}



//=================================={IERC20Metadata}==============================

// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/IERC20Metadata.sol)


// import "../IERC20.sol";

/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

//=================================={ERC20}==============================
// OpenZeppelin Contracts (last updated v4.7.0) (token/ERC20/ERC20.sol)



// import "./IERC20.sol";
// import "./extensions/IERC20Metadata.sol";
// import "../../utils/Context.sol";

/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     */
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
            // decrementing then incrementing.
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
            // Overflow not possible: amount <= accountBalance <= totalSupply.
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `amount`.
     *
     * Does not update the allowance amount in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Might emit an {Approval} event.
     */
    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * has been transferred to `to`.
     * - when `from` is zero, `amount` tokens have been minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}

// //=================================={SafeERC20}==============================


// // OpenZeppelin Contracts (last updated v4.7.0) (token/ERC20/utils/SafeERC20.sol)

// // import "../IERC20.sol";
// // import "../extensions/draft-IERC20Permit.sol";
// // import "../../../utils/Address.sol";


// /**
//  * @title SafeERC20
//  * @dev Wrappers around ERC20 operations that throw on failure (when the token
//  * contract returns false). Tokens that return no value (and instead revert or
//  * throw on failure) are also supported, non-reverting calls are assumed to be
//  * successful.
//  * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
//  * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
//  */
// library SafeERC20 {
//     using Address for address;

//     function safeTransfer(
//         IERC20 token,
//         address to,
//         uint256 value
//     ) internal {
//         _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
//     }

//     function safeTransferFrom(
//         IERC20 token,
//         address from,
//         address to,
//         uint256 value
//     ) internal {
//         _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
//     }

//     /**
//      * @dev Deprecated. This function has issues similar to the ones found in
//      * {IERC20-approve}, and its usage is discouraged.
//      *
//      * Whenever possible, use {safeIncreaseAllowance} and
//      * {safeDecreaseAllowance} instead.
//      */
//     function safeApprove(
//         IERC20 token,
//         address spender,
//         uint256 value
//     ) internal {
//         // safeApprove should only be called when setting an initial allowance,
//         // or when resetting it to zero. To increase and decrease it, use
//         // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
//         require(
//             (value == 0) || (token.allowance(address(this), spender) == 0),
//             "SafeERC20: approve from non-zero to non-zero allowance"
//         );
//         _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
//     }

//     function safeIncreaseAllowance(
//         IERC20 token,
//         address spender,
//         uint256 value
//     ) internal {
//         uint256 newAllowance = token.allowance(address(this), spender) + value;
//         _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
//     }

//     function safeDecreaseAllowance(
//         IERC20 token,
//         address spender,
//         uint256 value
//     ) internal {
//         unchecked {
//             uint256 oldAllowance = token.allowance(address(this), spender);
//             require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
//             uint256 newAllowance = oldAllowance - value;
//             _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
//         }
//     }

//     function safePermit(
//         IERC20Permit token,
//         address owner,
//         address spender,
//         uint256 value,
//         uint256 deadline,
//         uint8 v,
//         bytes32 r,
//         bytes32 s
//     ) internal {
//         uint256 nonceBefore = token.nonces(owner);
//         token.permit(owner, spender, value, deadline, v, r, s);
//         uint256 nonceAfter = token.nonces(owner);
//         require(nonceAfter == nonceBefore + 1, "SafeERC20: permit did not succeed");
//     }

//     /**
//      * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
//      * on the return value: the return value is optional (but if data is returned, it must not be false).
//      * @param token The token targeted by the call.
//      * @param data The call data (encoded using abi.encode or one of its variants).
//      */
//     function _callOptionalReturn(IERC20 token, bytes memory data) private {
//         // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
//         // we're implementing it ourselves. We use {Address-functionCall} to perform this call, which verifies that
//         // the target address contains contract code and also asserts for success in the low-level call.

//         bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
//         if (returndata.length > 0) {
//             // Return data is optional
//             require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
//         }
//     }
// }




//=================================={Ownable}==============================


// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

// import "../utils/Context.sol";

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

   
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

//=========================={                                       }=============================================
//=========================={    USDT to USD CASH  Exchange         }=============================================
//=========================={                                       }=============================================

//contract GoClientExchanger is Ownable {
contract GoExchangerToCash {
    //============================={COUNTERS}====================================================
    using Counters for Counters.Counter;
    Counters.Counter public _txIds;
    
    address public executiveManagingDirector; 
    address public escrow;
    address public tax;
    address payable public dexAddress;




//==========={Time lock with blocks}===================
    uint public startBlock = block.number;
    uint public endBlock;
    bool public started;
    bool public ended;
    uint public blocks = 480; // 2 hours; 1block => 15s ==> (2*60*60)s /15s = 480 blocks

//============={balances mapping}=====================================  
    mapping(address => mapping(address => uint256)) public accountBalances;
    mapping(address => mapping(address => uint256)) public _deposits;
    mapping(address => mapping(address => uint256)) public _withdrawals;

//============={Events}====================================
    
    event Start();
    event ClientOrder(address token, address indexed client, address indexed bank, uint CryptoPrice, uint date);
    event Withdrawn(address token, address indexed client, uint256 CryptoPrice, uint date);
    event ClientPaidCrypto(address token, address indexed client, address indexed escrow, uint CryptoPrice, uint date );
    event BankPaidCash( address indexed bank, bool status, uint date ); 
    event ClientReceivedCash( address indexed bank, bool status, uint date); 
    event BankReceivedCrypto( address indexed bank, bool status, uint date ); 
    event BankPaidCrypto( address indexed token, address indexed bank, uint CryptoPrice, uint _dexShare, uint date);
    //event BankPaidCryptoWithTax( address indexed bank, uint CryptoPrice, uint taxShare, uint dexShare, uint bankShare);  // if taxes are applied
    event ExchangeSucesseful (address token, address indexed client, address indexed bank, uint CryptoPrice, uint date);


//============================={STRUCTS}====================================================
   //========================{GENERAL STRUCTS}=========================
//============={Struct1}=====================================
    struct ExchangeVoucher {
      uint txId;
      address token;
      address client;
      address bank;
      uint CryptoPrice;
      uint tokenDecimals;
      bool completed;
      bool clientPaidCrypto;
      bool bankPaidCash;
      bool clientReceivedCash;
      bool bankReceivedCrypto;
      bool clientCreatedOrder;
      uint dexShare;
    }

    ExchangeVoucher public goExchange;

    //This mapping maps txId to token info and is helpful when retrieving details about a txId
    mapping(uint => ExchangeVoucher) private idToExchangeVoucher;
//============={Struct 2}=====================================




    constructor () {
        executiveManagingDirector = msg.sender;   
        escrow = address(this);
    }

//======================={add new tokens to the acceptible tokens list}=================================
    function whitelistToken(address token) public view returns (address) {
    require(msg.sender ==  executiveManagingDirector, 'This function is not public');

    //whitelistedTokens[symbol] = tokenAddress;
    return(token);
  }


//============================={SET FUNCTIONS}=====================================================
     function setDexAddress (address payable _newDexAddress) public returns(address) {
        require(msg.sender == executiveManagingDirector);
        dexAddress = _newDexAddress;
        return dexAddress;
    }


    function changeED (address _newExecutiveManagingDirector) public returns (address) {
        require(msg.sender == executiveManagingDirector);
        executiveManagingDirector = _newExecutiveManagingDirector;
        return executiveManagingDirector;
    }

    function changeBlocks (uint _blocks) public returns (uint) {
        require(msg.sender == executiveManagingDirector);
        blocks = _blocks;
        return blocks;
    }
//============================={GET FUNCTIONS}=====================================================
// Latest added transaction
    function getLatestidToExchangeVoucher() public view returns (ExchangeVoucher memory) {
        uint256 currentTxId = _txIds.current();
        return idToExchangeVoucher[currentTxId];
    }

// Using this we can get the voucher//
    function getExchangeVoucherForId(uint _txId) public view returns (ExchangeVoucher memory) {
        return idToExchangeVoucher[_txId];
    }

    function getCurrentTransaction() public view returns (uint) {
        return _txIds.current();
    }
//========================{get clients transactions}====================================

 //Returns all the Transactions that the current user is client only
function getClientsTransacts() public view returns (ExchangeVoucher[] memory) {
        uint totalTxCount = _txIds.current();
        uint txCount = 0;
        uint currentIndex = 0;
        uint currentId;

        //Important to get a count of all the transactions that belong to the user before we can make an array for them
        for(uint i=0; i < totalTxCount; i++)
        {
            if(idToExchangeVoucher[i+1].client == msg.sender){
                txCount += 1;
            }
        }

        //Once you have the count of relevant transactions, create an array then store all the transactions in it
        ExchangeVoucher[] memory transactions = new ExchangeVoucher[](txCount);
        for(uint i=0; i < totalTxCount; i++) { 

            //====================={Main condition}==========================================

            if(idToExchangeVoucher[i+1].client == msg.sender && idToExchangeVoucher[i+1].completed == false) { // filters only uncompleted transactions
            //if(idToExchangeVoucher[i+1].client == msg.sender) {
                currentId = i+1;
                ExchangeVoucher storage currentTx = idToExchangeVoucher[currentId];
                transactions[currentIndex] = currentTx;
                currentIndex += 1;
            }
        }
        return transactions;
    }
//get created orders
function getClientsHasCreatedOrders() public view returns (ExchangeVoucher[] memory) {
        uint totalTxCount = _txIds.current();
        uint txCount = 0;
        uint currentIndex = 0;
        uint currentId;

        //Important to get a count of all the transactions that belong to the user before we can make an array for them
        for(uint i=0; i < totalTxCount; i++)
        {
            if(idToExchangeVoucher[i+1].client == msg.sender){
                txCount += 1;
            }
        }

        //Once you have the count of relevant transactions, create an array then store all the transactions in it
        ExchangeVoucher[] memory transactions = new ExchangeVoucher[](txCount);
        for(uint i=0; i < totalTxCount; i++) { 

            //====================={Main condition}==========================================

            if(idToExchangeVoucher[i+1].client == msg.sender && idToExchangeVoucher[i+1].clientCreatedOrder == true) { // filters only uncompleted transactions
            //if(idToExchangeVoucher[i+1].client == msg.sender) {
                currentId = i+1;
                ExchangeVoucher storage currentTx = idToExchangeVoucher[currentId];
                transactions[currentIndex] = currentTx;
                currentIndex += 1;
            }
        }
        return transactions;
    }

function getClientsNewOrders() public view returns (ExchangeVoucher[] memory) {
        uint totalTxCount = _txIds.current();
        uint txCount = 0;
        uint currentIndex = 0;
        uint currentId;

        //Important to get a count of all the transactions that belong to the user before we can make an array for them
        for(uint i=0; i < totalTxCount; i++)
        {
            if(idToExchangeVoucher[i+1].client == msg.sender){
                txCount += 1;
            }
        }

        //Once you have the count of relevant transactions, create an array then store all the transactions in it
        ExchangeVoucher[] memory transactions = new ExchangeVoucher[](txCount);
        for(uint i=0; i < totalTxCount; i++) { 

        //====================={Main condition}==========================================
            if(idToExchangeVoucher[i+1].client == msg.sender && idToExchangeVoucher[i+1].clientCreatedOrder == true && idToExchangeVoucher[i+1].completed == false) { // filters only uncompleted transactions
            //if(idToExchangeVoucher[i+1].client == msg.sender) {
                currentId = i+1;
                ExchangeVoucher storage currentTx = idToExchangeVoucher[currentId];
                transactions[currentIndex] = currentTx;
                currentIndex += 1;
            }
        }
        return transactions;
    }

// client has not paid Crypto
function getClientsHasNotPaidCrypto() public view returns (ExchangeVoucher[] memory) {
        uint totalTxCount = _txIds.current();
        uint txCount = 0;
        uint currentIndex = 0;
        uint currentId;

        //Important to get a count of all the transactions that belong to the user before we can make an array for them
        for(uint i=0; i < totalTxCount; i++)
        {
            if(idToExchangeVoucher[i+1].client == msg.sender){
                txCount += 1;
            }
        }

        //Once you have the count of relevant transactions, create an array then store all the transactions in it
        ExchangeVoucher[] memory transactions = new ExchangeVoucher[](txCount);
        for(uint i=0; i < totalTxCount; i++) { 

            //====================={Main condition}==========================================

            if(idToExchangeVoucher[i+1].client == msg.sender && idToExchangeVoucher[i+1].clientPaidCrypto == false) { // filters only uncompleted transactions
            //if(idToExchangeVoucher[i+1].client == msg.sender) {
                currentId = i+1;
                ExchangeVoucher storage currentTx = idToExchangeVoucher[currentId];
                transactions[currentIndex] = currentTx;
                currentIndex += 1;
            }
        }
        return transactions;
    }

// cliet has not recieved cash
function getClientsHasNotReceivedCash() public view returns (ExchangeVoucher[] memory) {
        uint totalTxCount = _txIds.current();
        uint txCount = 0;
        uint currentIndex = 0;
        uint currentId;

        //Important to get a count of all the transactions that belong to the user before we can make an array for them
        for(uint i=0; i < totalTxCount; i++)
        {
            if(idToExchangeVoucher[i+1].client == msg.sender){
                txCount += 1;
            }
        }

        //Once you have the count of relevant transactions, create an array then store all the transactions in it
        ExchangeVoucher[] memory transactions = new ExchangeVoucher[](txCount);
        for(uint i=0; i < totalTxCount; i++) { 

            //====================={Main condition}==========================================

            if(idToExchangeVoucher[i+1].client == msg.sender && idToExchangeVoucher[i+1].clientReceivedCash == false) { // filters only uncompleted transactions
            //if(idToExchangeVoucher[i+1].client == msg.sender) {
                currentId = i+1;
                ExchangeVoucher storage currentTx = idToExchangeVoucher[currentId];
                transactions[currentIndex] = currentTx;
                currentIndex += 1;
            }
        }
        return transactions;
    }

// completed transactions
    function getClientsCompletedTransacts() public view returns (ExchangeVoucher[] memory) {
        uint totalTxCount = _txIds.current();
        uint txCount = 0;
        uint currentIndex = 0;
        uint currentId;

        //Important to get a count of all the transactions that belong to the user before we can make an array for them
        for(uint i=0; i < totalTxCount; i++)
        {
            if(idToExchangeVoucher[i+1].client == msg.sender){
                txCount += 1;
            }
        }

        //Once you have the count of relevant transactions, create an array then store all the transactions in it
        ExchangeVoucher[] memory transactions = new ExchangeVoucher[](txCount);
        for(uint i=0; i < totalTxCount; i++) { 

            //====================={Main condition}==========================================

            if(idToExchangeVoucher[i+1].client == msg.sender && idToExchangeVoucher[i+1].completed == true) { // filters only uncompleted transactions
            //if(idToExchangeVoucher[i+1].client == msg.sender) {
                currentId = i+1;
                ExchangeVoucher storage currentTx = idToExchangeVoucher[currentId];
                transactions[currentIndex] = currentTx;
                currentIndex += 1;
            }
        }
        return transactions;
    }

    // Using this we can get the voucher//
    function getOneClientsCompletedTransact(uint _txId) public view returns (ExchangeVoucher memory) {
        require(idToExchangeVoucher[_txId].client == msg.sender);
        require(idToExchangeVoucher[_txId].completed == true);
        return idToExchangeVoucher[_txId];
    }
//========================{get Banks transactions}====================================


    //Returns all the Transactions that the current user is bank only
    function getBanksTransacts() public view returns (ExchangeVoucher[] memory) {
        uint totalTxCount = _txIds.current();
        uint txCount = 0;
        uint currentIndex = 0;
        uint currentId;
        //Important to get a count of all the transactions that belong to the user before we can make an array for them
        for(uint i=0; i < totalTxCount; i++)
        {
            if(idToExchangeVoucher[i+1].bank == msg.sender){
                txCount += 1;
            }
        }

        //Once you have the count of relevant transactions, create an array then store all the transactions in it
        ExchangeVoucher[] memory transactions = new ExchangeVoucher[](txCount);
        for(uint i=0; i < totalTxCount; i++) {

            if(idToExchangeVoucher[i+1].bank == msg.sender && idToExchangeVoucher[i+1].completed == false) { // filters only uncompleted transactions
            //if(idToExchangeVoucher[i+1].bank == msg.sender) {
                currentId = i+1;
                ExchangeVoucher storage currentTx = idToExchangeVoucher[currentId];
                transactions[currentIndex] = currentTx;
                currentIndex += 1;
            }
        }
        return transactions;
    }

     //New Bank Orders
    function getBanksNewTransacts() public view returns (ExchangeVoucher[] memory) {
        uint totalTxCount = _txIds.current();
        uint txCount = 0;
        uint currentIndex = 0;
        uint currentId;
        //Important to get a count of all the transactions that belong to the user before we can make an array for them
        for(uint i=0; i < totalTxCount; i++)
        {
            if(idToExchangeVoucher[i+1].bank == msg.sender){
                txCount += 1;
            }
        }

        //Once you have the count of relevant transactions, create an array then store all the transactions in it
        ExchangeVoucher[] memory transactions = new ExchangeVoucher[](txCount);
        for(uint i=0; i < totalTxCount; i++) {

            if(idToExchangeVoucher[i+1].bank == msg.sender && idToExchangeVoucher[i+1].clientCreatedOrder == true && idToExchangeVoucher[i+1].completed == false) { // filters only uncompleted transactions
            //if(idToExchangeVoucher[i+1].bank == msg.sender) {
                currentId = i+1;
                ExchangeVoucher storage currentTx = idToExchangeVoucher[currentId];
                transactions[currentIndex] = currentTx;
                currentIndex += 1;
            }
        }
        return transactions;
    }

    // Bank has not received Crypto
    function getBanksHasNotReceivedCrypto() public view returns (ExchangeVoucher[] memory) {
        uint totalTxCount = _txIds.current();
        uint txCount = 0;
        uint currentIndex = 0;
        uint currentId;
        //Important to get a count of all the transactions that belong to the user before we can make an array for them
        for(uint i=0; i < totalTxCount; i++)
        {
            if(idToExchangeVoucher[i+1].bank == msg.sender){
                txCount += 1;
            }
        }

        //Once you have the count of relevant transactions, create an array then store all the transactions in it
        ExchangeVoucher[] memory transactions = new ExchangeVoucher[](txCount);
        for(uint i=0; i < totalTxCount; i++) {

            if(idToExchangeVoucher[i+1].bank == msg.sender && idToExchangeVoucher[i+1].bankReceivedCrypto == false) { // filters only uncompleted transactions
            //if(idToExchangeVoucher[i+1].bank == msg.sender) {
                currentId = i+1;
                ExchangeVoucher storage currentTx = idToExchangeVoucher[currentId];
                transactions[currentIndex] = currentTx;
                currentIndex += 1;
            }
        }
        return transactions;
    }

// bank has not paid Cash
    function getBanksHasNotPaidCash() public view returns (ExchangeVoucher[] memory) {
        uint totalTxCount = _txIds.current();
        uint txCount = 0;
        uint currentIndex = 0;
        uint currentId;
        //Important to get a count of all the transactions that belong to the user before we can make an array for them
        for(uint i=0; i < totalTxCount; i++)
        {
            if(idToExchangeVoucher[i+1].bank == msg.sender){
                txCount += 1;
            }
        }

        //Once you have the count of relevant transactions, create an array then store all the transactions in it
        ExchangeVoucher[] memory transactions = new ExchangeVoucher[](txCount);
        for(uint i=0; i < totalTxCount; i++) {

            if(idToExchangeVoucher[i+1].bank == msg.sender && idToExchangeVoucher[i+1].bankPaidCash == false) { // filters only uncompleted transactions
            //if(idToExchangeVoucher[i+1].bank == msg.sender) {
                currentId = i+1;
                ExchangeVoucher storage currentTx = idToExchangeVoucher[currentId];
                transactions[currentIndex] = currentTx;
                currentIndex += 1;
            }
        }
        return transactions;
    }

// completed transactions 
    function getBanksCompletedTransacts() public view returns (ExchangeVoucher[] memory) {
        uint totalTxCount = _txIds.current();
        uint txCount = 0;
        uint currentIndex = 0;
        uint currentId;
        //Important to get a count of all the transactions that belong to the user before we can make an array for them
        for(uint i=0; i < totalTxCount; i++)
        {
            if(idToExchangeVoucher[i+1].bank == msg.sender){
                txCount += 1;
            }
        }

        //Once you have the count of relevant transactions, create an array then store all the transactions in it
        ExchangeVoucher[] memory transactions = new ExchangeVoucher[](txCount);
        for(uint i=0; i < totalTxCount; i++) {

            if(idToExchangeVoucher[i+1].bank == msg.sender && idToExchangeVoucher[i+1].completed == true) { // filters only uncompleted transactions
            //if(idToExchangeVoucher[i+1].bank == msg.sender) {
                currentId = i+1;
                ExchangeVoucher storage currentTx = idToExchangeVoucher[currentId];
                transactions[currentIndex] = currentTx;
                currentIndex += 1;
            }
        }
        return transactions;
    }

     // Using this we can get the voucher//
    function getOneBanksCompletedTransact(uint _txId) public view returns (ExchangeVoucher memory) {
        require(idToExchangeVoucher[_txId].bank == msg.sender);
        require(idToExchangeVoucher[_txId].completed == true);
        return idToExchangeVoucher[_txId];   
    }


//Process Flow:

        //Crypto: client ==> dexContract ==> Bank
        //Cash: bank ==> client
       

//=========================={                          }=============================================
//=========================={    USDT TO USD CASH      }=============================================

    receive() external payable {} // Receive sent tokens or deposits

  
  // return struct values used to create the voucher from here
//returns(uint, address, address, address, address, uint, uint, uint, uint) {
//return (goExchange.txId, goExchange.token, goExchange.client, goExchange.bank, goExchange.dexAddress, goExchange.dexRoyaltyValue, goExchange.CryptoPrice, goExchange.dexShare, goExchange.bankShare);

//serviceFee : users
//dexShare: banks


/* Important*/
// call initExchange and clientDepositCrypto in the fron end function in one function to begin

    //============={Step: 1}=======================================
    //============={Step: 1}=======================================
    function getCash(address _token, address bank, uint CryptoPrice, uint dexShare,  uint serviceFee, uint tokenDecimals) public payable {
        //address payable client =  payable(msg.sender);
        require(msg.value >= serviceFee, "insufficient funds");
        dexAddress.transfer(serviceFee); // from conneted wallet of the user as a service Fee for the transaction

        _txIds.increment();
        uint txId = _txIds.current();

        clientPayCrypto ( _token, CryptoPrice);

        // start(); // timer set from 2hours by default
        started = true;
        endBlock = startBlock + blocks;

        idToExchangeVoucher[txId] = ExchangeVoucher(
            txId,
            _token,
            msg.sender,
            bank,
            CryptoPrice,
            tokenDecimals,
            false,
            true,
            false,
            false,
            false,
            true,
            dexShare
            );
       
       
        emit ClientOrder(_token, msg.sender,  bank, CryptoPrice, block.timestamp);
  
        //emit ExchangeSucesseful (bank, client, CryptoPrice, dexShare, block.timestamp);
       
        }
    //============={Step: 1}=======================================

    function  clientPayCrypto (address _token, uint CryptoPrice) public {
        accountBalances[msg.sender][_token] += CryptoPrice;
        ERC20(_token).transferFrom(msg.sender, address(this), CryptoPrice);
        accountBalances[escrow][_token] += CryptoPrice; // increase the contract's balance by the amount received
        _deposits[msg.sender][_token] += CryptoPrice; //increase the client's deposits balance by the amount sent
         emit ClientPaidCrypto(_token, msg.sender, escrow, CryptoPrice, block.timestamp);

    }



    // function start() public {
    //     require(!started, "started");
    //         started = true;
    //         endBlock = startBlock + blocks;
    //         emit Start();
    //     }

    // function setExchangeVoucher() internal {
     
    //     goExchange.completed = false; // by dafault, set to false
    //     goExchange.clientPaidCrypto = false; 
    //     goExchange.bankPaidCash = false;
    //     goExchange.clientReceivedCash = false;
    //     goExchange.bankReceivedCrypto = false;
    //     goExchange.clientCreatedOrder = true;

    //     }
    // function setExchangeValues(address _token, address bank, uint CryptoPrice, uint tokenDecimals, uint dexShare) internal {
    //     goExchange.token = _token;
    //     goExchange.client = msg.sender;
    //     goExchange.bank = bank;
    //     goExchange.CryptoPrice = CryptoPrice;
    //     goExchange.tokenDecimals = tokenDecimals;
    //     goExchange.dexShare = dexShare;
        

    // }


    function depositsOf(address _client, address token) public view returns (uint256) {
        return _deposits[_client][token];
    }
   

//============={Step: 3}=======================================

    function bankPayCash(uint _txId) public {
        uint txId = _txId;
            require(msg.sender == idToExchangeVoucher[txId].bank, "Only bank can set");   
            idToExchangeVoucher[txId].bankPaidCash = true; // confirmation 3;
            emit BankPaidCash( idToExchangeVoucher[txId].bank, true, block.timestamp); 

        }

//============={Step: 4}=======================================

    function clientGetCash(uint _txId) public {
        uint txId = _txId;
            require(msg.sender == idToExchangeVoucher[txId].client, "Only the client can set");

            idToExchangeVoucher[txId].clientReceivedCash = true; // confirmation 4;
            emit ClientReceivedCash( idToExchangeVoucher[txId].bank, true, block.timestamp); 

        }
// fetch dexShare from struct
//============={Step: 5}=======================================
    function bankGetCrypto(uint _txId, uint dexShare) public payable {
        uint txId = _txId;
        require(msg.sender == idToExchangeVoucher[txId].bank, 'Only bank can set'); // use modifier
        require(started, "not started");
        // require(block.number <= endBlock, "not ended"); Please remove
        require(withdrawalAllowed(_txId) == true, "Not permitted");
        
        require(accountBalances[idToExchangeVoucher[txId].client][idToExchangeVoucher[txId].token] >= idToExchangeVoucher[txId].CryptoPrice, "Insufficent funds");  
        require(msg.value >= dexShare, "Insufficent funds"); // transfer dexShare from bank  to the escrow contract
        accountBalances[escrow][idToExchangeVoucher[txId].token] -= idToExchangeVoucher[txId].CryptoPrice; // reduce contract balance by amount to be withdrawn
       accountBalances[idToExchangeVoucher[txId].client][idToExchangeVoucher[txId].token] -= idToExchangeVoucher[txId].CryptoPrice; // return deposit back to zero
        //_withdrawals[idToExchangeVoucher[txId].client][idToExchangeVoucher[txId].token] += idToExchangeVoucher[txId].CryptoPrice; // increase withdrawals balance by the amount sent or withdrawn

         ERC20(idToExchangeVoucher[txId].token).transfer(idToExchangeVoucher[txId].bank, idToExchangeVoucher[txId].CryptoPrice); // pay client the required token
         payable(dexAddress).transfer(dexShare); // send dexshare to dexAddress

         idToExchangeVoucher[txId].bankReceivedCrypto = true;
         idToExchangeVoucher[txId].completed = true;
        
        emit BankReceivedCrypto( idToExchangeVoucher[txId].bank, true, block.timestamp); 
        emit BankPaidCrypto(idToExchangeVoucher[txId].token, idToExchangeVoucher[txId].bank, idToExchangeVoucher[txId].CryptoPrice, dexShare, block.timestamp);

    }

    // require(accountBalances[idToExchangeVoucher[txId].client][token] >= idToExchangeVoucher[txId].CryptoPrice, 'Insufficent funds');
    // require(msg.value >= dexShare, 'Insufficent funds');

    // accountBalances[idToExchangeVoucher[txId].client][token] -= idToExchangeVoucher[txId].CryptoPrice;
    // payable(dexAddress).transfer(dexShare); // from conneted wallet of the user as a service Fee for the transaction
    // ERC20(token).transfer(idToExchangeVoucher[txId].bank, idToExchangeVoucher[txId].CryptoPrice);
//============={Step: 6}=======================================

    function withdrawalAllowed(uint txId) public view returns (bool) {
        require( idToExchangeVoucher[txId].clientPaidCrypto == true, "client had not paid Crypto"); 
        require( idToExchangeVoucher[txId].bankPaidCash == true, "bank had not paid Cash" );
        require( idToExchangeVoucher[txId].clientReceivedCash == true, "client had not received Cash ");

        return true;
    }


    function checkEscrowBal() public view returns( uint ) {

        return address(this).balance; 
    }


//clientCancel // once time expires // no charges

    function clientCancel(uint _txId) public {
        uint txId = _txId;
        ERC20 token = ERC20(idToExchangeVoucher[txId].token);
        require(block.number  >= endBlock, "ended");
        require(ended, "ended");
    
        require(_deposits[idToExchangeVoucher[txId].client][idToExchangeVoucher[txId].token] >= idToExchangeVoucher[txId].CryptoPrice, "Insufficent funds");  
        accountBalances[escrow][idToExchangeVoucher[txId].token] -= idToExchangeVoucher[txId].CryptoPrice; // reduce contract balance by amount to be withdrawn
        _deposits[idToExchangeVoucher[txId].client][idToExchangeVoucher[txId].token] -= idToExchangeVoucher[txId].CryptoPrice; // return deposit back to zero
        _withdrawals[idToExchangeVoucher[txId].client][idToExchangeVoucher[txId].token] += idToExchangeVoucher[txId].CryptoPrice; // increase withdrawals balance by the amount sent or withdrawn
        

        if (ended == true && withdrawalAllowed(txId) == false) {

                token.transfer(idToExchangeVoucher[txId].client, idToExchangeVoucher[txId].CryptoPrice);
                
              
                idToExchangeVoucher[txId].completed = true;
            
            emit Withdrawn(idToExchangeVoucher[txId].token, idToExchangeVoucher[txId].client, idToExchangeVoucher[txId].CryptoPrice, block.timestamp);
        } else {
        ended == false;
        }

        }

}


