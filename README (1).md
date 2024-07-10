## Degen Token (Avalanche)

The Degen Token is an ERC20 token deployed on the Avalanche blockchain, designed for use within the Degen Gaming ecosystem. Players can earn tokens as rewards in games and redeem them for in-game items or trade them with other players.

### Contract Details

The `DegenToken` smart contract is based on the ERC20 standard and includes additional functionalities to support the Degen Gaming platform:

#### State Variables

- `itemsAvail[] private redeemableItems` : Stores redeemable items with their names and costs.
- `mapping(address => Item[]) private _inventory`: Maps addresses to their inventory of items.
- `mapping(address => mapping(string => uint256)) private _itemIndex` : Maps addresses to their items with indices


#### Constructor

```solidity
constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
    redeemableItems.push(itemsAvail("1. DGNavatar", 100));
    redeemableItems.push(itemsAvail("2. DGNtheme", 200));
    redeemableItems.push(itemsAvail("3. DGN-Tshirt", 600));
    redeemableItems.push(itemsAvail("4. mystery-box", 1200));
}
```

The constructor sets the contract deployer as the owner and initializes the token with a name ("DegenToken") and symbol ("DGN"), and sets up the redeemable items list.

#### Functions

##### mint

```solidity
function mint(address to, uint256 amount) external onlyOwner {
    _mint(to, amount);
}
```

Allows the contract owner to mint new tokens and distribute them to specified addresses.

##### burn

```solidity
function burn(uint256 amount) external {
    _burn(msg.sender, amount);
}
```

Allows any token holder to burn a specified amount of their tokens.

##### getRedeemableItems

```solidity
function getRedeemableItems() external view returns (itemsAvail[] memory) {
    return redeemableItems;
}
```
##### redeem

```solidity
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
```

Allows players to redeem tokens for specific items in the in-game store. Costs for items are predefined.



##### addItem

```solidity
function _addItem(address user, string memory item) internal {
    uint256 index = _itemIndex[user][item];
    if (index == 0) {
        _inventory[user].push(Item({name: item, quantity: 1}));
        _itemIndex[user][item] = _inventory[user].length - 1;
    } else {
        _inventory[user][index].quantity += 1;
    }
}

}
```
Internal function to add an item to a player's inventory.


##### transferTokens

```solidity
function transferTokens(address to, uint256 amount) external {
    _transfer(msg.sender, to, amount);
}
```

Allows token holders to transfer tokens to other addresses.

##### getInventory

```solidity
function getInventory() external view returns (Item[] memory) {
    return _inventory[msg.sender];
}
```
Allows token holders to transfer tokens to other addresses.


### Deployment

#### Prerequisites

- Node.js (v14.x or later)
- Remix
- Avalanche network key (for deployment)

#### Steps

1. **Access Remix IDE**:
  Open Remix IDE in your web browser.

2. **Select Compiler Version**:
   Ensure the compiler version is set to 0.8.20 or compatible with the contract.

3. **Deploy Contract:**:
    - Navigate to the Deploy & Run Transactions tab in Remix.
    - Select "Injected Provider - Metamask".
    - Select DegenToken from the contract dropdown.
    - Click on the Deploy button.
    - Confirm the transaction in MetaMask (ensure you are connected to the SnowTrace Faucet Testnet).


### Interacting with the Contract

Once deployed, interact with the `DegenToken` contract using Remix's deployed box below the Deployed section.

### SnowTrace Faucet Testnet

After deployement, and interacting. Copy the address of the deployed contract and in Snowtrace.io testnet, search the copied address. There you will be able to verify the deploed interactions done by you (e.g. minting, redeeming, burning etc).

### License

This project is licensed under the MIT License - see the LICENSE file for details.

### Authors

Pratik Mishra

### Contributing

Contributions are welcome! Feel free to submit issues and pull requests.

---

This README provides a detailed guide to understanding, deploying, and interacting with the `DegenToken` smart contract on the Avalanche blockchain using Hardhat and JavaScript scripts. 
