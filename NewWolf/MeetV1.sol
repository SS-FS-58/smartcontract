//SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "./Authorizable.sol";
import "./WolfV1.sol";
import "./HowlV1.sol";

import "hardhat/console.sol";

contract MeetV1 is ERC20, Authorizable {
    using SafeMath for uint256;

    uint256 public MAX_MEET_SUPPLY = 32000000000000000000000000000;
    string private TOKEN_NAME = "Wolf meet";
    string private TOKEN_SYMBOL = "MEET";

    address public WOLF_CONTRACT;
    address public HOWL_CONTRACT;

    uint256 public BOOSTER_MULTIPLIER = 1;
    uint256 public MEET_FARMING_FACTOR = 3; // howl to meet ratio
    uint256 public MEET_SWAP_FACTOR = 12; // swap howl for meet ratio

    // Moved "SKIP_COOLDOWN_BASE" to HowlV1 contract
    // Moved "SKIP_COOLDOWN_BASE_FACTOR" to HowlV1 contract

    // meet mint event
    event Minted(address owner, uint256 numberOfMeet);
    event Burned(address owner, uint256 numberOfMeet);
    event HowlSwap(address owner, uint256 numberOfMeet);
    // howl event
    event MintedHowl(address owner, uint256 numberOfMeet);
    event BurnedHowl(address owner, uint256 numberOfHowls);
    event StakedHowl(address owner, uint256 numberOfHowls);
    event UnstakedHowl(address owner, uint256 numberOfHowls);

    // Howl staking
    struct HowlStake {
        // user wallet - who we have to pay back for the staked howl.
        address user;
        // used to calculate how much meet since.
        uint32 since;
        // amount of howls that have been staked.
        uint256 amount;
    }

    mapping(address => HowlStake) public howlStakeHolders;
    uint256 public totalHowlStaked;
    address[] public _allHowlsStakeHolders;
    mapping(address => uint256) private _allHowlsStakeHoldersIndex;

    // howl stake and unstake
    event HowlStaked(address user, uint256 amount);
    event HowlUnStaked(address user, uint256 amount);

    constructor(address _wolfContract, address _howlContract)
        ERC20(TOKEN_NAME, TOKEN_SYMBOL)
    {
        WOLF_CONTRACT = _wolfContract;
        HOWL_CONTRACT = _howlContract;
    }

    /**
     * pdates user's amount of staked howls to the given value. Resets the "since" timestamp.
     */
    function _upsertHowlStaking(
        address user,
        uint256 amount
    ) internal {
        // NOTE does this ever happen?
        require(user != address(0), "EMPTY ADDRESS");
        HowlStake memory howl = howlStakeHolders[user];

        // if first time user is staking $howl...
        if (howl.user == address(0)) {
            // add tracker for first time staker
            _allHowlsStakeHoldersIndex[user] = _allHowlsStakeHolders.length;
            _allHowlsStakeHolders.push(user);
        }
        // since its an upsert, we took out old howl and add new amount
        uint256 previousHowls = howl.amount;
        // update stake
        howl.user = user;
        howl.amount = amount;
        howl.since = uint32(block.timestamp);

        howlStakeHolders[user] = howl;
        totalHowlStaked = totalHowlStaked - previousHowls + amount;
        emit HowlStaked(user, amount);
    }

    function staking(uint256 amount) external {
        require(amount > 0, "NEED HOWL");
        HowlV1 howlContract = HowlV1(HOWL_CONTRACT);
        uint256 available = howlContract.balanceOf(msg.sender);
        require(available >= amount, "NOT ENOUGH HOWL");
        HowlStake memory existingHowl = howlStakeHolders[msg.sender];
        if (existingHowl.amount > 0) {
            // already have previous howl staked
            // need to calculate claimable
            uint256 projection = claimableView(msg.sender);
            // mint meet to wallet
            _mint(msg.sender, projection);
            emit Minted(msg.sender, amount);
            _upsertHowlStaking(msg.sender, existingHowl.amount + amount);
        } else {
            // no howl staked just update staking
            _upsertHowlStaking(msg.sender, amount);
        }
        howlContract.burnHowls(msg.sender, amount);
        emit StakedHowl(msg.sender, amount);
    }

    /**
     * Calculates how much meet is available to claim.
     */
    function claimableView(address user) public view returns (uint256) {
        HowlStake memory howl = howlStakeHolders[user];
        require(howl.user != address(0), "NOT STAKED");
        // need to add 10000000000 to factor for decimal
        return
            ((howl.amount * MEET_FARMING_FACTOR) *
                (((block.timestamp - howl.since) * 10000000000) / 86400) *
                BOOSTER_MULTIPLIER) /
            10000000000;
    }

    // NOTE withdrawing howl without claiming meet
    function withdrawHowl(uint256 amount) external {
        require(amount > 0, "MUST BE MORE THAN 0");
        HowlStake memory howl = howlStakeHolders[msg.sender];
        require(howl.user != address(0), "NOT STAKED");
        require(amount <= howl.amount, "OVERDRAWN");
        HowlV1 howlContract = HowlV1(HOWL_CONTRACT);
        // uint256 projection = claimableView(msg.sender);
        _upsertHowlStaking(msg.sender, howl.amount - amount);
        // Need to burn 1/12 when withdrawing (breakage fee)
        uint256 afterBurned = (amount * 11) / 12;
        // mint howl to return to user
        howlContract.mintHowl(msg.sender, afterBurned);
        emit UnstakedHowl(msg.sender, afterBurned);
    }

    /**
     * Claims meet from staked Howl
     */
    function claimMeet() external {
        uint256 projection = claimableView(msg.sender);
        require(projection > 0, "NO MEET TO CLAIM");

        HowlStake memory howl = howlStakeHolders[msg.sender];

        // Updates user's amount of staked howls to the given value. Resets the "since" timestamp.
        _upsertHowlStaking(msg.sender, howl.amount);

        // check: that the total Meet supply hasn't been exceeded.
        _mintMeet(msg.sender, projection);
    }

    /**
     */
    function _removeUserFromHowlEnumeration(address user) private {
        uint256 lastUserIndex = _allHowlsStakeHolders.length - 1;
        uint256 currentUserIndex = _allHowlsStakeHoldersIndex[user];

        address lastUser = _allHowlsStakeHolders[lastUserIndex];

        _allHowlsStakeHolders[currentUserIndex] = lastUser; // Move the last token to the slot of the to-delete token
        _allHowlsStakeHoldersIndex[lastUser] = currentUserIndex; // Update the moved token's index

        // This also deletes the contents at the last position of the array
        delete _allHowlsStakeHoldersIndex[user];
        _allHowlsStakeHolders.pop();
    }

    /**
     * Unstakes the howls, returns the Howls (mints) to the user.
     */
    function withdrawAllHowlAndClaimMeet() external {
        HowlStake memory howl = howlStakeHolders[msg.sender];

        // NOTE does this ever happen?
        require(howl.user != address(0), "NOT STAKED");

        // if there's meet to claim, supply it to the owner...
        uint256 projection = claimableView(msg.sender);
        if (projection > 0) {
            // supply meet to the sender...
            _mintMeet(msg.sender, projection);
        }
        // if there's howl to withdraw, supply it to the owner...
        if (howl.amount > 0) {
            // mint howl to return to user
            // Need to burn 1/12 when withdrawing (breakage fee)
            uint256 afterBurned = (howl.amount * 11) / 12;
            HowlV1 howlContract = HowlV1(HOWL_CONTRACT);
            howlContract.mintHowl(msg.sender, afterBurned);
            emit UnstakedHowl(msg.sender, afterBurned);
        }
        // Internal: removes howl from storage.
        _unstakingHowl(msg.sender);
    }

    /**
     * Internal: removes howl from storage.
     */
    function _unstakingHowl(address user) internal {
        HowlStake memory howl = howlStakeHolders[user];
        // NOTE when whould address be zero?
        require(howl.user != address(0), "EMPTY ADDRESS");
        totalHowlStaked = totalHowlStaked - howl.amount;
        _removeUserFromHowlEnumeration(user);
        delete howlStakeHolders[user];
        emit HowlUnStaked(user, howl.amount);
    }

    /**
     * Meets the wolf the amount of Meet.
     */
    function meetWolf(uint256 wolfId, uint256 amount) external {
        // check: amount is gt zero...
        require(amount > 0, "MUST BE MORE THAN 0 MEET");

        IERC721 instance = IERC721(WOLF_CONTRACT);

        // check: msg.sender is wolf owner...
        require(instance.ownerOf(wolfId) == msg.sender, "NOT OWNER");
        
        // check: user has enough meet in wallet...
        require(balanceOf(msg.sender) >= amount, "NOT ENOUGH MEET");
        
        // TODO should this be moved to howl contract? or does the order here, matter?
        HowlV1 howlContract = HowlV1(HOWL_CONTRACT);
        (uint24 kg, , , , ) = howlContract.stakedWolf(wolfId);
        require(kg > 0, "NOT STAKED");

        // burn meet...
        _burn(msg.sender, amount);
        emit Burned(msg.sender, amount);

        // update eatenAmount in HowlV1 contract...
        howlContract.meetWolf(wolfId, amount);
    }

    // Moved "levelup" to the HowlV1 contract - it doesn't need anything from Meet contract.

    // Moved "skipCoolingOff" to the HowlV1 contract - it doesn't need anything from Meet contract.

    function swapHowlForMeet(uint256 howlAmt) external {
        require(howlAmt > 0, "MUST BE MORE THAN 0 HOWL");

        // burn howls...
        HowlV1 howlContract = HowlV1(HOWL_CONTRACT);
        howlContract.burnHowls(msg.sender, howlAmt);

        // supply meet...
        _mint(msg.sender, howlAmt * MEET_SWAP_FACTOR);
        emit HowlSwap(msg.sender, howlAmt * MEET_SWAP_FACTOR);
    }

    /**
     * Internal: mints the meet to the given wallet.
     */
    function _mintMeet(address sender, uint256 meetAmount) internal {
        // check: that the total Meet supply hasn't been exceeded.
        require(totalSupply() + meetAmount < MAX_MEET_SUPPLY, "OVER MAX SUPPLY");
        _mint(sender, meetAmount);
        emit Minted(sender, meetAmount);
    }

    // ADMIN FUNCTIONS

    /**
     * Admin : mints the meet to the given wallet.
     */
    function mintMeet(address sender, uint256 amount) external onlyOwner {
        _mintMeet(sender, amount);
    }

    /**
     * Admin : used for temporarily multipling how much meet is distributed per staked howl.
     */
    function updateBoosterMultiplier(uint256 _value) external onlyOwner {
        BOOSTER_MULTIPLIER = _value;
    }

    /**
     * Admin : updates how much meet you get per staked howl (e.g. 3x).
     */
    function updateFarmingFactor(uint256 _value) external onlyOwner {
        MEET_FARMING_FACTOR = _value;
    }

    /**
     * Admin : updates the multiplier for swapping (burning) howl for meet (e.g. 12x).
     */
    function updateMeetSwapFactor(uint256 _value) external onlyOwner {
        MEET_SWAP_FACTOR = _value;
    }

    /**
     * Admin : updates the maximum available meet supply.
     */
    function updateMaxMeetSupply(uint256 _value) external onlyOwner {
        MAX_MEET_SUPPLY = _value;
    }

    /**
     * Admin : util for working out how many people are staked.
     */
    function totalHowlHolder() public view returns (uint256) {
        return _allHowlsStakeHolders.length;
    }

    /**
     * Admin : gets the wallet for the the given index. Used for rebalancing.
     */
    function getHowlHolderByIndex(uint256 index) internal view returns (address){
        return _allHowlsStakeHolders[index];
    }

    /**
     * Admin : Rebalances the pool. Mint to the user's wallet. Only called if changing multiplier.
     */
    function rebalanceStakingPool(uint256 from, uint256 to) external onlyOwner {
        // for each holder of staked Howl...
        for (uint256 i = from; i <= to; i++) {
            address holderAddress = getHowlHolderByIndex(i);

            // check how much meet is claimable...
            uint256 pendingClaim = claimableView(holderAddress);
            HowlStake memory howl = howlStakeHolders[holderAddress];

            // supply Meet to the owner's wallet...
            _mint(holderAddress, pendingClaim);
            emit Minted(holderAddress, pendingClaim);

            // pdates user's amount of staked howls to the given value. Resets the "since" timestamp.
            _upsertHowlStaking(holderAddress, howl.amount);
        }
    }
}
