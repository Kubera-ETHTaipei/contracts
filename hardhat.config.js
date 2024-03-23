require("@nomicfoundation/hardhat-toolbox");
const { PRIVATE_KEY, USER_KEY } = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "^0.8.0",
  networks: {
    ten: {
      chainId: 443,
      url: `https://testnet.obscu.ro/v1/${USER_KEY}`,
      gasPrice: 2000000000,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
};
