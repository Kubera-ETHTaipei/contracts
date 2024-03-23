require("@nomicfoundation/hardhat-toolbox");
// const { PRIVATE_KEY, USER_KEY } = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  networks: {
    // scrollTestnet: {
    //   chainId: 534351,
    //   url: "https://sepolia-rpc.scroll.io/",
    //   accounts: process.env.PRIVATE_KEY,
    // },
    scrollSepolia: {
      url: "https://sepolia-rpc.scroll.io",
      accounts: process.env.PRIVATE_KEY,
    },
    // ten: {
    //   chainId: 443,
    //   url: `https://testnet.obscu.ro/v1/${USER_KEY}`,
    //   gasPrice: 2000000000,
    //   accounts: [`0x${PRIVATE_KEY}`],
    // },
  },
  etherscan: {
    apiKey: {
      scrollSepolia: "K793M3EGCJDDHCR6Y7TVVQJSIR5GUC57KD",
    },
    customChains: [
      {
        network: "scrollSepolia",
        chainId: 534351,
        urls: {
          apiURL: "https://api-sepolia.scrollscan.com/api",
          browserURL: "https://sepolia.scrollscan.com/",
        },
      },
    ],
  },
  sourcify: {
    enabled: true,
  },
};
