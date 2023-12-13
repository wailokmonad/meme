// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {MemecoinClaim} from "../src/MemecoinClaim.sol";
import {Memecoin} from "../src/Memecoin.sol";
import {ClaimSchedule, ClaimType} from "../src/lib/Structs.sol";


contract MemecoinClaimTest is Test {
    MemecoinClaim public memecoinClaim;
    Memecoin public memecoin;
    uint256 public totalSupplyMEME = 69000000000000000000000000000;
    uint256 public digit = 10 ** 18;
    uint128 public testingMEME = uint128(100 * digit) ; // 100 MEME

    function setUp() public {
        memecoin = new Memecoin("Memecoin", "MEME", totalSupplyMEME, address(this));
        memecoinClaim = new MemecoinClaim();
        memecoinClaim.initialize(address(memecoin), address(0), address(0), address(0));
        console.log("DONE with setUp");
    }

    function test_ClaimMEME() public {

        uint256[] memory lockUpBPsArr = new uint256[](3);
        lockUpBPsArr[0] = 2500;
        lockUpBPsArr[1] = 5000;
        lockUpBPsArr[2] = 7500;

        ClaimSchedule memory c = ClaimSchedule({startCycle:0, lockUpBPs:lockUpBPsArr});
        ClaimSchedule[] memory claimScheduleArr = new ClaimSchedule[](1);
        claimScheduleArr[0] = c;

        ClaimType t = ClaimType.CommunityPresale;
        ClaimType[] memory claimTypeArr = new ClaimType[](1);
        claimTypeArr[0] = t;

        address[] memory claimAddress = new address[](1);
        claimAddress[0] = vm.addr(1);
  
        uint128[] memory amounts = new uint128[](1);
        amounts[0] = testingMEME; 
  
        memecoinClaim.setClaimSchedules(claimTypeArr, claimScheduleArr);
        ClaimSchedule memory m = memecoinClaim.getClaimSchedule(t);
        assertEq(m.lockUpBPs[0], 2500);
        assertEq(m.lockUpBPs[1], 5000);
        assertEq(m.lockUpBPs[2], 7500);

        memecoin.approve(address(memecoinClaim), totalSupplyMEME);
        memecoinClaim.depositClaimTokenAndStartClaim(totalSupplyMEME, 1);

        // memecoinClaim contract should receive all the MEME
        assertEq( memecoin.balanceOf(address(memecoinClaim)), totalSupplyMEME);

        // claim before setClaimables, should revert
        vm.prank(vm.addr(1));
        vm.expectRevert();
        memecoinClaim.claim(address(0), claimTypeArr);

        // set claimables for vm.addr(1)
        memecoinClaim.setClaimables(claimAddress, amounts, claimTypeArr);

        // claim for unregistered address, should revert
        vm.prank(vm.addr(2));
        vm.expectRevert();
        memecoinClaim.claim(address(0), claimTypeArr);

        //should be able to claim 25 MEME
        vm.startPrank(vm.addr(1));
        memecoinClaim.claim(address(0), claimTypeArr);
        assertEq( memecoin.balanceOf(vm.addr(1)), uint128(25 * digit));

        //should be able to claim a bit more MEME
        vm.warp(block.timestamp + 1 days); 
        memecoinClaim.claim(address(0), claimTypeArr);
        assertGt( memecoin.balanceOf(vm.addr(1)), uint128(25 * digit));

        //should be able to claim ALL MEME
        vm.warp(block.timestamp + 540 days); 
        memecoinClaim.claim(address(0), claimTypeArr);
        assertEq( memecoin.balanceOf(vm.addr(1)), uint128(100 * digit));

        // Nothing to claim, should revert
        vm.expectRevert();
        memecoinClaim.claim(address(0), claimTypeArr);
    }


}
