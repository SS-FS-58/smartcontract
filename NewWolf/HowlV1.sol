//SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "./Authorizable.sol";
import "./WolfV1.sol";

import "hardhat/console.sol";

contract HowlV1 is ERC20, Authorizable {
    using SafeMath for uint256;
    string private TOKEN_NAME = "baby wolf howl";
    string private TOKEN_SYMBOL = "HOWL";

    address public WOLF_CONTRACT;

    // the base number of $HOWL per wolf (i.e. 0.75 $howl)
    uint256 public BASE_HOLDER_HOWLS = 750000000000000000;

    // the number of $HOWL per wolf per day per kg (i.e. 0.25 $howl /wolf /day /kg)
    uint256 public HOWLS_PER_DAY_PER_KG = 250000000000000000;

    // how much howl it costs to skip the cooldown
    uint256 public COOLDOWN_BASE = 100000000000000000000; // base 100
    // how much additional howl it costs to skip the cooldown per kg
    uint256 public COOLDOWN_BASE_FACTOR = 100000000000000000000; // additional 100 per kg
    // how long to wait before skip cooldown can be re-invoked
    uint256 public COOLDOWN_CD_IN_SECS = 86400; // additional 100 per kg

    uint256 public LEVELING_BASE = 25;
    uint256 public LEVELING_RATE = 2;
    uint256 public COOLDOWN_RATE = 3600; // 60 mins

    // uint8 (0 - 255)
    // uint16 (0 - 65535)
    // uint24 (0 - 16,777,216)
    // uint32 (0 - 4,294,967,295)
    // uint40 (0 - 1,099,511,627,776)
    // unit48 (0 - 281,474,976,710,656)
    // uint256 (0 - 1.157920892e77)

    /**
     * Stores staked wolf fields (=> 152 <= stored in order of size for optimal packing!)
     */
    struct StakedWolfObj {
        // the current kg level (0 -> 16,777,216)
        uint24 kg;
        // when to calculate howl from (max 20/02/36812, 11:36:16)
        uint32 sinceTs;
        // for the skipCooldown's cooldown (max 20/02/36812, 11:36:16)
        uint32 lastSkippedTs;
        // how much this wolf has been fed (in whole numbers)
        uint48 eatenAmount;
        // cooldown time until level up is allow (per kg)
        uint32 cooldownTs;
    }

    // redundant struct - can't be packed? (max totalKg = 167,772,160,000)
    uint40 public totalKg;
    uint16 public totalStakedWolf;

    StakedWolfObj[100001] public stakedWolf;

    // Events

    event Minted(address owner, uint256 howlsAmt);
    event Burned(address owner, uint256 howlsAmt);
    event Staked(uint256 tid, uint256 ts);
    event UnStaked(uint256 tid, uint256 ts);

    // Constructor

    constructor(address _wolfContract) ERC20(TOKEN_NAME, TOKEN_SYMBOL) {
        WOLF_CONTRACT = _wolfContract;
    }

    // "READ" Functions
    // How much is required to be fed to level up per kg

    function meetLevelingRate(uint256 kg) public view returns (uint256) {
        // need to divide the kg by 100, and make sure the meet level is at 18 decimals
        return LEVELING_BASE * ((kg / 100)**LEVELING_RATE);
    }

    // when using the value, need to add the current block timestamp as well
    function cooldownRate(uint256 kg) public view returns (uint256) {
        // need to divide the kg by 100

        return (kg / 100) * COOLDOWN_RATE;
    }

    // Staking Functions

    // stake wolf, check if is already staked, get all detail for wolf such as
    function _stake(uint256 tid) internal {
        WolfV1 x = WolfV1(WOLF_CONTRACT);

        // verify user is the owner of the wolf...
        require(x.ownerOf(tid) == msg.sender, "NOT OWNER");

        // get calc'd values...
        (, , , , , , , uint256 kg) = x.allWolfRun(tid);
        // if lastSkippedTs is 0 its mean it never have a last skip timestamp
        StakedWolfObj memory c = stakedWolf[tid];
        uint32 ts = uint32(block.timestamp);
        if (stakedWolf[tid].kg == 0) {
            // create staked wolf...
            stakedWolf[tid] = StakedWolfObj(
                uint24(kg),
                ts,
                c.lastSkippedTs > 0 ? c.lastSkippedTs :  uint32(ts - COOLDOWN_CD_IN_SECS),
                uint48(0),
                uint32(ts) + uint32(cooldownRate(kg)) 
            );

            // update snapshot values...
            // N.B. could be optimised for multi-stakes - but only saves 0.5c AUD per wolf - not worth it, this is a one time operation.
            totalStakedWolf += 1;
            totalKg += uint24(kg);

            // let ppl know!
            emit Staked(tid, block.timestamp);
        }
    }

    // function staking(uint256 tokenId) external {
    //     _stake(tokenId);
    // }

    function stake(uint256[] calldata tids) external {
        for (uint256 i = 0; i < tids.length; i++) {
            _stake(tids[i]);
        }
    }

    /**
     * Calculates the amount of howl that is claimable from a wolf.
     */
    function claimableView(uint256 tokenId) public view returns (uint256) {
        StakedWolfObj memory c = stakedWolf[tokenId];
        if (c.kg > 0) {
            uint256 howlPerDay = ((HOWLS_PER_DAY_PER_KG * (c.kg / 100)) +
                BASE_HOLDER_HOWLS);
            uint256 deltaSeconds = block.timestamp - c.sinceTs;
            return deltaSeconds * (howlPerDay / 86400);
        } else {
            return 0;
        }
    }

    // Removed "getWolf" to save space

    // struct WolfObj {
    //     uint256 kg;
    //     uint256 sinceTs;
    //     uint256 lastSkippedTs;
    //     uint256 eatenAmount;
    //     uint256 cooldownTs;
    //     uint256 requireMeetAmount;
    // }

    // function getWolf(uint256 tokenId) public view returns (WolfObj memory) {
    //     StakedWolfObj memory c = stakedWolf[tokenId];
    //     return
    //         WolfObj(
    //             c.kg,
    //             c.sinceTs,
    //             c.lastSkippedTs,
    //             c.eatenAmount,
    //             c.cooldownTs,
    //             meetLevelingRate(c.kg)
    //         );
    // }

    /**
     * Get all MY staked wolf id
     */

    function myStakedWolf() public view returns (uint256[] memory) {
        WolfV1 x = WolfV1(WOLF_CONTRACT);
        uint256 wolfCount = x.balanceOf(msg.sender);
        uint256[] memory tokenIds = new uint256[](wolfCount);
        uint256 counter = 0;
        for (uint256 i = 0; i < wolfCount; i++) {
            uint256 tokenId = x.tokenOfOwnerByIndex(msg.sender, i);
            StakedWolfObj memory wolf = stakedWolf[tokenId];
            if (wolf.kg > 0) {
                tokenIds[counter] = tokenId;
                counter++;
            }
        }
        return tokenIds;
    }

    /**
     * Calculates the TOTAL amount of howl that is claimable from ALL wolfs.
     */
    function myClaimableView() public view returns (uint256) {
        WolfV1 x = WolfV1(WOLF_CONTRACT);
        uint256 cnt = x.balanceOf(msg.sender);
        require(cnt > 0, "NO WOLF");
        uint256 totalClaimable = 0;
        for (uint256 i = 0; i < cnt; i++) {
            uint256 tokenId = x.tokenOfOwnerByIndex(msg.sender, i);
            StakedWolfObj memory wolf = stakedWolf[tokenId];
            // make sure that the token is staked
            if (wolf.kg > 0) {
                uint256 claimable = claimableView(tokenId);
                if (claimable > 0) {
                    totalClaimable = totalClaimable + claimable;
                }
            }
        }
        return totalClaimable;
    }

    /**
     * Claims howls from the provided wolfs.
     */
    function _claimHowls(uint256[] calldata tokenIds) internal {
        WolfV1 x = WolfV1(WOLF_CONTRACT);
        uint256 totalClaimableHowl = 0;
        for (uint256 i = 0; i < tokenIds.length; i++) {
            require(x.ownerOf(tokenIds[i]) == msg.sender, "NOT OWNER");
            StakedWolfObj memory wolf = stakedWolf[tokenIds[i]];
            // we only care about wolf that have been staked (i.e. kg > 0) ...
            if (wolf.kg > 0) {
                uint256 claimableHowl = claimableView(tokenIds[i]);
                if (claimableHowl > 0) {
                    totalClaimableHowl = totalClaimableHowl + claimableHowl;
                    // reset since, for the next calc...
                    wolf.sinceTs = uint32(block.timestamp);
                    stakedWolf[tokenIds[i]] = wolf;
                }
            }
        }
        if (totalClaimableHowl > 0) {
            _mint(msg.sender, totalClaimableHowl);
            emit Minted(msg.sender, totalClaimableHowl);
        }
    }

    /**
     * Claims howls from the provided wolfs.
     */
    function claimHowls(uint256[] calldata tokenIds) external {
        _claimHowls(tokenIds);
    }

    /**
     * Unstakes a wolf. Why you'd call this, I have no idea.
     */
    function _unstake(uint256 tokenId) internal {
        WolfV1 x = WolfV1(WOLF_CONTRACT);

        // verify user is the owner of the wolf...
        require(x.ownerOf(tokenId) == msg.sender, "NOT OWNER");

        // update wolf...
        StakedWolfObj memory c = stakedWolf[tokenId];
        if (c.kg > 0) {
            // update snapshot values...
            totalKg -= uint24(c.kg);
            totalStakedWolf -= 1;

            c.kg = 0;
            stakedWolf[tokenId] = c;

            // let ppl know!
            emit UnStaked(tokenId, block.timestamp);
        }
    }

    function _unstakeMultiple(uint256[] calldata tids) internal {
        for (uint256 i = 0; i < tids.length; i++) {
            _unstake(tids[i]);
        }
    }

    /**
     * Unstakes MULTIPLE wolf. Why you'd call this, I have no idea.
     */
    function unstake(uint256[] calldata tids) external {
        _unstakeMultiple(tids);
    }

    /**
     * Unstakes MULTIPLE wolf AND claims the howls.
     */
    function withdrawAllWolfAndClaim(uint256[] calldata tids) external {
        _claimHowls(tids);
        _unstakeMultiple(tids);
    }

    /**
     * Public : update the wolf's KG level.
     */
     function levelUpWolf(uint256 tid) external {
        StakedWolfObj memory c = stakedWolf[tid];
        require(c.kg > 0, "NOT STAKED");

        WolfV1 x = WolfV1(WOLF_CONTRACT);
        // NOTE Does it matter if sender is not owner?
        // require(x.ownerOf(wolfId) == msg.sender, "NOT OWNER");

        // check: wolf has eaten enough...
        require(c.eatenAmount >= meetLevelingRate(c.kg), "MORE FOOD REQD");
        // check: cooldown has passed...
        require(block.timestamp >= c.cooldownTs, "COOLDOWN NOT MET");

        // increase kg, reset eaten to 0, update next meet level and cooldown time
        c.kg = c.kg + 100;
        c.eatenAmount = 0;
        c.cooldownTs = uint32(block.timestamp + cooldownRate(c.kg));
        stakedWolf[tid] = c;

        // need to increase overall size
        totalKg += uint24(100);

        // and update the wolf contract
        x.setKg(tid, c.kg);
    }

    /**
     * Internal: burns the given amount of howls from the wallet.
     */
    function _burnHowls(address sender, uint256 howlsAmount) internal {
        // NOTE do we need to check this before burn?
        require(balanceOf(sender) >= howlsAmount, "NOT ENOUGH HOWL");
        _burn(sender, howlsAmount);
        emit Burned(sender, howlsAmount);
    }

    /**
     * Burns the given amount of howls from the sender's wallet.
     */
    function burnHowls(address sender, uint256 howlsAmount) external onlyAuthorized {
        _burnHowls(sender, howlsAmount);
    }

    /**
     * Skips the "levelUp" cooling down period, in return for burning Howl.
     */
     function skipCoolingOff(uint256 tokenId, uint256 howlAmt) external {
        StakedWolfObj memory wolf = stakedWolf[tokenId];
        require(wolf.kg != 0, "NOT STAKED");

        uint32 ts = uint32(block.timestamp);

        // NOTE Does it matter if sender is not owner?
        // WolfV1 instance = WolfV1(WOLF_CONTRACT);
        // require(instance.ownerOf(wolfId) == msg.sender, "NOT OWNER");

        // check: enough howl in wallet to pay
        uint256 walletBalance = balanceOf(msg.sender);
        require( walletBalance >= howlAmt, "NOT ENOUGH HOWL IN WALLET");

        // check: provided howl amount is enough to skip this level
        require(howlAmt >= checkSkipCoolingOffAmt(wolf.kg), "NOT ENOUGH HOWL TO SKIP");

        // check: user hasn't skipped cooldown in last 24 hrs
        require((wolf.lastSkippedTs + COOLDOWN_CD_IN_SECS) <= ts, "BLOCKED BY 24HR COOLDOWN");

        // burn howls
        _burnHowls(msg.sender, howlAmt);

        // disable cooldown
        wolf.cooldownTs = ts;
        // track last time cooldown was skipped (i.e. now)
        wolf.lastSkippedTs = ts;
        stakedWolf[tokenId] = wolf;
    }

    /**
     * Calculates the cost of skipping cooldown.
     */
    function checkSkipCoolingOffAmt(uint256 kg) public view returns (uint256) {
        // NOTE cannot assert KG is < 100... we can have large numbers!
        return ((kg / 100) * COOLDOWN_BASE_FACTOR);
    }

    /**
     * Meet Meeting the wolf
     */
    function meetWolf(uint256 tokenId, uint256 meetAmount)
        external
        onlyAuthorized
    {
        StakedWolfObj memory wolf = stakedWolf[tokenId];
        require(wolf.kg > 0, "NOT STAKED");
        require(meetAmount > 0, "NOTHING TO MEET");
        // update the block time as well as claimable
        wolf.eatenAmount = uint48(meetAmount / 1e18) + wolf.eatenAmount;
        stakedWolf[tokenId] = wolf;
    }

    // NOTE What happens if we update the multiplier, and people have been staked for a year...?
    // We need to snapshot somehow... but we're physically unable to update 10k records!!!

    // Removed "updateBaseHowls" - to make space

    // Removed "updateHowlPerDayPerKg" - to make space

    // ADMIN: to update the cost of skipping cooldown
    function updateSkipCooldownValues(
        uint256 a, 
        uint256 b, 
        uint256 c,
        uint256 d,
        uint256 e
    ) external onlyOwner {
        COOLDOWN_BASE = a;
        COOLDOWN_BASE_FACTOR = b;
        COOLDOWN_CD_IN_SECS = c;
        BASE_HOLDER_HOWLS = d;
        HOWLS_PER_DAY_PER_KG = e;
    }

    // INTRA-CONTRACT: use this function to mint howl to users
    // this also get called by the MEET contract
    function mintHowl(address sender, uint256 amount) external onlyAuthorized {
        _mint(sender, amount);
        emit Minted(sender, amount);
    }

    // ADMIN: drop howl to the given wolf wallet owners (within the wolfId range from->to).
    function airdropToExistingHolder(
        uint256 from,
        uint256 to,
        uint256 amountOfHowl
    ) external onlyOwner {
        // mint 100 howls to every owners
        WolfV1 instance = WolfV1(WOLF_CONTRACT);
        for (uint256 i = from; i <= to; i++) {
            address currentOwner = instance.ownerOf(i);
            if (currentOwner != address(0)) {
                _mint(currentOwner, amountOfHowl * 1e18);
            }
        }
    }

    // ADMIN: Rebalance user wallet by minting howl (within the wolfId range from->to).
    // NOTE: This is use when we need to update howl production
    function rebalanceHowlClaimableToUserWallet(uint256 from, uint256 to)
        external
        onlyOwner
    {
        WolfV1 instance = WolfV1(WOLF_CONTRACT);
        for (uint256 i = from; i <= to; i++) {
            address currentOwner = instance.ownerOf(i);
            StakedWolfObj memory wolf = stakedWolf[i];
            // we only care about wolf that have been staked (i.e. kg > 0) ...
            if (wolf.kg > 0) {
                _mint(currentOwner, claimableView(i));
                wolf.sinceTs = uint32(block.timestamp);
                stakedWolf[i] = wolf;
            }
        }
    }
}
