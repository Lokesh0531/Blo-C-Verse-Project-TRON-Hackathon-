// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;
import "./TRC721.sol";
contract BlocVerse is TRC721, TRC721Enumerable, TRC721MetadataMintable{
    //using Strings for uint256;

    string private _baseTokenURI;
    uint256 private _tokenIdCounter;
    address private owner;
    
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor(string memory name, string memory symbol, string memory baseTokenURI) public TRC721Metadata(name, symbol) {
        _baseTokenURI = baseTokenURI;
        _tokenIdCounter = 1;
        owner = msg.sender;
    }

    function setBaseTokenURI(string calldata newBaseTokenURI) external onlyOwner {
        _baseTokenURI = newBaseTokenURI;
    }

    function mintNFT(string calldata name, string calldata description, string calldata photoURI) external onlyOwner {
        uint256 tokenId = _tokenIdCounter;
        _mint(msg.sender, tokenId);
        _tokenIdCounter++;

    
        string memory tokenURI = photoURI;
        _setTokenURI(tokenId, tokenURI);

        
        emit NFTMinted(msg.sender, tokenId, name, description, photoURI);
    }

    function getTokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return tokenURIs[tokenId];
    }

    function _baseURI() internal view returns (string memory) {
        return _baseTokenURI;
    }

    function _setTokenURI(uint256 tokenId, string memory tokenURI) internal {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        tokenURIs[tokenId] = tokenURI;
    }

    mapping(uint256 => string) private tokenURIs;

    
    event NFTMinted(address indexed owner, uint256 tokenId, string name, string description, string photoURI);
}
