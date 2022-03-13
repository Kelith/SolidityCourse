from brownie import SimpleStorage, accounts

def read_contract():
    #Simple storage works as an array of deployed contracts
    simplestorage = SimpleStorage[-1]  #-1 gets the latest deployment
    print(simplestorage.retrieve())


def main():
    read_contract()