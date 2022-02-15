from solcx import compile_standard
import json

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
with open("compiled_cod.json","w") as file:
    json.dump(compiled_sol, file)

#get bytecode
bytecode = compiled_sol["contracts"]["SimpleStorage.sol"]["SimpleStorage"]["evm"]["bytecode"]["object"]

#get abi
abi = compiled_sol["contracts"]["SimpleStorage.sol"]["SimpleStorage"]["abi"]
