// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <0.9.0;

import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {ERC721Holder} from "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import {TablelandDeployments} from "@tableland/evm/contracts/utils/TablelandDeployments.sol";
import {SQLHelpers} from "@tableland/evm/contracts/utils/SQLHelpers.sol";
import {TablelandController} from "@tableland/evm/contracts/TablelandController.sol";
import {TablelandPolicy} from "@tableland/evm/contracts/TablelandPolicy.sol";

contract Example  is TablelandController, ERC721Holder {


    address public owner;
     uint256 public _tableId; // Unique table ID
    string private constant _TABLE_PREFIX = "credits"; // Custom table prefix
    mapping(address=>bool) public trusted_protocols;


    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender==owner,"Only owner can call");
        _;
    }

    // Creates a simple table with an `id` and `val` column
    function createTable() public payable {
      _tableId = TablelandDeployments.get().create(
            address(this),
            SQLHelpers.toCreateFromSchema(
              "address text unique primary key, score integer, timestamp integer",
              _TABLE_PREFIX
            )
        );
    }

        function insertIntoTable(address user,uint256 credit,uint256 timestamp) external {
            string memory addr = Strings.toHexString(user);
        TablelandDeployments.get().mutate(
            address(this), // Table owner, i.e., this contract
            _tableId,
            SQLHelpers.toInsert(
                _TABLE_PREFIX,
                _tableId,
               "address,score,timestamp",
                string.concat(
                SQLHelpers.quote(addr),
                ",",
                 SQLHelpers.quote(Strings.toString(credit)),
                 ",",
                 SQLHelpers.quote(Strings.toString(timestamp))
                )
            )
        );
    }

    function updateTable(address user,uint256 credit,uint256 timestamp) public{
        string memory addr=Strings.toHexString(user);
         string memory setters = string.concat("score=", SQLHelpers.quote(Strings.toString(credit)),",timestamp=",SQLHelpers.quote(Strings.toString(timestamp)));
         
        string memory filters = string.concat(
            "address=",
            SQLHelpers.quote(addr)
        );

        TablelandDeployments.get().mutate(
            address(this),
            _tableId,
            SQLHelpers.toUpdate(_TABLE_PREFIX, _tableId, setters, filters)
        );
    }

    function add_trusted_protocol(address _protocol) public onlyOwner{
        trusted_protocols[_protocol]=true;
    }

    function getTrustedProtocol(address _protocol) view public returns(bool){
        return trusted_protocols[_protocol];
    }

    
    function getPolicy(
        address,
        uint256
    ) public payable override returns (TablelandPolicy memory) {
        // Return allow-insert policy
        return
            TablelandPolicy({
                allowInsert: true,
                allowUpdate: false,
                allowDelete: false,
                whereClause: "",
                withCheck: "",
                updatableColumns: new string[](0)
            });
    }

    function getTableId() external view returns (uint256) {
        return _tableId;
    }

    // Return the table name
    function getTableName() public  view returns (string memory) {
        return SQLHelpers.toNameFromId(_TABLE_PREFIX, _tableId);
    }
}


//Deployed sepolia: 0x41dc36d271d27a3a88fa9993A84572E1daA8A027

//https://testnets.tableland.network/api/v1/tables/11155111/1377
//0xF483a5f2FA0F80896C4ccF2Bc593a74d4e1deB1A

//https://testnets.tableland.network/api/v1/receipt/11155111/0xe1ae147b847f1c08a25aa400ee6d842771c8e9d25571522e50d87295fa071668

// https://testnets.tableland.network/api/v1/query?statement=select%20%2A%20from%20credits_11155111_1374
// https://testnets.tableland.network/api/v1/query?statement=select%20%2A%20from%20credits_11155111_1378

//https://testnets.tableland.network/api/v1/query?statement=select%20*%20from%20credits_11155111_1312%20where%20address%20=%20'0x7062c36a0f657060bb8057debdb8ec69bdad9aa4'