// SPDX-License-Identifier: MIT
// tuta @thecryptogus

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CryptoPratiqueTokens is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(address => bool) private _whitelist;
    mapping(uint256 => string) private _tokenNames;
    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC721("CryptoPratiqueTokens", "CPT") {}

    function addToWhitelist(address[] memory addresses) public onlyOwner {
        for (uint i = 0; i < addresses.length; i++) {
            _whitelist[addresses[i]] = true;
        }
    }

    function removeFromWhitelist(address[] memory addresses) public onlyOwner {
        for (uint i = 0; i < addresses.length; i++) {
            _whitelist[addresses[i]] = false;
        }
    }

    function mint(string memory tokenName, string memory tokenURI) public returns (uint256) {
        require(_whitelist[msg.sender], "You are not whitelisted to mint");

        _tokenIds.increment();

        uint256 newTokenId = _tokenIds.current();
        _mint(msg.sender, newTokenId);

        _tokenNames[newTokenId] = tokenName;
        _tokenURIs[newTokenId] = tokenURI;

        _whitelist[msg.sender] = false; // only one token per address

        return newTokenId;
    }

    function getTokenName(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "Token does not exist");

        return _tokenNames[tokenId];
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        return _tokenURIs[tokenId];
    }
}
