// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title GLNTToken Contract
 * @dev This contract is used for the GLNT NFT token.
 */
contract GLNTToken is ERC721, ERC721URIStorage, AccessControl {
    /// Role for minting tokens.
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /// Flag for enabling public minting.
    bool public isPublicMintingEnabled;

    /// Next token id.
    uint256 private _nextTokenId;

    constructor() ERC721("GLNTToken", "GLNT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    /**
     * @dev Activates/deactivates public minting.
     * @param enabled Flag for enabling public minting.
     */
    function switchPublicMinting(bool enabled) external onlyRole(DEFAULT_ADMIN_ROLE) {
        isPublicMintingEnabled = enabled;
    }

    /**
     * @dev Mints a token.
     * @param to Address of the token owner.
     * @param uri URI of the token.
     */
    function safeMint(address to, string memory uri) external {
        if (!isPublicMintingEnabled) _checkRole(MINTER_ROLE);

        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721URIStorage, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
