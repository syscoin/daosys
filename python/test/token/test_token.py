import pytest
import sys
import os

sys.path.insert(0, os.getcwd().replace("test/token",""))
from python.dev.token import Token

TOKEN_DELTA = 10000

def test_initial_balance_of():
    token = Token(Token.TYPE_DEPOSIT)
    addr = token.gen_address()
    token.deposit(TOKEN_DELTA, addr)
    balance = token.balance_of(addr)
    assert balance == TOKEN_DELTA


def test_balance_of_after_transfer():
    assert True   

def test_total_supply():
    assert True     

def test_total_aggregate_supply():
    assert True        

def test_transfer_from():
    assert True    

def test_mint():
    assert True         

if __name__ == '__main__':

    test_initial_balance_of()
    test_balance_of_after_transfer()
    test_total_supply()
    test_total_aggregate_supply()
    test_transfer_from()
