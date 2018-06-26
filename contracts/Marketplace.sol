pragma solidity ^0.4.23;

import './abstractions/MarketplaceTemplate.sol';
import './common/Destructible.sol';
import './libs/ProductLib.sol';

contract Marketplace is MarketplaceTemplate, Destructible {
    using ProductLib for ProductLib.Product;

    bytes32[] public products;    

    event LogNewProduct(bytes32 indexed id, string name, uint price, uint quantity);
    event LogNewPurchase(bytes32 indexed id, uint quantity);
    event LogStockUpdate(bytes32 indexed id, uint quantity);
    event LogWithdrawal();

    mapping (bytes32=>ProductLib.Product) public productById;

    modifier productExists(bytes32 _id) {
        require(productById[_id].exists());
        _;
    }

    function buy(bytes32 _id, uint _quantity) public productExists(_id) payable {
        require(productById[_id].getProductPrice(_quantity) <= msg.value);

        emit LogNewPurchase(_id, _quantity);

        productById[_id].purchaseProduct(_quantity);
    }
    
    function update(bytes32 _id, uint _newQuantity) public productExists(_id) onlyOwner {
        emit LogStockUpdate(_id, _newQuantity);

        productById[_id].updateProduct(_newQuantity);
    }
    
    // creates a new product and returns its ID
    function newProduct(string _name, uint _price, uint _quantity) public onlyOwner returns(bytes32) {
        require(_quantity > 0);
        require(_price > 0);
        require(bytes(_name).length > 0);

        bytes32 id = keccak256(abi.encodePacked(_name, _price, _quantity, now));

        require(!productById[id].exists());

        products.push(id);
        productById[id] = ProductLib.Product({name: _name, price: _price, quantity: _quantity});

        emit LogNewProduct(id, _name, _price, _quantity);

        return id;
    }
    
    function withdraw() public onlyOwner {
        require(address(this).balance > 0);

        emit LogWithdrawal();

        msg.sender.transfer(address(this).balance);
    }
    
    function getProduct(bytes32 _id) public productExists(_id) view returns(string name, uint price, uint quantity) {
        ProductLib.Product memory product = productById[_id];
        return (product.name, product.price, product.quantity);
    }
    
    function getPrice(bytes32 _id, uint _quantity) public productExists(_id) view returns (uint) {
        return productById[_id].getProductPrice(_quantity);
    }

    function getProducts() public view returns(bytes32[]) {
        return products;
    }
}