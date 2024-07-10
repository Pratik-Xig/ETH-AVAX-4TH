// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    struct Item {
        string name;
        uint256 quantity;
    }

    struct itemsAvail {
        string name;
        uint256 cost;
    }

    itemsAvail[] private redeemableItems;

    mapping(address => Item[]) private _inventory;
    mapping(address => mapping(string => uint256)) private _itemIndex;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
       redeemableItems.push(itemsAvail("1. DGNavatar", 100));
        redeemableItems.push(itemsAvail("2. DGNtheme", 100));
        redeemableItems.push(itemsAvail("3. DGN-Tshirt", 600));
        redeemableItems.push(itemsAvail("4. mystery-box", 1200));
    }

    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

function getRedeemableItems() external view returns (itemsAvail[] memory) {
    return redeemableItems;
    }

    
    function redeem(string memory item) external {
        uint256 cost;

        if (keccak256(bytes(item)) == keccak256(bytes("DGNavatar"))) 
            cost = 100;
         else if (keccak256(bytes(item)) == keccak256(bytes("DGNtheme"))) 
            cost = 200;
        else if (keccak256(bytes(item)) == keccak256(bytes("DGN-Tshirt"))) 
            cost = 600;
        else if (keccak256(bytes(item)) == keccak256(bytes("mystery-box"))) 
            cost = 1200;

            else
            revert("Invalid item");

        require(balanceOf(msg.sender) >= cost, "Insufficient balance");
        _burn(msg.sender, cost);
        _addItem(msg.sender, item);
    }

    function _addItem(address user, string memory item) internal {
        uint256 index = _itemIndex[user][item];
         if (index == 0) {
            _inventory[user].push(Item({name: item, quantity: 1}));
            _itemIndex[user][item] = _inventory[user].length - 1; 
        } else {
            _inventory[user][index].quantity += 1;
    }
    }

    function getInventory() external view returns (Item[] memory) {
        return _inventory[msg.sender];
    }

    function transferTokens(address to, uint256 amount) external {
    require(balanceOf(msg.sender) >= amount, "Transfer amount exceeds balance");
    _transfer(msg.sender, to, amount);
}
}
