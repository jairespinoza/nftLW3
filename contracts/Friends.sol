//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "./Whitelist.sol";

contract Friends is ERC721Enumerable, Ownable {
  uint256 public constant _price = 0.01 ether;

  uint256 public constant maxTokenId = 20;

  Whitelist whitelist;

  uint256 public reservedTokens;
  uint256 public reservedTokensClaimed = 0;

  constructor(address whitellistContract) ERC721("Friends", "FDS") {
    whitelist = Whitelist(whitellistContract);
    reservedTokens = whitelist.maxWhitelistAddresses();
  }

  function mint() public payable {
    require(
      totalSupply() + reservedTokens - reservedTokensClaimed < maxTokenId,
      "Exceeded_Max_Supply"
    );
    if (whitelist.whitelistAddress(msg.sender) && msg.value < _price) {
      require(balanceOf(msg.sender) == 0, "Already Owned");
      reservedTokens += 1;
    } else {
      require(msg.value >= _price, "NotEnoughETH");
    }
    uint256 tokenId = totalSupply();
    _safeMint(msg.sender, tokenId);
  }

  function withdraw() public onlyOwner {
    address _owner = owner();
    uint256 amount = address(this).balance;
    (bool sent, ) = _owner.call{ value: amount }("");
    require(sent, "Failed To send ETH");
  }
}
