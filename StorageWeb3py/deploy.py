from solcx import compile_standard
import json

with open("./simplestorage.sol", "r") as file:
    simple_storage_file = file.read()
    #py-solc-x is used as compiler

# Compile
compiled_sol = compile_standard(
    {
    "language": "Solidity",
    "sources": {"SimpleStorage.sol": {"content": simple_storage_file}},
    "settings": {
        "outputSelection":{
            "*": {
                "*": ["abi", "metadata", "metadata", "evm.bytecode", "evm.sourceMap"]
                }
            },
        },
    },
)

with open("compiled_sol.json", "w") as file:
    json.dump(compiled_sol, file)
