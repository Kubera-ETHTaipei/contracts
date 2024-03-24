
# KUBERA

## DEPLOYED CONTRACTS

SCROLL SEPOLIA- 0x6641126700308379cdb602b4e8dc1afc13d6c088 <br/>
OPTIMISM SEPOLIA- 0xd9276777548d4b1e7b35b87d1ED9F8bA6FFcBfC6 <br/>
THUNDERCORE TESTNET - 0xd9276777548d4b1e7b35b87d1ED9F8bA6FFcBfC6 <br/>
LINEA TESTNET - 0xd9276777548d4b1e7b35b87d1ED9F8bA6FFcBfC6 <br/>
ZIRCUIT TESTNET - 0xd9276777548d4b1e7b35b87d1ED9F8bA6FFcBfC6 <br/>


## FLOW OF THE CONTRACT - kubera.sol
The Kubera contract is used to store and update credit values along with their last update timestamp of an user. Since, this is generally a gas-intensive method(it used sstore and sload), we realized it would be a hindrance to the UX of the application. In view of that, we are using Tableland contracts to store the data in Tableland tables and not inside the storage of this contract. This reduces gas costs by almost 40%. The contract majorly works on these 4 functions:

- `createTable()`: this is an initial function that is called only once by the owner of the contract to do the initial creation of the SQL table. This essentially sets up the schema of the table. <br/>
- `insertIntoTable(address user,uint256 credit,uint256 timestamp)`: adds a new user's calculated credit score and th etimestamp it was computed till into the table as a new row. <br/>
- `updateTable(address user,uint256 credit,uint256 timestamp)`:updates an existing row in the table based on the user address and updates score and timestamp. <br/>
- `add_trusted_protocol(address _protocol)` : allows addition and whitelisting of new trusted defi protocol to the contract.

This is novel approach where no data of any user can be fetched directy from the contract. Hence, essentially the credit score of any user is private.(even though it is on-chain)

However, there is a small security concern since the data can be accessed by hitting a specific API. This is something which we will work on upcoming updates. Some approaches we have been thinking is to implement Fully Homomorphic Encryption(FHE) and then store the encrypted values on-chain.

## Alternate Approach: Using Ten Protocol

The contract `PrivateCredit.sol` is deployed on Ten Protocol which is an EVM chain allowing private storage and state transitions by default. This essentially solves the security concern that is referred above. This contract is a lot more sophisticated and has a nascent formula to calculate a credit score based on an user's onchain activity. All events,variables and storage can only be accessed by whitelisted addresses which in this case will be the selected Defi Protocols.


# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```
