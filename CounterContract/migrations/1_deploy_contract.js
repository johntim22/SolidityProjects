const Counter = artifacts.require("Counter");

module.exports = function(deployer) {
  // Deploy the Counter contract
  deployer.deploy(Counter);
};
