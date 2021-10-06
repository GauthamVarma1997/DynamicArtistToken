const dnft = artifacts.require("DynamicNFT");

module.exports = function (deployer) {
  deployer.deploy(dnft);
};