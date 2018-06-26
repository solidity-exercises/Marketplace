const Marketplace = artifacts.require("../contracts/Marketplace.sol");
const Ownable = artifacts.require("../contracts/Ownable.sol");
const SafeMath = artifacts.require("../contracts/SafeMath.sol");
const ProductLib = artifacts.require("../contracts/ProductLib.sol");

module.exports = (deployer) => {
	deployer.deploy(SafeMath);
	deployer.link(SafeMath, ProductLib);
	deployer.deploy(ProductLib);
	deployer.link(ProductLib, Marketplace);
	deployer.deploy(Marketplace);
};