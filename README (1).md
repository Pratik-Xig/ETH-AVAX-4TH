## Degen Token (Avalanche)

The Degen Token is an ERC20 token deployed on the Avalanche blockchain, designed for use within the Degen Gaming ecosystem. Players can earn tokens as rewards in games and redeem them for in-game items or trade them with other players.

### Contract Details

The `DegenToken` smart contract is based on the ERC20 standard and includes additional functionalities to support the Degen Gaming platform:

#### State Variables

- `address public owner`: Stores the address of the contract owner.

#### Constructor

```solidity
constructor() ERC20("DegenToken", "DGN") {
    owner = msg.sender;
}
```

The constructor sets the contract deployer as the owner and initializes the token with a name ("DegenToken") and symbol ("DGN").

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

##### redeem

```solidity
function redeem(string memory item) external {
    uint256 cost;
    if (keccak256(bytes(item)) == keccak256("avatar")) {
        cost = 100;
    } else if (keccak256(bytes(item)) == keccak256("vehicle")) {
        cost = 100;
    } else if (keccak256(bytes(item)) == keccak256("mystery")) {
        cost = 60;
    } else {
        revert("Invalid item");
    }

    require(balanceOf(msg.sender) >= cost, "Insufficient balance");
    _burn(msg.sender, cost);
}
```

Allows players to redeem tokens for specific items in the in-game store. Costs for items are predefined.

##### transferTokens

```solidity
function transferTokens(address to, uint256 amount) external {
    _transfer(msg.sender, to, amount);
}
```

Allows token holders to transfer tokens to other addresses.

### Deployment

#### Prerequisites

- Node.js (v14.x or later)
- Hardhat (v2.8.x)
- Avalanche network key (for deployment)

#### Steps

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/your-username/degen-token-avalanche.git
    cd degen-token-avalanche
    ```

2. **Install Dependencies**:
    ```bash
    npm install
    ```

3. **Configure Hardhat**:
    - Update `hardhat.config.js` with your Avalanche network key and network settings.

4. **Write and Compile Smart Contract**:
    - Create or update `contracts/DegenToken.sol` with the `DegenToken` contract code.
    - Ensure `DegenToken.sol` includes the necessary imports and functions as discussed.

5. **Deploy Contract**:
    - Write deployment scripts (e.g., `scripts/deploy.js`) using Hardhat to deploy `DegenToken` to the Avalanche network.
    - Run the deployment script:
      ```bash
      npx hardhat run scripts/deploy.js --network fuji
      ```

### Interacting with the Contract

Once deployed, interact with the `DegenToken` contract using scripts:

- **Mint Tokens** (`scripts/mint.js`):
    ```javascript
    async function mintTokens(contractAddress, recipient, amount) {
        // Connect to deployed contract
        const DegenToken = await ethers.getContractAt("DegenToken", contractAddress);

        // Mint tokens to recipient
        await DegenToken.connect(owner).mint(recipient, amount);
        console.log(`Minted ${amount} tokens to ${recipient}`);
    }

    // Replace placeholders with actual values
    mintTokens(contractAddress, recipient, amount);
    ```

- **Burn Tokens** (`scripts/burn.js`):
    ```javascript
    async function burnTokens(contractAddress, amount) {
        // Connect to deployed contract
        const DegenToken = await ethers.getContractAt("DegenToken", contractAddress);

        // Burn tokens from caller's balance
        await DegenToken.connect(owner).burn(amount);
        console.log(`Burned ${amount} tokens`);
    }

    // Replace placeholders with actual values
    burnTokens(contractAddress, amount);
    ```

- **Redeem Tokens** (`scripts/redeem.js`):
    ```javascript
    async function redeemTokens(contractAddress, item) {
        // Connect to deployed contract
        const DegenToken = await ethers.getContractAt("DegenToken", contractAddress);

        // Redeem tokens for specified item
        await DegenToken.connect(owner).redeem(item);
        console.log(`Redeemed ${item}`);
    }

    // Replace placeholders with actual values
    redeemTokens(contractAddress, item);
    ```

- **Transfer Tokens** (`scripts/transfer.js`):
    ```javascript
    async function transferTokens(contractAddress, recipient, amount) {
        // Connect to deployed contract
        const DegenToken = await ethers.getContractAt("DegenToken", contractAddress);

        // Transfer tokens to recipient
        await DegenToken.connect(owner).transferTokens(recipient, amount);
        console.log(`Transferred ${amount} tokens to ${recipient}`);
    }

    // Replace placeholders with actual values
    transferTokens(contractAddress, recipient, amount);
    ```

### License

This project is licensed under the MIT License - see the LICENSE file for details.

### Authors

Sujal Mahajan

### Contributing

Contributions are welcome! Feel free to submit issues and pull requests.

---

This README provides a detailed guide to understanding, deploying, and interacting with the `DegenToken` smart contract on the Avalanche blockchain using Hardhat and JavaScript scripts. 
