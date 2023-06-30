//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

contract Whitelist {
  uint8 public maxWhitelistAddresses;

  mapping(address => bool) public whitelistAddress;

  uint8 public numWhitelistAddresses;

  constructor(uint8 _maxWhitelistAddresses) {
    maxWhitelistAddresses = _maxWhitelistAddresses;
  }

  function addressToWL() public {
    require(!whitelistAddress[msg.sender], "Sender Whitelisted already");

    require(
      numWhitelistAddresses < maxWhitelistAddresses,
      "Not enough WL spots"
    );
    whitelistAddress[msg.sender] = true;
    numWhitelistAddresses += 1;
  }
}
