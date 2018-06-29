pragma solidity ^0.4.23;

import '../common/SafeMath.sol';

library ProductLib {
    using SafeMath for uint;

    struct Product {
        string name;
        uint price;
        uint quantity;
    }

    function updateProduct(Product storage _self, uint _quantity) internal {
        uint bigger;
        uint smaller;

        (bigger, smaller) = getBiggerAndSmaller(_self.quantity, _quantity);

        decreasePrice(_self, bigger.sub(smaller));
        _self.quantity = _quantity;
    }

    function getProductPrice(Product storage _self, uint _quantity) internal view returns (uint) {
        return _self.price.mul(_quantity);
    }

    function exists(Product storage _self) internal view returns (bool) {
        return bytes(_self.name).length > 0;
    }

    function purchaseProduct(Product storage _self, uint _quantity) internal {
        increasePrice(_self, _quantity);
        _self.quantity = _self.quantity.sub(_quantity);
    }

    function increasePrice(Product storage _self, uint _quantity) internal {
        _self.price = _self.price.add(_self.price.divmul(_self.quantity, _quantity));
    }

    function decreasePrice(Product storage _self, uint _quantity) internal {
        uint bigger;
        uint smaller;

        (bigger, smaller) = getBiggerAndSmaller(_self.quantity, _quantity);

        _self.price = _self.price.sub(_self.price.divmul(bigger, smaller));
    }

    function getBiggerAndSmaller(uint a, uint b) internal pure returns (uint, uint) {
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