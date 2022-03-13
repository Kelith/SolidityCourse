from brownie import SimpleStorage, accounts

def test_deploy():
    #Arrange
    account = accounts[0]
    #Act
    simplestorage = SimpleStorage.deploy({"from":account})
    starting_value = simplestorage.retrieve()
    expected = 0
    #Assert
    assert starting_value == expected

def test_updating_storage():
    #Arrange
    account = accounts[0]
    simplestorage = SimpleStorage.deploy({"from":account})
    #Act
    expected = 15
    simplestorage.store(15,{"from":account})
    #Assert
    assert simplestorage.retrieve() == expected
