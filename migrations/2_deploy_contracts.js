const Marketplace = artifacts.require("../contracts/Marketplace.sol");
const SafeMath = artifacts.require("../contracts/common/SafeMath.sol");
const ProductLib = artifacts.require("../contracts/libs/ProductLib.sol");

module.exports = (deployer) => {
	deployer.deploy(SafeMath);
	deployer.link(SafeMath, ProductLib);
	deployer.deploy(ProductLib);
	deployer.link(ProductLib, Marketplace);
	deployer.deploy(Marketplace);
};