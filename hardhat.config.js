require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.8",
  networks: {
    localganache: {
      url: "http://127.0.0.1:7545", // ← replace with your Ganache RPC URL if different
      accounts: [
        "0x5ba4667eb5e3d7447ebf78027c578e008a83f302d36b29e58af078d738465d15"
      ],
    },
  },
};
//0xDD69c0964d081e7f580Fbe08a365F22e772f448b
