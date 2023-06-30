const hre = require("hardhat");

async function sleep(ms) {
  await new Promise((resolve) => setTimeout(resolve, ms));
}

async function main() {
  const nftContract = await hre.ethers.deployContract("Friends", [
    "0xE730A3858627934e43E33C6A8EF1A52606c35bc4",
  ]); //contract name + whitelistContract address

  await nftContract.waitForDeployment();

  console.log("Nft Contract is at", nftContract.target);

  await sleep(30 * 1000);

  await hre.run("verify:verify", {
    address: nftContract.target,
    constructorArguments: ["0xE730A3858627934e43E33C6A8EF1A52606c35bc4"], //Whitelist contract is the argument of the constructor again
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
