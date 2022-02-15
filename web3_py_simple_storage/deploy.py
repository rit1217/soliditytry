from solcx import compile_standard
import json
from web3 import Web3
import os
from dotenv import load_dotenv

#import environtment variable
load_dotenv()

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

#for connecting to Ganache
w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:7545"))
chain_id = 1337
my_address = "0xDcD500183D88fA28044cC89D72F00571dd25A571"
##NEVER HARD CODE PRIVATE KEY LIKE THIS##
#private_key = "0x3d57f118cfd14f465f6d12d81a118f728429f4f53ca72a25be583d66e7fe5869"

#get privatekey from environment variable PRIVATE_KEY
private_key = os.getenv("PRIVATE_KEY")

#Create the contract in python
SimpleStorage = w3.eth.contract(abi=abi, bytecode=bytecode)

#Get the latest transaction
nonce = w3.eth.getTransactionCount(my_address)

#1. Build a transaction
#2. Sign a transaction
#3. Send a transaction
transaction = SimpleStorage.constructor().buildTransaction(
    {"gasPrice": w3.eth.gas_price, "chainId":chain_id, "from":my_address, "nonce":nonce}
)
signed_txn = w3.eth.account.sign_transaction(transaction, private_key = private_key)    #signed transaction
# send this signed transaction
tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)
tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)

#Working with the contract, always need
#Contract Address and Contract ABI