const Marketplace = artifacts.require("../contracts/Marketplace.sol");

module.exports = (deployer) => {
	deployer.deploy(Marketplace);
};