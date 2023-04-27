// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// @title FloatMath
/// @notice Library for encoding, decoding, and multiplying floats
/// @dev Floats are represented as a uint256 with the real part in the upper 128 bits and the decimal part in the lower 128 bits
/// @author @MiguelBits

library FloatMath {
    struct Float {
        uint128 real;
        uint128 decimal;
    }
    
    function decode18(uint256 x) internal pure returns (Float memory) {
        uint128 r = uint128(x / 1e18);
        uint128 d = uint128(x % 1e18);
        return Float(r, d);
    }

    function encode18(Float memory x) internal pure returns (uint256) {
        return uint256(x.real) * 1e18 + uint256(x.decimal);
    }

    function decode8(uint256 x) internal pure returns (Float memory) {
        uint128 r = uint128(x / 1e8);
        uint128 d = uint128(x % 1e8) * 100000000;
        return Float(r, d);
    }

    function encode8(Float memory x) internal pure returns (uint256) {
        return uint256(x.real) * 1e8 + uint256(x.decimal / 100000000);
    }

    function decode6(uint256 x) internal pure returns (Float memory) {
        uint128 r = uint128(x / 1e6);
        uint128 d = uint128(x % 1e6) * 1000000;
        return Float(r, d);
    }

    function encode6(Float memory x) internal pure returns (uint256) {
        return uint256(x.real) * 1e6 + uint256(x.decimal / 1000000);
    }

    function multiply18(uint256 x, uint256 y) internal pure returns (uint256) {
        Float memory fx = decode18(x);
        Float memory fy = decode18(y);
        uint256 r = uint256(fx.real) * uint256(fy.real);
        uint256 d = uint256(fx.real) * uint256(fy.decimal) + uint256(fy.real) * uint256(fx.decimal);
        d /= 1e18;
        return r + d;
    }

    function multiply8(uint256 x, uint256 y) internal pure returns (uint256) {
        Float memory fx = decode8(x);
        Float memory fy = decode8(y);
        uint256 r = uint256(fx.real) * uint256(fy.real);
        uint256 d = uint256(fx.real) * uint256(fy.decimal) + uint256(fy.real) * uint256(fx.decimal);
        d /= 1e8;
        return r + d;
    }

    function multiply6(uint256 x, uint256 y) internal pure returns (uint256) {
        Float memory fx = decode6(x);
        Float memory fy = decode6(y);
        uint256 r = uint256(fx.real) * uint256(fy.real);
        uint256 d = uint256(fx.real) * uint256(fy.decimal) + uint256(fy.real) * uint256(fx.decimal);
        d /= 1e6;
        return r + d;
    }
}
