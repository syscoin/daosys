import pytest
import sys
import os

sys.path.insert(0, os.getcwd().replace("test/token",""))
from python.dev.token import Token

TOT_INIT_SUPPLY = 50000000000000
TOKEN_DELTA = 10000
TOKEN_TRANSFER = 5000

def test_initial_balance_of():
    token = Token(Token.TYPE_DEPOSIT)
    addr = token.gen_address()
    token.deposit(TOKEN_DELTA, addr)
    balance = token.balance_of(addr)
    assert balance == TOKEN_DELTA


def test_balance_of_after_transfer():
    token = Token(Token.TYPE_DEPOSIT)
    from_addr = token.gen_address()
    to_addr = token.gen_address()
    token.deposit(TOKEN_DELTA, from_addr)
    token.deposit(0, to_addr)
    token.transfer_from(from_addr, to_addr, TOKEN_TRANSFER)
    balance = token.balance_of(to_addr)

    assert balance == TOKEN_DELTA - TOKEN_TRANSFER   

def test_total_supply():
    token = Token(Token.TYPE_DEPOSIT)
    from_addr = token.gen_address()
    token.deposit(TOKEN_DELTA, from_addr)
    tot_supply = token.total_supply()

    assert tot_supply == TOT_INIT_SUPPLY + TOKEN_DELTA      

def test_total_aggregate_supply():
    token = Token(Token.TYPE_DEPOSIT)
    from_addr = token.gen_address()

    tot_delta = 0
    for k in range(10):
        token.deposit(TOKEN_DELTA, from_addr)
        tot_delta = tot_delta + TOKEN_DELTA
    tot_supply = token.total_supply()

    assert tot_supply ==  tot_delta + TOT_INIT_SUPPLY      

def test_transfer_from():
    token = Token(Token.TYPE_DEPOSIT)
    from_addr = token.gen_address()
    to_addr = token.gen_address()
    token.deposit(TOKEN_DELTA, from_addr)
    token.deposit(0, to_addr)
    token.transfer_from(from_addr, to_addr, TOKEN_TRANSFER)
    balance = token.balance_of(from_addr)

    assert balance == TOKEN_DELTA - TOKEN_TRANSFER     

def test_mint():
    token = Token(Token.TYPE_DEPOSIT)
    addr = token.mint()
    balance = token.balance_of(addr)

    assert balance == 0         

if __name__ == '__main__':

    test_initial_balance_of()
    test_balance_of_after_transfer()
    test_total_supply()
    test_total_aggregate_supply()
    test_transfer_from()
    test_mint()
