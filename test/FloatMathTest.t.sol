// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/FloatMath.sol";

contract FloatMathTest is Test {
    using FloatMath for uint256;
    
    function testDecodeEncode18() public {
        uint256 x = 1369000000000000000;
        FloatMath.Float memory fx = FloatMath.decode18(x);
        console.log("fx.real: %s", fx.real);
        assertEq(fx.real, 1, "testDecodeEncode18: real part mismatch");
        console.log("fx.decimal: %s", fx.decimal);
        assertEq(fx.decimal, 369000000, "testDecodeEncode18: decimal part mismatch");

        uint256 newX = FloatMath.encode18(fx);
        console.log("newX: %s", newX);
        assertEq(newX, x, "testDecodeEncode18: encoded value mismatch");
    }

    function testMultiply18() public {
        uint256 x = 1369000000000000000;
        uint256 y = 1010000000000000000;
        uint256 expectedResult = 1382690000000000000000;
        uint256 result = FloatMath.multiply18(x, y);
        console.log("result: %s", result);
        assertEq(result, expectedResult, "testMultiply18: multiplication result mismatch");
    }

    function testDecodeEncode8() public {
        uint256 x = 1369000000;
        FloatMath.Float memory fx = FloatMath.decode8(x);
        console.log("fx.real: %s", fx.real);
        assertEq(fx.real, 1, "testDecodeEncode8: real part mismatch");
        console.log("fx.decimal: %s", fx.decimal);
        assertEq(fx.decimal, 36900000, "testDecodeEncode8: decimal part mismatch");

        uint256 newX = FloatMath.encode8(fx);
        console.log("newX: %s", newX);
        assertEq(newX, x, "testDecodeEncode8: encoded value mismatch");
    }

    function testMultiply8() public {
        uint256 x = 1369000000;
        uint256 y = 1010000000;
        uint256 expectedResult = 1382690000000000;
        uint256 result = FloatMath.multiply8(x, y);
        console.log("result: %s", result);
        assertEq(result, expectedResult, "testMultiply8: multiplication result mismatch");
    }

    function testDecodeEncode6() public {
        uint256 x = 1369000;
        FloatMath.Float memory fx = FloatMath.decode6(x);
        console.log("fx.real: %s", fx.real);
        assertEq(fx.real, 1, "testDecodeEncode6: real part mismatch");
        console.log("fx.decimal: %s", fx.decimal);
        assertEq(fx.decimal, 369000, "testDecodeEncode6: decimal part mismatch");

        uint256 newX = FloatMath.encode6(fx);
        console.log("newX: %s", newX);
        assertEq(newX, x, "testDecodeEncode6: encoded value mismatch");
    }

    function testMultiply6() public {
        uint256 x = 1369000;
        uint256 y = 1010000;
        uint256 expectedResult = 1382690000000;
        uint256 result = FloatMath.multiply6(x, y);
        console.log("result: %s", result);
        assertEq(result, expectedResult, "testMultiply6: multiplication result mismatch");
    }

}
