// SPDX-License_Identifier: MIT

pragma solidity ^0.6.0;

import "./SimpleStorage.sol";

//--- inheritance : contract StorageFactory is SimpleStorage{} ---

// this contract will deploy SimpleStorage
contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;

    //create(deploy) contract
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber ) public {
        //Address (can get from simpleStorageArray)
        SimpleStorage callingStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        //ABI : Application Binary Interface
        callingStorage.store(_simpleStorageNumber);
    }

    //Define in another way
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
    }
}
