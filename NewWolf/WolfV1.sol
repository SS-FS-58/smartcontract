//SPDX-License-Identifier: MIT
// contracts/ERC721.sol
// upgradeable contract

pragma solidity >=0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WolfV1 is ERC721Upgradeable {
    // Royalty
    address private _owner;
    address private _royaltiesAddr; // royality receiver
    uint256 public royaltyPercentage; // royalty based on sales price
    mapping(address => bool) public excludedList; // list of people who dont have to pay fee

    //GB HOLDERS EARLY ACCESS TOKENS
    uint256 public constant gbHoldersMaxMint = 900;
    mapping(address => bool) public gbholders;

    address public GB_erc20_contract;

    uint256[] private _gbTokenSupply;

    // cost to mint
    uint256 public mintFeeAmount;

    // // NFT Meta data
    string public baseURL;

    uint256 public constant maxSupply = 10000;

    // enable flag for public and GB
    bool public openForGB;
    bool public openForPublic;

    // define WolfRun struct
    struct WolfRun {
        uint256 tokenId;
        // string tokenURI;
        address mintedBy;
        address currentOwner;
        uint256 previousPrice;
        uint256 price;
        uint256 numberOfTransfers;
        bool forSale;
        uint256 kg;
    }

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // map id to WolfRun obj
    mapping(uint256 => WolfRun) public allWolfRun;

    //  implement the IERC721Enumerable which no longer come by default in openzeppelin 4.x
    // Mapping from owner to list of owned token IDs
    mapping(address => mapping(uint256 => uint256)) private _ownedTokens;

    // Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    // Array with all token ids, used for enumeration
    uint256[] private _allTokens;

    // Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    //================================= Events ================================= //
    event GBERC20Checked(address indexed _holder, uint256 _bal, bool _result);

    event SaleToggle(uint256 wolfNumber, bool isForSale, uint256 price);
    event PurchaseEvent(uint256 wolfNumber, address from, address to, uint256 price);

    function initialize(
        address _contractOwner,
        address _royaltyReceiver,
        uint256 _royaltyPercentage,
        uint256 _mintFeeAmount,
        string memory _baseURL,
        address _gbContractAddress,
        bool _openForGB,
        bool _openForPublic
    ) public initializer {
        // __ERC721_init("swng", "swng");
        __ERC721_init("wolf", "wolf");
        royaltyPercentage = _royaltyPercentage;
        _owner = _contractOwner;
        _royaltiesAddr = _royaltyReceiver;
        mintFeeAmount = _mintFeeAmount;
        excludedList[_contractOwner] = true; // add owner to exclude list
        excludedList[_royaltyReceiver] = true; // add artist to exclude list
        baseURL = _baseURL;
        GB_erc20_contract = _gbContractAddress;
        openForGB = _openForGB;
        openForPublic = _openForPublic;
    }

    function mint(uint256 numberOfToken) public payable {
        // check if thic fucntion caller is not an zero address account
        require(openForPublic == true, "not open");
        require(msg.sender != address(0));
        require(
            _allTokens.length + numberOfToken <= maxSupply,
            "max supply"
        );
        require(numberOfToken > 0, "Min 1");
        require(numberOfToken <= 12, "Max 12");
        uint256 price = 0;
        // pay for minting cost
        if (excludedList[msg.sender] == false) {
            // send token's worth of ethers to the owner
            price = mintFeeAmount * numberOfToken;
            require(msg.value == price, "Not enough fee");
            payable(_royaltiesAddr).transfer(msg.value);
        } else {
            // return money to sender // since its free
            payable(msg.sender).transfer(msg.value);
        }

        for (uint256 i = 1; i <= numberOfToken; i++) {
            _tokenIds.increment();
            uint256 newItemId = _tokenIds.current();
            _safeMint(msg.sender, newItemId);
            WolfRun memory newWolfRun = WolfRun(
                newItemId,
                msg.sender,
                msg.sender,
                0,
                price,
                0,
                false,
                100
            );
            // add the token id to the allWolfRun
            allWolfRun[newItemId] = newWolfRun;
        }
    }


    function changeUrl(string memory url) external {
        require(msg.sender == _owner, "Only owner");
        baseURL = url;
    }

    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

    // GB holder related functions
    function gbTotalSupply() public view returns (uint256) {
        return _gbTokenSupply.length;
    }


    function setPriceForSale(
        uint256 _tokenId,
        uint256 _newPrice,
        bool isForSale
    ) external {
        require(_exists(_tokenId), "token not found");
        address tokenOwner = ownerOf(_tokenId);
        require(tokenOwner == msg.sender, "not owner");
        WolfRun memory chick = allWolfRun[_tokenId];
        chick.price = _newPrice;
        chick.forSale = isForSale;
        allWolfRun[_tokenId] = chick;
        emit SaleToggle(_tokenId, isForSale, _newPrice);
    }

    function getAllSaleTokens() public view returns (uint256[] memory) {
        uint256 _totalSupply = totalSupply();
        uint256[] memory _tokenForSales = new uint256[](_totalSupply);
        uint256 counter = 0;
        for (uint256 i = 1; i <= _totalSupply; i++) {
            if (allWolfRun[i].forSale == true) {
                _tokenForSales[counter] = allWolfRun[i].tokenId;
                counter++;
            }
        }
        return _tokenForSales;
    }

    // by a token by passing in the token's id
    function buyToken(uint256 _tokenId) public payable {
        // check if the token id of the token being bought exists or not
        require(_exists(_tokenId));
        // get the token's owner
        address tokenOwner = ownerOf(_tokenId);
        // token's owner should not be an zero address account
        require(tokenOwner != address(0));
        // the one who wants to buy the token should not be the token's owner
        require(tokenOwner != msg.sender);
        // get that token from all WolfRun mapping and create a memory of it defined as (struct => WolfRun)
        WolfRun memory chick = allWolfRun[_tokenId];
        // price sent in to buy should be equal to or more than the token's price
        require(msg.value >= chick.price);
        // token should be for sale
        require(chick.forSale);
        uint256 amount = msg.value;
        uint256 _royaltiesAmount = (amount * royaltyPercentage) / 100;
        uint256 payOwnerAmount = amount - _royaltiesAmount;
        payable(_royaltiesAddr).transfer(_royaltiesAmount);
        payable(chick.currentOwner).transfer(payOwnerAmount);
        chick.previousPrice = chick.price;
        allWolfRun[_tokenId] = chick;
        _transfer(tokenOwner, msg.sender, _tokenId);
        emit PurchaseEvent(_tokenId, chick.currentOwner, msg.sender, chick.price);
    }

    function tokenOfOwnerByIndex(address owner, uint256 index)
        public
        view
        returns (uint256)
    {
        require(index < balanceOf(owner), "out of bounds");
        return _ownedTokens[owner][index];
    }

    //  URI Storage override functions
    /** Overrides ERC-721's _baseURI function */
    function _baseURI()
        internal
        view
        virtual
        override(ERC721Upgradeable)
        returns (string memory)
    {
        return baseURL;
    }

    function _burn(uint256 tokenId) internal override(ERC721Upgradeable) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721Upgradeable)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    /**
     * @dev Hook that is called before any token transfer. This includes minting
     * and burning.
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721Upgradeable) {
        super._beforeTokenTransfer(from, to, tokenId);
        WolfRun memory chick = allWolfRun[tokenId];
        chick.currentOwner = to;
        chick.numberOfTransfers += 1;
        chick.forSale = false;
        allWolfRun[tokenId] = chick;
        if (from == address(0)) {
            _addTokenToAllTokensEnumeration(tokenId);
        } else if (from != to) {
            _removeTokenFromOwnerEnumeration(from, tokenId);
        }
        if (to == address(0)) {
            _removeTokenFromAllTokensEnumeration(tokenId);
        } else if (to != from) {
            _addTokenToOwnerEnumeration(to, tokenId);
        }
    }

    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {
        uint256 length = balanceOf(to);
        _ownedTokens[to][length] = tokenId;
        _ownedTokensIndex[tokenId] = length;
    }

    function _addTokenToAllTokensEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _removeTokenFromOwnerEnumeration(address from, uint256 tokenId)
        private
    {
        uint256 lastTokenIndex = balanceOf(from) - 1;
        uint256 tokenIndex = _ownedTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary
        if (tokenIndex != lastTokenIndex) {
            uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];

            _ownedTokens[from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
            _ownedTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        }

        // This also deletes the contents at the last position of the array
        delete _ownedTokensIndex[tokenId];
        delete _ownedTokens[from][lastTokenIndex];
    }

    function _removeTokenFromAllTokensEnumeration(uint256 tokenId) private {
        uint256 lastTokenIndex = _allTokens.length - 1;
        uint256 tokenIndex = _allTokensIndex[tokenId];

        uint256 lastTokenId = _allTokens[lastTokenIndex];

        _allTokens[tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
        _allTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index

        // This also deletes the contents at the last position of the array
        delete _allTokensIndex[tokenId];
        _allTokens.pop();
    }

    // upgrade contract to support authorized

    mapping(address => bool) public authorized;

    modifier onlyAuthorized() {
        require(authorized[msg.sender] ||  msg.sender == _owner , "Not authorized");
        _;
    }

    function addAuthorized(address _toAdd) public {
        require(msg.sender == _owner, 'Not owner');
        require(_toAdd != address(0));
        authorized[_toAdd] = true;
    }

    function removeAuthorized(address _toRemove) public {
        require(msg.sender == _owner, 'Not owner');
        require(_toRemove != address(0));
        require(_toRemove != msg.sender);
        authorized[_toRemove] = false;
    }

    // upgrade the contract
    function setKg(uint256 _tokenId, uint256 _newKg) external onlyAuthorized {
        WolfRun memory chick = allWolfRun[_tokenId];
        chick.kg = _newKg;
        // set and update that token in the mapping
        allWolfRun[_tokenId] = chick;
    }
}
