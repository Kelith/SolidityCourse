from brownie import accounts, config, SimpleStorage
import time

def deploy_simple_storage():
    account = get_account()
    simplestorage = SimpleStorage.deploy({"from":account})
    time.sleep(1) 
    print(simplestorage)
    stored_value = simplestorage.retrieve()
    print(stored_value)
    transaction= simplestorage.store(15, {"from":account})
    transaction.wait(1)
    print(simplestorage.retrieve())

def get_account():
    if network.show_active() == "development"
        return accounts[0]
    else:
            #Take the account from the config file
        accounts.add(config["wallets"]["from_key"])

def main():
    deploy_simple_storage()