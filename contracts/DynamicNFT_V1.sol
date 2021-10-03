// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract DynamicNFT is ERC1155{
    
    uint public currentTokenId;
    uint public erc20TokenId;
    uint public erc20Count;
    bool public artistTokenMinted;
    
    constructor() ERC1155("URI"){
        currentTokenId = 3;
        erc20TokenId = 2;
    }
    
    function mintArtistToken() public {
        require(!artistTokenMinted, "Dynamic NFT : Artist Token has already been minted.");
        _mint(msg.sender, 1, 1, "");
        artistTokenMinted = true;
    }
    
    function mint_tokens(uint count) public {
        require(artistTokenMinted, "Dynamic NFT : Artist Token needs to be minted first.");
        require(count <= 50, "Dynamic NFT : You can mint only upto 50m tokens");
        erc20Count += count;
        require(erc20Count <= 10000, "Dynamic NFT : You can only mint a maximum of 10000 tokens.");
        _mint(msg.sender, erc20TokenId, count, "");
        uint[] memory nftIds;
        uint[] memory nftCountsPerId;
        (nftIds, nftCountsPerId) = generateIds(count);
        _mintBatch(msg.sender, nftIds, nftCountsPerId, "");
        erc20Count += count;
    }
    
    function generateIds(uint count) private returns (uint[] memory, uint[] memory){
        uint[] memory nftIds = new uint[](count);
        uint[] memory nftIdValues = new uint[](count);
        uint j=currentTokenId;
        for (uint i=0; i < count; i++){
            nftIds[i] = j;
            nftIdValues[i] = 1;
            j+=1;
        }
        currentTokenId = j;
        return(nftIds, nftIdValues);
    }
    
}