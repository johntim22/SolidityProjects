module.exports = {
  // Network configuration
  networks: {
    development: {
      host: "127.0.0.1",   // Localhost (default: none)
      port: 7545,          // Standard Ethereum port (default: none)
      network_id: "*",     // Any network (default: none)
    },
  },

  // Compiler configuration
  compilers: {
    solc: {
      version: "^0.5.0",    // Specify the Solidity compiler version
    },
  },
};
