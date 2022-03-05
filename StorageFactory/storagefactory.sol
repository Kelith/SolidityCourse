// SPDX-License_Identifier: MIT

pragma solidity ^0.6.0;

import "./simplestorage.sol";

// Factory pattern. Will be useful for NFTs!
// Used for deploying contracts from another contract
contract StorageFactory is SimpleStorage {              //inheritance of SimpleStorage contract

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    // Store a salary(ssnum) to the ss at index ssindx in the factory
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // Address
        // ABI: Application Binary Interface
        // To interact with a contract
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);

    }

    //retrieve a ss at index ssindx in the factory
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
    }
}