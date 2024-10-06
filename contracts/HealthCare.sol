// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealthCare {
    address public immutable hospitalAdmin;
    address public immutable labAdmin;

    struct Record {
        uint256 ID;
        uint256 price;
        uint256 signatureCount;
        string testName;
        string date;
        string hospitalName;
        bool isValue;
        address pAddr;
        mapping(address => uint256) signatures;
    }

    // Mapping to store records
    mapping(uint256 => Record) public _records;
    uint256[] public recordsArr;

    // Events
    event RecordCreated(uint256 ID, string testName, string date, string hospitalName, uint256 price);
    event RecordSigned(uint256 ID, string testName, string date, string hospitalName, uint256 price);

    // Modifiers
    modifier signOnly() {
        require(
            msg.sender == hospitalAdmin || msg.sender == labAdmin,
            "You are not authorized to sign this."
        );
        _;
    }

    modifier checkAuthBeforeSign(uint256 _ID) {
        require(_records[_ID].isValue, "Record does not exist");
        require(_records[_ID].pAddr != address(0), "Address is zero");
        require(
            msg.sender != _records[_ID].pAddr,
            "You are not authorized to perform this action"
        );
        require(
            _records[_ID].signatures[msg.sender] != 1,
            "Same person cannot sign twice."
        );
        _;
    }

    modifier validateRecord(uint256 _ID) {
        // Only allows new records to be created
        require(!_records[_ID].isValue, "Record with this ID already exists");
        _;
    }

    // Constructor
    constructor(address _labAdmin) {
        hospitalAdmin = msg.sender;
        labAdmin = _labAdmin;
    }

    // Create a new record
    function newRecord(
        uint256 _ID,
        uint256 price,
        string memory _tName,
        string memory _date,
        string memory hName
    ) public validateRecord(_ID) {
        Record storage _newrecord = _records[_ID];
        _newrecord.pAddr = msg.sender;
        _newrecord.ID = _ID;
        _newrecord.testName = _tName;
        _newrecord.date = _date;
        _newrecord.hospitalName = hName;
        _newrecord.price = price;
        _newrecord.isValue = true;
        _newrecord.signatureCount = 0;

        recordsArr.push(_ID);
        emit RecordCreated(_newrecord.ID, _tName, _date, hName, price);
    }

    // Function to sign a record
    function signRecord(uint256 _ID) public signOnly checkAuthBeforeSign(_ID) {
        Record storage record = _records[_ID];
        record.signatures[msg.sender] = 1;
        record.signatureCount++;

        // Checks if the record has been signed by both the authorities to process insurance claim
        if (record.signatureCount == 2) {
            emit RecordSigned(record.ID, record.testName, record.date, record.hospitalName, record.price);
        }
    }
}
