// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function main() {
  const whitelistContract = await hre.ethers.deployContract("Whitelist", [10]);

  await whitelistContract.waitForDeployment();

  console.log("Whitelist contract is at address:", whitelistContract.target);

  await sleep(30 * 1000);

  await hre.run("verify:verify", {
    address: whitelistContract.target,
    constructorArguments: [10],
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
