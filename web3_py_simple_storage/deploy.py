from solcx import compile_standard


with open("./web3_py_simple_storage/SimpleStorage.sol","r") as file:
    simple_storage_file = file.read()
    
compiled_sol = compile_standard(
    {
        "language":"Solidity",
        "sources":{"SimpleStorage.sol":{"content": simple_storage_file}},
        "settings":{
            "outputSelection": {
                "*": {"*": ["abi", "metadata", "evm.bytecode", "evm.sourceMap"]}
            }
        }
    },
    solc_version="0.6.0",
)
print(compiled_sol)