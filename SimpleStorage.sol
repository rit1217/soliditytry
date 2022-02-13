pragma solidity ^0.6.0;

//smart contract (as class in java)
contract SimpleStorage {
    // state changing function calls are transactions (cost gas)

    //------------------Data Types--------------------
    //unsigned int 256 bits
    // uint256 favoriteNumber = 5;
    // bool favoriteBool = true;
    // string favoriteString = "String";
    // int256 favoriteInt = -5;
    // //MetaMask address
    // address favoriteAddress = 0xd7a5506dB374d05EcBA383c5b25fD7e32CBA54a8;
    // bytes32 favoriteBytes = "cat";
    //--------------------------------------------------
    //unsigned int 256 bits public variable
    // public-can be called by another contracts and via transaction
    // external-can't be called by the same contract
    // internal-can only be called by the same contract
    // private-only visible for the contract that defined it
    uint256 public favoriteNumber;

    //new type in solidity
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People public person = People({favoriteNumber: 2, name: "Patrick"});
    //define public function
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    // view and pure are non state changing function call
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    function plus(uint256 favoriteNumber2) public pure {
        favoriteNumber2 + favoriteNumber2;    // not be saved 
    }
}