const TransferETHInInstallments = artifacts.require("TransferETHInInstallments");

module.exports = function (deployer) {
  const recipient = "0x04c5b6cab6009a40530E52f06FbFd8D4e82e4Aa6";  // Replace with the actual recipient address
  deployer.deploy(TransferETHInInstallments, recipient);
};
