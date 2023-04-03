require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  etherscan: {
    apiKey: {
      arbitrumOne: "JNFIJ9TYHWT198PF5GRBIHTX44KDCY33B7",
    },
  },
  networks: {
    arbitrum: {
      url: `https://1rpc.io/arb`,
    },
  },
};
