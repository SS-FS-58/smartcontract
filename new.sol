pragma solidity ^0.8.0;

import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/introspection/ERC165Checker.sol";

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/introspection/ERC165Checker.sol
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/utils/ERC1155Receiver.sol";
// import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/AccessControl.sol";

// import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

library SafeMath {
  /**
   * @dev Returns the addition of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `+` operator.
   *
   * Requirements:
   * - Addition cannot overflow.
   */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMath: addition overflow");

    return c;
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting on
   * overflow (when the result is negative).
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   * - Subtraction cannot overflow.
   */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    return sub(a, b, "SafeMath: subtraction overflow");
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
   * overflow (when the result is negative).
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   * - Subtraction cannot overflow.
   */
  function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    require(b <= a, errorMessage);
    uint256 c = a - b;

    return c;
  }

  /**
   * @dev Returns the multiplication of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `*` operator.
   *
   * Requirements:
   * - Multiplication cannot overflow.
   */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    require(c / a == b, "SafeMath: multiplication overflow");

    return c;
  }

  /**
   * @dev Returns the integer division of two unsigned integers. Reverts on
   * division by zero. The result is rounded towards zero.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    return div(a, b, "SafeMath: division by zero");
  }

  /**
   * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
   * division by zero. The result is rounded towards zero.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    // Solidity only automatically asserts when dividing by 0
    require(b > 0, errorMessage);
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * Reverts when dividing by zero.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    return mod(a, b, "SafeMath: modulo by zero");
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * Reverts with custom message when dividing by zero.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    require(b != 0, errorMessage);
    return a % b;
  }
}



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
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
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

contract AngryApesUnited is ERC1155, ERC1155Receiver, Ownable {
    
  using SafeMath for uint256;
    
  uint256 public mintPrice = 0.065 ether;

  uint256 private reserveForDev = 200;
  uint256 private reserveForPreSale = 800;
  
  uint256 private reservedCountForDev = 0;
  uint256 private eeserveCountForPreSale = 0;
  
  uint256 public currentSupply=0;

  string _baseTokenURI;

  bool public isActive = false;
  bool public isAllowListActive = false;

  uint256 public maximumMintSupply = 8888;
  uint256 public maximumAllowedTokensPerPurchase = 20;
  uint256 public allowListMaxMint = 5;
  
  mapping(address => bool) private _allowList;
  mapping(address => uint256) private _allowListClaimed;
  
  bytes private constant VALIDATOR = bytes('AC');

  event AssetMinted(uint256 tokenAmount, address sender);
  event SaleActivation(bool isActive);
  
    modifier saleIsOpen {
    require(currentSupply <= maximumMintSupply, "Sale has ended.");
    _;
  }

  modifier onlyAuthorized() {
    require(owner() == msg.sender,"Authorization failed");
    _;
  }



  constructor (string memory _uri) 
        public 
        ERC1155(_uri)
    {
        
    }


  function setMaximumAllowedTokens(uint256 _count) public onlyAuthorized {
    maximumAllowedTokensPerPurchase = _count;
  }

  function setActive(bool val) public onlyAuthorized {
    isActive = val;
    emit SaleActivation(val);
  }

  function setMaxMintSupply(uint256 maxMintSupply) external  onlyAuthorized {
    maximumMintSupply = maxMintSupply;
  }

  function setIsAllowListActive(bool _isAllowListActive) external onlyAuthorized {
    isAllowListActive = _isAllowListActive;
  }

  function setAllowListMaxMint(uint256 maxMint) external  onlyAuthorized {
    allowListMaxMint = maxMint;
  }

  function addToAllowList(address[] calldata addresses) external onlyAuthorized {
    for (uint256 i = 0; i < addresses.length; i++) {
      require(addresses[i] != address(0), "Can't add a null address");
      _allowList[addresses[i]] = true;
      _allowListClaimed[addresses[i]] > 0 ? _allowListClaimed[addresses[i]] : 0;
    }
  }

  function checkIfOnAllowList(address addr) external view returns (bool) {
    return _allowList[addr];
  }

  function removeFromAllowList(address[] calldata addresses) external onlyAuthorized {
    for (uint256 i = 0; i < addresses.length; i++) {
      require(addresses[i] != address(0), "Can't add a null address");
      _allowList[addresses[i]] = false;
    }
  }

  function allowListClaimedBy(address owner) external view returns (uint256){
    require(owner != address(0), 'Zero address not on Allow List');
    return _allowListClaimed[owner];
  }

  function setReserveForDev(uint256 val) public onlyAuthorized {
    reserveForDev = val;
  }

  function setReserveForPreSale(uint256 val) public onlyAuthorized {
    reserveForPreSale = val;
  }

  function setPrice(uint256 _price) public onlyAuthorized {
    mintPrice = _price;
  }

  function setBaseURI(string memory baseURI) public onlyAuthorized {
    _baseTokenURI = baseURI;
  }

  function getMaximumAllowedTokens() public view onlyAuthorized returns (uint256) {
    return maximumAllowedTokensPerPurchase;
  }

  function getPrice() external view returns (uint256) {
    return mintPrice;
  }

  function getReserveAtATime() external view returns (uint256) {
    return reserveForDev;
  }
  
  function getTotalSupply() external view returns (uint256) {
    return totalSupply();
  }


  function getContractOwner() public view returns (address) {
    return owner();
  }

//   function uri() view virtual override returns (string memory) {
//     return _uri(0);
//   }

// AT LAST
//   function reserveNft() public onlyAuthorized {
//     require(reservedCount <= maxReserveCount, "Max Reserves taken already!");

//     reservedCount=reservedCount+reserveForDev;
//     currentSupply=currentSupply+reserveForDev;
//     _mint(msg.sender, 1, reserveForDev, "");
//     emit AssetMinted(reserveForDev, msg.sender);
//     }
//   }

  function reserveDevNft(address _ToGSDWalletAddress, uint256 _count) public onlyAuthorized {
    require(reservedCountForDev.add(_count) <= reserveForDev, "Dev Reserves amount must be less");
    reservedCountForDev=reservedCountForDev.add(_count);
    currentSupply=currentSupply.add(_count);
    _mint(_ToGSDWalletAddress, 0, _count, "");
    emit AssetMinted(reserveForDev, _ToGSDWalletAddress);
    
  }

    function transferRandomTokens(uint256 _count, address[] calldata addresses) external onlyAuthorized {
      
      uint256 totalCount=_count.mul(addresses.length);

      require(currentSupply.add(totalCount) <= maximumMintSupply, "Total supply exceeded.");
      require(totalCount <= maximumMintSupply, "Total supply exceeds max mint supply.");
    
      currentSupply=currentSupply.add(totalCount);
      for (uint256 i = 0; i < addresses.length; i++) {
        require(addresses[i] != address(0), "Can't add a null address");
          _mint(addresses[i], 0, _count, "");
          emit AssetMinted(_count, addresses[i]);
        }
      }
  

  function mint(address _to, uint256 _count) public payable saleIsOpen {
    if (msg.sender != owner()) {
      require(isActive, "Sale is not active currently.");
    }

    require(currentSupply.add(_count) <= maximumMintSupply, "Total supply exceeded.");
    require(currentSupply <= maximumMintSupply, "Total supply spent.");
    require(
      _count <= maximumAllowedTokensPerPurchase,
      "Exceeds maximum allowed tokens"
    );
    require(msg.value >= mintPrice * _count, "Insuffient ETH amount sent.");
        currentSupply=currentSupply.add(_count);
      _mint(_to, 0, _count, "");
      emit AssetMinted(_count, _to);
  }

  function preSaleMint(uint256 _count) public payable saleIsOpen {
    require(isAllowListActive, 'Allow List is not active');
    require(_allowList[msg.sender], 'You are not on the Allow List');
    require(currentSupply < maximumMintSupply, 'All tokens have been minted');
    require(_count <= allowListMaxMint, 'Cannot purchase this many tokens');
    require(_allowListClaimed[msg.sender] + _count <= allowListMaxMint, 'Purchase exceeds max allowed');
    require(msg.value >= mintPrice * _count, 'Insuffient ETH amount sent.');
          currentSupply=currentSupply.add(_count);
      _allowListClaimed[msg.sender] = _allowListClaimed[msg.sender].add(_count) ;
      _mint(msg.sender, 0, _count, "");
      emit AssetMinted(_count, msg.sender);
    }
  

//   function walletOfOwner(address _owner) external view returns(uint256[] memory) {
//     uint tokenCount = balanceOf(_owner);
//     uint256[] memory tokensId = new uint256[](tokenCount);

//     for(uint i = 0; i < tokenCount; i++){
//       tokensId[i] = tokenOfOwnerByIndex(_owner, i);
//     }
//     return tokensId;
//   }

  function withdraw() external onlyAuthorized {
    uint balance = address(this).balance;
    payable(owner()).transfer(balance);
  }


/**
     * ERC1155 Token ERC1155Receiver
     */
    
function onERC1155Received(address _operator, address _from, uint256 _id, uint256 _value, bytes calldata _data) override external returns(bytes4) {

            return 0xf23a6e61;
        
    }

    function onERC1155BatchReceived(address _operator, address _from, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) override external returns(bytes4) {

            return 0xbc197c81;
        
    }
    
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155,ERC1155Receiver) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}

