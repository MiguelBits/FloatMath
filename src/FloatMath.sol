pragma solidity ^0.8.0;

library FloatMath {
    struct Float {
        uint128 real;
        uint128 decimal;
    }

    // Encode / Decode functions for 18 decimal places
    function decode18(uint256 x) internal pure returns (Float memory) {
        return decode(x, 1e9);
    }

    function encode18(Float memory floatNum) internal pure returns (uint256) {
        return encode(floatNum, 1e9);
    }

    // Encode / Decode functions for 8 decimal places
    function decode8(uint256 x) internal pure returns (Float memory) {
        return decode(x, 1e4);
    }

    function encode8(Float memory floatNum) internal pure returns (uint256) {
        return encode(floatNum, 1e4);
    }

    // Encode / Decode functions for 6 decimal places
    function decode6(uint256 x) internal pure returns (Float memory) {
        return decode(x, 1e3);
    }

    function encode6(Float memory floatNum) internal pure returns (uint256) {
        return encode(floatNum, 1e3);
    }

    // Generic Encode / Decode functions
    function decode(uint256 x, uint256 scaleFactor) private pure returns (Float memory) {
        uint128 real = uint128((x / scaleFactor) % scaleFactor);
        uint128 decimal = uint128(x % scaleFactor);
        return Float(real, decimal);
    }

    function encode(Float memory floatNum, uint256 scaleFactor) private pure returns (uint256) {
        return (uint256(floatNum.real) * scaleFactor) + uint256(floatNum.decimal);
    }

    // Multiply functions for different decimal places
    function multiply18(uint256 x, uint256 y) internal pure returns (uint256) {
        return multiply(x, y, 1e9);
    }

    function multiply8(uint256 x, uint256 y) internal pure returns (uint256) {
        return multiply(x, y, 1e4);
    }

    function multiply6(uint256 x, uint256 y) internal pure returns (uint256) {
        return multiply(x, y, 1e3);
    }

    function multiply(uint256 x, uint256 y, uint256 scaleFactor) private pure returns (uint256) {
        Float memory fx = decode(x, scaleFactor);
        Float memory fy = decode(y, scaleFactor);

        // Perform multiplication on real and decimal parts
        uint256 rr = uint256(fx.real) * uint256(fy.real);
        uint256 rd = uint256(fx.real) * uint256(fy.decimal);
        uint256 dr = uint256(fx.decimal) * uint256(fy.real);
        uint256 dd = uint256(fx.decimal) * uint256(fy.decimal);

        // Adjust results and carry for the scaleFactor
        uint256 carry = (rd / scaleFactor) + (dr / scaleFactor) + (dd / (scaleFactor * scaleFactor));
        uint256 result = rr + carry;

        // Check for overflow
        require(result >= rr, "FloatMath: multiplication overflow");

        // Combine real and decimal parts back into uint256
        result = result * scaleFactor + ((rd % scaleFactor) + (dr % scaleFactor) + (dd % scaleFactor));
        return result;
    }
}
