const hre = require("hardhat");

async function main() {
  const credit = await hre.ethers.deployContract("Kubera");

  await credit.waitForDeployment();

  console.log(`Credit with  deployed to ${credit.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
