pragma solidity ^0.4.23;

import '../common/SafeMath.sol';

library ProductLib {
    using SafeMath for uint;

    struct Product {
        string name;
        uint price;
        uint quantity;
    }

    function updateProduct(Product storage _self, uint _quantity) public {
        // Method decreasePrice is ready for usage if it is required for the price to correct itself when quantity is increased
        // decreasePrice(_self, _quantity.sub(_self.quantity));
        _self.quantity = _quantity;
    }

    function getProductPrice(Product storage _self, uint _quantity) public view returns (uint) {
        return _self.price.mul(_quantity);
    }

    function exists(Product storage _self) public view returns (bool) {
        return _self.price > 0;
    }

    function purchaseProduct(Product storage _self, uint _quantity) public {
        increasePrice(_self, _quantity);
        _self.quantity = _self.quantity.sub(_quantity);
    }

    function increasePrice(Product storage _self, uint _quantity) public {
        _self.price = _self.price.add(_self.price.divmul(_self.quantity, _quantity));
    }

    // unused function for pottentially upgrading logic to decrease price when stock of product is increased
    function decreasePrice(Product storage _self, uint _quantity) public {
        uint bigger;
        uint smaller;

        (bigger, smaller) = getBiggerAndSmaller(_self.quantity, _quantity);

        _self.price = _self.price.sub(_self.price.divmul(bigger, smaller));
    }

    function getBiggerAndSmaller(uint a, uint b) public pure returns (uint, uint) {
        uint bigger;
        uint smaller;

        if (a > b) {
            bigger = a;
            smaller = b;
        } else {
            bigger = b;
            smaller = a;
        }

        return (bigger, smaller);
    }
}