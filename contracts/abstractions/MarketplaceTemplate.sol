pragma solidity ^0.4.23;

contract MarketplaceTemplate {
    function buy(bytes32 ID, uint quantity) public payable {}
    
    function update(bytes32 ID, uint newQuantity) public {}
    
    //creates a new product and returns its ID
    function newProduct(string name, uint price, uint quantity) public returns(bytes32) {}
    
    function getProduct(bytes32 ID) public view returns(string name, uint price, uint quantity) {}
    
    function getProducts() public view returns(bytes32[]) {}
    
    function getPrice(bytes32 ID, uint quantity) public view returns (uint) {}

    //function for the optional requirement for a withdraw function. Implement if you want.
    function withdraw() public {}
}