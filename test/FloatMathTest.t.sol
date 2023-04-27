// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/FloatMath.sol";

contract FloatMathTest is Test {
    using FloatMath for uint256;
    
    function testDecodeEncode18() public {
    uint256 x = 1369000000000000000;
    FloatMath.Float memory fx = FloatMath.decode18(x);
    assertEq(fx.real, 1);
    assertEq(fx.decimal, 369000000);

    uint256 newX = FloatMath.encode18(fx);
    assertEq(newX, x);
}

function testMultiply18() public {
    uint256 x = 1369000000000000000;
    uint256 y = 1010000000000000000;
    uint256 expectedResult = 1381690000000000000000;
    uint256 result = FloatMath.multiply18(x, y);
    assertEq(result, expectedResult);
}

function testDecodeEncode8() public {
    uint256 x = 1369000000;
    FloatMath.Float memory fx = FloatMath.decode8(x);
    assertEq(fx.real, 1);
    assertEq(fx.decimal, 36900000);

    uint256 newX = FloatMath.encode8(fx);
    assertEq(newX, x);
}

    function testMultiply8() public {
        uint256 x = 1369000000;
        uint256 y = 1010000000;
        uint256 expectedResult = 1381690000000000;
        uint256 result = FloatMath.multiply8(x, y);
        assertEq(result, expectedResult);
    }

    function testDecodeEncode6() public {
        uint256 x = 1369000;
        FloatMath.Float memory fx = FloatMath.decode6(x);
        assertEq(fx.real, 1);
        assertEq(fx.decimal, 369000);

        uint256 newX = FloatMath.encode6(fx);
        assertEq(newX, x);
    }

    function testMultiply6() public {
        uint256 x = 1369000;
        uint256 y = 1010000;
        uint256 expectedResult = 1381690000000;
        uint256 result = FloatMath.multiply6(x, y);
        assertEq(result, expectedResult);
    }

}
