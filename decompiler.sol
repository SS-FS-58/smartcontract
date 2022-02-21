#
#  Panoramix v4 Oct 2019 
#  Decompiled source of bsc:0x484229b6FF311836DDB0BDe3F1f7aB6B0d03190e
# 
#  Let's make the world open source 
# 
#
#  I failed with these: 
#  - transferFrom(address _from, address _to, uint256 _value)
#  - transfer(address _to, uint256 _value)
#  - unknownc3cda520(?)
#  - _fallback()
#  All the rest is below.
#

const unknown1ad9339a = 1000
const unknown20606b70 = 0x8cad95687ba82c2ce50e74f7b754645e5117c3a5bec8151c0726d5857980a866
const unknowne7a324dc = 0xe48329057bfd03d55e49b547132e39cffd9c1820ad7b9d4c5307691425d15adf
const BURN_ADDRESS = 57005

def storage:
  owner is addr at storage 0
  balanceOf is mapping of uint256 at storage 1
  allowance is mapping of uint256 at storage 2
  totalSupply is uint256 at storage 3
  name is array of uint256 at storage 4
  symbol is array of uint256 at storage 5
  unknownb65d08b0 is uint16 at storage 6 offset 8
  unknown67444e15 is uint16 at storage 6 offset 72
  decimals is uint8 at storage 6
  unknown27e0faab is uint16 at storage 6 offset 24
  unknown89489816 is uint16 at storage 6 offset 40
  unknowncec7dbe3 is uint16 at storage 6 offset 88
  stor6 is uint16 at storage 6
  unknownf42b40aa is uint16 at storage 6 offset 56
  unknownf360d736Address is addr at storage 7
  unknown29f95997Address is addr at storage 8
  unknownf4288a40Address is addr at storage 9
  unknown395a8c18Address is addr at storage 10
  unknown5235dcdcAddress is addr at storage 11
  burnRate is uint16 at storage 11 offset 160
  stor11 is uint16 at storage 11
  unknown3ff8bf2e is uint16 at storage 11 offset 176
  stor12 is mapping of uint8 at storage 12
  unknown4a74bb02 is uint8 at storage 13
  unknownd8248358 is uint256 at storage 14
  unknown52ed40a4Address is addr at storage 15
  stor16 is uint256 at storage 16
  unknown51e393ebAddress is addr at storage 16
  operatorAddress is addr at storage 17
  minter is array of struct at storage 18
  stor19 is mapping of uint256 at storage 19
  unknownfa0e314b is array of struct at storage 20
  stor21 is mapping of uint256 at storage 21
  unknown51bf14b5 is array of struct at storage 22
  stor23 is mapping of uint256 at storage 23
  delegates is mapping of addr at storage 24
  unknownf1127ed8 is mapping of struct at storage 25
  unknown6fcfff45 is mapping of uint32 at storage 26
  nonces is mapping of uint256 at storage 27

def unknown0323aac7(): # not payable
  return minter.length

def name(): # not payable
  return name[0 len name.length]

def totalSupply(): # not payable
  return totalSupply

def unknown269f534c(addr _param1): # not payable
  require calldata.size - 4 >= 32
  return bool(stor12[addr(_param1)])

def unknown27e0faab(): # not payable
  return unknown27e0faab

def unknown29f95997(): # not payable
  return unknown29f95997Address

def decimals(): # not payable
  return decimals

def unknown32efd547(addr _param1): # not payable
  require calldata.size - 4 >= 32
  return bool(stor23[addr(_param1)])

def unknown395a8c18(): # not payable
  return unknown395a8c18Address

def unknown3ff8bf2e(): # not payable
  return unknown3ff8bf2e

def unknown4a74bb02(): # not payable
  return bool(unknown4a74bb02)

def unknown51bf14b5(uint256 _param1): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if _param1 > unknown51bf14b5.length - 1:
      revert with 0, 'SATOSHI: index out of bounds'
  if _param1 >= unknown51bf14b5.length:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  34,
                  0xfe456e756d657261626c655365743a20696e646578206f7574206f6620626f756e64,
                  mem[198 len 30]
  return unknown51bf14b5[_param1].field_0

def unknown51e393eb(): # not payable
  return addr(unknown51e393ebAddress)

def unknown5235dcdc(): # not payable
  return unknown5235dcdcAddress

def unknown52ed40a4(): # not payable
  return unknown52ed40a4Address

def operator(): # not payable
  return operatorAddress

def delegates(address _param1): # not payable
  require calldata.size - 4 >= 32
  return delegates[addr(_param1)]

def getMinter(uint256 _index): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if _index > minter.length - 1:
      revert with 0, 'SATOSHI: index out of bounds'
  if _index >= minter.length:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  34,
                  0xfe456e756d657261626c655365743a20696e646578206f7574206f6620626f756e64,
                  mem[198 len 30]
  return minter[_index].field_0

def unknown67444e15(): # not payable
  return unknown67444e15

def unknown6fcfff45(addr _param1): # not payable
  require calldata.size - 4 >= 32
  return unknown6fcfff45[_param1]

def balanceOf(address _owner): # not payable
  require calldata.size - 4 >= 32
  return balanceOf[addr(_owner)]

def nonces(address _param1): # not payable
  require calldata.size - 4 >= 32
  return nonces[_param1]

def unknown80861a90(addr _param1): # not payable
  require calldata.size - 4 >= 32
  return bool(stor21[addr(_param1)])

def getOwner(): # not payable
  return owner

def unknown89489816(): # not payable
  return unknown89489816

def owner(): # not payable
  return owner

def symbol(): # not payable
  return symbol[0 len symbol.length]

def isMinter(address _account): # not payable
  require calldata.size - 4 >= 32
  return bool(stor19[addr(_account)])

def unknownb65d08b0(): # not payable
  return unknownb65d08b0

def unknownbea7cb3a(): # not payable
  return unknownfa0e314b.length

def burnRate(): # not payable
  return burnRate

def unknowncec7dbe3(): # not payable
  return unknowncec7dbe3

def unknownd8248358(): # not payable
  return unknownd8248358

def allowance(address _owner, address _spender): # not payable
  require calldata.size - 4 >= 64
  return allowance[addr(_owner)][addr(_spender)]

def unknowne1033827(): # not payable
  return unknown51bf14b5.length

def unknownf1127ed8(addr _param1, uint32 _param2): # not payable
  require calldata.size - 4 >= 64
  return unknownf1127ed8[_param1][_param2].field_0, unknownf1127ed8[_param1][_param2].field_256

def unknownf360d736(): # not payable
  return unknownf360d736Address

def unknownf4288a40(): # not payable
  return unknownf4288a40Address

def unknownf42b40aa(): # not payable
  return unknownf42b40aa

def unknownfa0e314b(uint256 _param1): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if _param1 > unknownfa0e314b.length - 1:
      revert with 0, 'SATOSHI: index out of bounds'
  if _param1 >= unknownfa0e314b.length:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  34,
                  0xfe456e756d657261626c655365743a20696e646578206f7574206f6620626f756e64,
                  mem[198 len 30]
  return unknownfa0e314b[_param1].field_0

#
#  Regular functions
#

def unknown01533c43(addr _param1): # not payable
  require calldata.size - 4 >= 32
  if not stor23[caller]:
      revert with 0, '.caller is not the nft operator'
  unknownf360d736Address = _param1

def unknown0b25e98f(addr _param1): # not payable
  require calldata.size - 4 >= 32
  if not stor23[caller]:
      revert with 0, '.caller is not the nft operator'
  unknownf4288a40Address = _param1

def unknown5aa829a7(addr _param1): # not payable
  require calldata.size - 4 >= 32
  if not stor23[caller]:
      revert with 0, '.caller is not the nft operator'
  unknown395a8c18Address = _param1

def unknown60c21331(addr _param1): # not payable
  require calldata.size - 4 >= 32
  if not stor23[caller]:
      revert with 0, '.caller is not the nft operator'
  unknown5235dcdcAddress = _param1

def unknownfbc84f29(addr _param1): # not payable
  require calldata.size - 4 >= 32
  if not stor23[caller]:
      revert with 0, '.caller is not the nft operator'
  unknown29f95997Address = _param1

def renounceOwnership(): # not payable
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  log OwnershipTransferred(
        address previousOwner=owner,
        address newOwner=0)
  owner = 0

def unknownb4b5ea57(addr _param1): # not payable
  require calldata.size - 4 >= 32
  if unknown6fcfff45[addr(_param1)]:
      return unknownf1127ed8[addr(_param1)][stor26[addr(_param1)] - 1 << 224].field_256
  else:
      return 0

def unknowna392e674(uint256 _param1): # not payable
  require calldata.size - 4 >= 32
  if operatorAddress != caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x2e6f70657261746f723a2063616c6c6572206973206e6f7420746865206f70657261746f,
                  mem[200 len 28]
  log 0x54c7a13f: unknownd8248358, _param1, caller
  unknownd8248358 = _param1

def unknown9f9a4e7f(bool _param1): # not payable
  require calldata.size - 4 >= 32
  if operatorAddress != caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x2e6f70657261746f723a2063616c6c6572206973206e6f7420746865206f70657261746f,
                  mem[200 len 28]
  log 0x3ca65588: _param1, caller
  unknown4a74bb02 = uint8(_param1)

def unknowna9e75723(): # not payable
  if not totalSupply:
      return 0
  if unknown3ff8bf2e * totalSupply / totalSupply != unknown3ff8bf2e:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  33,
                  0x2e536166654d6174683a206d756c7469706c69636174696f6e206f766572666c6f,
                  mem[197 len 31]
  return (unknown3ff8bf2e * totalSupply / 10 * 10^6)

def unknownc7f59a67(addr _param1, bool _param2): # not payable
  require calldata.size - 4 >= 64
  if operatorAddress != caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x2e6f70657261746f723a2063616c6c6572206973206e6f7420746865206f70657261746f,
                  mem[200 len 28]
  stor12[addr(_param1)] = uint8(_param2)

def transferOwnership(address _newOwner): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if not _newOwner:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  38,
                  0x644f776e61626c653a206e6577206f776e657220697320746865207a65726f20616464726573,
                  mem[202 len 26]
  log OwnershipTransferred(
        address previousOwner=owner,
        address newOwner=_newOwner)
  owner = _newOwner

def mint(uint256 _wad): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if not caller:
      revert with 0, 'BEP20: mint to the zero address'
  if _wad + totalSupply < totalSupply:
      revert with 0, 'SafeMath: addition overflow'
  totalSupply += _wad
  if _wad + balanceOf[caller] < balanceOf[caller]:
      revert with 0, 'SafeMath: addition overflow'
  balanceOf[caller] += _wad
  log Transfer(
        address from=_wad,
        address to=0,
        uint256 value=caller)
  return 1

def unknownf607f2b4(uint16 _param1): # not payable
  require calldata.size - 4 >= 32
  if operatorAddress != caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x2e6f70657261746f723a2063616c6c6572206973206e6f7420746865206f70657261746f,
                  mem[200 len 28]
  if _param1 > 100:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  68,
                  0x735341544f5348493a3a7570646174654275726e526174653a204275726e2072617465206d757374206e6f742065786365656420746865206d6178696d756d2072617465,
                  mem[232 len 28]
  log 0x3eec6963: stor11, _param1, caller
  burnRate = _param1

def unknown6a141e2c(uint16 _param1): # not payable
  require calldata.size - 4 >= 32
  if operatorAddress != caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x2e6f70657261746f723a2063616c6c6572206973206e6f7420746865206f70657261746f,
                  mem[200 len 28]
  if _param1 > 10000:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  96,
                  0x735341544f5348493a3a7570646174654d61785472616e73666572416d6f756e74526174653a204d6178207472616e7366657220616d6f756e742072617465206d757374206e6f742065786365656420746865206d6178696d756d2072617465
  log 0xb62a50fc: stor11, _param1, caller
  unknown3ff8bf2e = _param1

def unknown376c2391(uint16 _param1): # not payable
  require calldata.size - 4 >= 32
  if operatorAddress != caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x2e6f70657261746f723a2063616c6c6572206973206e6f7420746865206f70657261746f,
                  mem[200 len 28]
  if _param1 > 1000:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  83,
                  0x2e5341544f5348493a3a7570646174655472616e73666572546178526174653a205472616e73666572207461782072617465206d757374206e6f742065786365656420746865206d6178696d756d2072617465,
                  mem[247 len 13]
  log 0xe9d5c8ee: stor6, _param1, caller
  unknownb65d08b0 = _param1

def addMinter(address _minter): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if not _minter:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  39,
                  0x6f5341544f5348493a205f6164644d696e74657220697320746865207a65726f20616464726573,
                  mem[203 len 25]
  if stor19[addr(_minter)]:
      return 0
  minter.length++
  minter[minter.length].field_0 = _minter
  minter[minter.length].field_160 = 0
  stor19[addr(_minter)] = minter.length
  return 1

def unknown4bee8499(uint16 _param1): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if _param1 > 100:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  59,
                  0x655341544f5348493a3a7570646174654e6674466565526174653a206e6674206665652072617465206d757374206e6f7420657863656564203125,
                  mem[223 len 5]
  if _param1 <= 0:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  63,
                  0x735341544f5348493a3a7570646174654e6674466565526174653a206e6674206665652072617465206d7573742062652067726561746572207468616e2030,
                  mem[227 len 1]
  unknowncec7dbe3 = _param1

def unknown769d5b92(uint16 _param1): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if _param1 > 100:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  59,
                  0x655341544f5348493a3a7570646174654e6674466565526174653a206e6674206665652072617465206d757374206e6f7420657863656564203125,
                  mem[223 len 5]
  if _param1 <= 0:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  63,
                  0x735341544f5348493a3a7570646174654e6674466565526174653a206e6674206665652072617465206d7573742062652067726561746572207468616e2030,
                  mem[227 len 1]
  unknownf42b40aa = _param1

def unknown8065f633(uint16 _param1): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if _param1 > 100:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  59,
                  0x655341544f5348493a3a7570646174654e6674466565526174653a206e6674206665652072617465206d757374206e6f7420657863656564203125,
                  mem[223 len 5]
  if _param1 <= 0:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  63,
                  0x735341544f5348493a3a7570646174654e6674466565526174653a206e6674206665652072617465206d7573742062652067726561746572207468616e2030,
                  mem[227 len 1]
  unknown27e0faab = _param1

def unknown95e4d04d(uint16 _param1): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if _param1 > 100:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  59,
                  0x655341544f5348493a3a7570646174654e6674466565526174653a206e6674206665652072617465206d757374206e6f7420657863656564203125,
                  mem[223 len 5]
  if _param1 <= 0:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  63,
                  0x735341544f5348493a3a7570646174654e6674466565526174653a206e6674206665652072617465206d7573742062652067726561746572207468616e2030,
                  mem[227 len 1]
  unknown67444e15 = _param1

def unknownda19d30f(uint16 _param1): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if _param1 > 100:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  59,
                  0x655341544f5348493a3a7570646174654e6674466565526174653a206e6674206665652072617465206d757374206e6f7420657863656564203125,
                  mem[223 len 5]
  if _param1 <= 0:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  63,
                  0x735341544f5348493a3a7570646174654e6674466565526174653a206e6674206665652072617465206d7573742062652067726561746572207468616e2030,
                  mem[227 len 1]
  unknown89489816 = _param1

def transferOperator(address _newOperator): # not payable
  require calldata.size - 4 >= 32
  if operatorAddress != caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x2e6f70657261746f723a2063616c6c6572206973206e6f7420746865206f70657261746f,
                  mem[200 len 28]
  if not _newOperator:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  59,
                  0x735341544f5348493a3a7472616e736665724f70657261746f723a206e6577206f70657261746f7220697320746865207a65726f20616464726573,
                  mem[223 len 5]
  log OperatorTransferred(
        address previousOperator=operatorAddress,
        address newOperator=_newOperator)
  operatorAddress = _newOperator

def unknown9475f387(addr _param1): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if not _param1:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  42,
                  0x735341544f5348493a205f616464426c6f636b4164647220697320746865207a65726f20616464726573,
                  mem[206 len 22]
  if stor21[addr(_param1)]:
      return 0
  unknownfa0e314b.length++
  unknownfa0e314b[unknownfa0e314b.length].field_0 = _param1
  unknownfa0e314b[unknownfa0e314b.length].field_160 = 0
  stor21[addr(_param1)] = unknownfa0e314b.length
  return 1

def approve(address _spender, uint256 _value): # not payable
  require calldata.size - 4 >= 64
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x7342455032303a20617070726f76652066726f6d20746865207a65726f20616464726573,
                  mem[200 len 28]
  if not _spender:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  34,
                  0x42455032303a20617070726f766520746f20746865207a65726f2061646472657300,
                  mem[198 len 30]
  allowance[caller][addr(_spender)] = _value
  log Approval(
        address owner=_value,
        address spender=caller,
        uint256 value=_spender)
  return 1

def unknown4208a616(addr _param1): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if not _param1:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  44,
                  0x735341544f5348493a205f6164644e66744f70657261746f7220697320746865207a65726f20616464726573,
                  mem[208 len 20]
  if stor23[addr(_param1)]:
      return 0
  unknown51bf14b5.length++
  unknown51bf14b5[unknown51bf14b5.length].field_0 = _param1
  unknown51bf14b5[unknown51bf14b5.length].field_160 = 0
  stor23[addr(_param1)] = unknown51bf14b5.length
  return 1

def decreaseAllowance(address _spender, uint256 _subtractedValue): # not payable
  require calldata.size - 4 >= 64
  if _subtractedValue > allowance[caller][addr(_spender)]:
      revert with 0, 
                  32,
                  37,
                  0x7342455032303a2064656372656173656420616c6c6f77616e63652062656c6f77207a6572,
                  mem[165 len 27],
                  mem[219 len 5]
  if not caller:
      revert with 0, 32, 36, 0x7342455032303a20617070726f76652066726f6d20746865207a65726f20616464726573, mem[296 len 28]
  if not _spender:
      revert with 0, 32, 34, 0x42455032303a20617070726f766520746f20746865207a65726f2061646472657300, mem[294 len 30]
  allowance[caller][addr(_spender)] -= _subtractedValue
  log Approval(
        address owner=(allowance[caller][addr(_spender)] - _subtractedValue),
        address spender=caller,
        uint256 value=_spender)
  return 1

def increaseAllowance(address _spender, uint256 _addedValue): # not payable
  require calldata.size - 4 >= 64
  if _addedValue + allowance[caller][addr(_spender)] < allowance[caller][addr(_spender)]:
      revert with 0, 'SafeMath: addition overflow'
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x7342455032303a20617070726f76652066726f6d20746865207a65726f20616464726573,
                  mem[200 len 28]
  if not _spender:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  34,
                  0x42455032303a20617070726f766520746f20746865207a65726f2061646472657300,
                  mem[198 len 30]
  allowance[caller][addr(_spender)] += _addedValue
  log Approval(
        address owner=(_addedValue + allowance[caller][addr(_spender)]),
        address spender=caller,
        uint256 value=_spender)
  return 1

def delMinter(address _address): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if not _address:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  39,
                  0x735341544f5348493a205f64656c4d696e74657220697320746865207a65726f20616464726573,
                  mem[203 len 25]
  if not stor19[addr(_address)]:
      return 0
  require minter.length - 1 < minter.length
  require stor19[addr(_address)] - 1 < minter.length
  minter[stor19[addr(_address)]].field_0 = minter[minter.length].field_0
  stor19[stor18[stor18.length].field_0] = stor19[addr(_address)]
  require minter.length
  minter[minter.length].field_0 = 0
  minter.length--
  stor19[addr(_address)] = 0
  return 1

def unknownd2681804(addr _param1): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if not _param1:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  42,
                  0x645341544f5348493a205f64656c626c6f636b4164647220697320746865207a65726f20616464726573,
                  mem[206 len 22]
  if not stor21[addr(_param1)]:
      return 0
  require unknownfa0e314b.length - 1 < unknownfa0e314b.length
  require stor21[addr(_param1)] - 1 < unknownfa0e314b.length
  unknownfa0e314b[stor21[addr(_param1)]].field_0 = unknownfa0e314b[unknownfa0e314b.length].field_0
  stor21[stor20[stor20.length].field_0] = stor21[addr(_param1)]
  require unknownfa0e314b.length
  unknownfa0e314b[unknownfa0e314b.length].field_0 = 0
  unknownfa0e314b.length--
  stor21[addr(_param1)] = 0
  return 1

def unknown1b9173d5(addr _param1): # not payable
  require calldata.size - 4 >= 32
  if owner != caller:
      revert with 0, 'wOwnable: caller is not the owne'
  if not _param1:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  44,
                  0x745341544f5348493a205f64656c4e66744f70657261746f7220697320746865207a65726f20616464726573,
                  mem[208 len 20]
  if not stor23[addr(_param1)]:
      return 0
  require unknown51bf14b5.length - 1 < unknown51bf14b5.length
  require stor23[addr(_param1)] - 1 < unknown51bf14b5.length
  unknown51bf14b5[stor23[addr(_param1)]].field_0 = unknown51bf14b5[unknown51bf14b5.length].field_0
  stor23[stor22[stor22.length].field_0] = stor23[addr(_param1)]
  require unknown51bf14b5.length
  unknown51bf14b5[unknown51bf14b5.length].field_0 = 0
  unknown51bf14b5.length--
  stor23[addr(_param1)] = 0
  return 1

def unknown998b1cdd(addr _param1): # not payable
  require calldata.size - 4 >= 32
  if operatorAddress != caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x2e6f70657261746f723a2063616c6c6572206973206e6f7420746865206f70657261746f,
                  mem[200 len 28]
  unknown52ed40a4Address = _param1
  require ext_code.size(_param1)
  static call _param1.factory() with:
          gas gas_remaining wei
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size >= 32
  require ext_code.size(unknown52ed40a4Address)
  static call unknown52ed40a4Address.WETH() with:
          gas gas_remaining wei
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size >= 32
  require ext_code.size(addr(ext_call.return_data))
  static call addr(ext_call.return_data).0xe6a43905 with:
          gas gas_remaining wei
         args addr(this.address), addr(ext_call.return_data)
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]
  require return_data.size >= 32
  uint256(stor16) = ext_call.return_data or Mask(96, 160, uint256(stor16))
  if not ext_call.return_data[12 len 20]:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  51,
                  0x725341544f5348493a3a7570646174655361746f736869526f757465723a20496e76616c696420706169722061646472657373,
                  mem[215 len 13]
  log 0x818b9215: caller, unknown52ed40a4Address, addr(unknown51e393ebAddress)

def unknown782d6fe1(addr _param1, uint256 _param2) payable: 
  mem[64] = 96
  require not call.value
  require calldata.size - 4 >= 64
  if _param2 >= block.number:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  42,
                  0x655341544f5348493a3a6765745072696f72566f7465733a206e6f74207965742064657465726d696e65,
                  mem[206 len 22]
  if not unknown6fcfff45[addr(_param1)]:
      return 0
  if _param2 >= unknownf1127ed8[addr(_param1)][stor26[addr(_param1)] - 1 << 224].field_0:
      return unknownf1127ed8[addr(_param1)][stor26[addr(_param1)] - 1 << 224].field_256
  if _param2 < unknownf1127ed8[addr(_param1)][0].field_0:
      return 0
  idx = 0
  while uint32(unknown6fcfff45[addr(_param1)] - 1) > uint32(idx):
      _32 = mem[64]
      mem[64] = mem[64] + 64
      mem[_32] = 0
      mem[_32 + 32] = 0
      mem[0] = uint32(unknown6fcfff45[addr(_param1)] + -(uint32(unknown6fcfff45[addr(_param1)] + -idx - 1) / 2) - 1)
      mem[32] = sha3(addr(_param1), 25)
      _35 = mem[64]
      mem[64] = mem[64] + 64
      mem[_35] = unknownf1127ed8[addr(_param1)][stor26[addr(_param1)] + -(uint32(stor26[addr(_param1)] + -idx - 1) / 2) - 1 << 224].field_0
      mem[_35 + 32] = unknownf1127ed8[addr(_param1)][stor26[addr(_param1)] + -(uint32(stor26[addr(_param1)] + -idx - 1) / 2) - 1 << 224].field_256
      if _param2 == unknownf1127ed8[addr(_param1)][stor26[addr(_param1)] + -(uint32(stor26[addr(_param1)] + -idx - 1) / 2) - 1 << 224].field_0:
          return unknownf1127ed8[addr(_param1)][stor26[addr(_param1)] + -(uint32(stor26[addr(_param1)] + -idx - 1) / 2) - 1 << 224].field_256
      if _param2 <= unknownf1127ed8[addr(_param1)][stor26[addr(_param1)] + -(uint32(stor26[addr(_param1)] + -idx - 1) / 2) - 1 << 224].field_0:
          idx = idx
          continue 
      idx = unknown6fcfff45[addr(_param1)] + -(uint32(unknown6fcfff45[addr(_param1)] + -idx - 1) / 2) - 1
      continue 
  return unknownf1127ed8[addr(_param1)][idx << 224].field_256

def mint(address _to, uint256 _amount): # not payable
  require calldata.size - 4 >= 64
  if not stor19[caller]:
      revert with 0, 'caller is not the minter'
  if not _to:
      revert with 0, 'BEP20: mint to the zero address'
  if _amount + totalSupply < totalSupply:
      revert with 0, 'SafeMath: addition overflow'
  totalSupply += _amount
  if _amount + balanceOf[addr(_to)] < balanceOf[addr(_to)]:
      revert with 0, 'SafeMath: addition overflow'
  balanceOf[addr(_to)] += _amount
  log Transfer(
        address from=_amount,
        address to=0,
        uint256 value=_to)
  if delegates[addr(_to)] != 0:
      if _amount > 0:
          if delegates[addr(_to)]:
              if unknown6fcfff45[stor24[addr(_to)]]:
                  if _amount + unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]] - 1 << 224].field_256 < unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]] - 1 << 224].field_256:
                      revert with 0, 'SafeMath: addition overflow'
                  if block.number >= 4294967296:
                      revert with 0, 
                                  32,
                                  55,
                                  0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                  Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[183 len 9])
                  if unknown6fcfff45[stor24[addr(_to)]] <= 0:
                      unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]]].field_0 = uint32(block.number)
                      unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]]].field_256 = _amount + unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]] - 1 << 224].field_256
                      unknown6fcfff45[stor24[addr(_to)]] = uint32(unknown6fcfff45[stor24[addr(_to)]] + 1)
                  else:
                      if unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]] - 1 << 224].field_0 == uint32(block.number):
                          unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]] - 1 << 224].field_256 += _amount
                      else:
                          unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]]].field_0 = uint32(block.number)
                          unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]]].field_256 = _amount + unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]] - 1 << 224].field_256
                          unknown6fcfff45[stor24[addr(_to)]] = uint32(unknown6fcfff45[stor24[addr(_to)]] + 1)
                  log 0xdec2bacd: unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]] - 1 << 224].field_256, _amount + unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]] - 1 << 224].field_256, delegates[addr(_to)]
              else:
                  if _amount < 0:
                      revert with 0, 'SafeMath: addition overflow'
                  if block.number >= 4294967296:
                      revert with 0, 
                                  32,
                                  55,
                                  0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                  Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[183 len 9])
                  if unknown6fcfff45[stor24[addr(_to)]] <= 0:
                      unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]]].field_0 = uint32(block.number)
                      unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]]].field_256 = _amount
                      unknown6fcfff45[stor24[addr(_to)]] = uint32(unknown6fcfff45[stor24[addr(_to)]] + 1)
                  else:
                      if unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]] - 1 << 224].field_0 == uint32(block.number):
                          unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]] - 1 << 224].field_256 = _amount
                      else:
                          unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]]].field_0 = uint32(block.number)
                          unknownf1127ed8[stor24[addr(_to)]][stor26[stor24[addr(_to)]]].field_256 = _amount
                          unknown6fcfff45[stor24[addr(_to)]] = uint32(unknown6fcfff45[stor24[addr(_to)]] + 1)
                  log 0xdec2bacd: 0, _amount, delegates[addr(_to)]
  return 1

def delegate(address _to): # not payable
  require calldata.size - 4 >= 32
  delegates[caller] = _to
  log 0x3134e8a2: caller, delegates[caller], _to
  if delegates[caller] != _to:
      if balanceOf[caller] > 0:
          if not delegates[caller]:
              if _to:
                  if unknown6fcfff45[addr(_to)]:
                      if balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 < unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256:
                          revert with 0, 'SafeMath: addition overflow'
                      if block.number >= 4294967296:
                          revert with 0, 
                                      32,
                                      55,
                                      0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                      Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[183 len 9])
                      if unknown6fcfff45[addr(_to)] <= 0:
                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                          unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                      else:
                          if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                              unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 += balanceOf[caller]
                          else:
                              unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                              unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                              unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                      log 0xdec2bacd: unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, _to
                  else:
                      if balanceOf[caller] < 0:
                          revert with 0, 'SafeMath: addition overflow'
                      if block.number >= 4294967296:
                          revert with 0, 
                                      32,
                                      55,
                                      0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                      Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[183 len 9])
                      if unknown6fcfff45[addr(_to)] <= 0:
                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                          unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                      else:
                          if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                              unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 = balanceOf[caller]
                          else:
                              unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                              unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                              unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                      log 0xdec2bacd: 0, balanceOf[caller], _to
          else:
              if unknown6fcfff45[stor24[caller]]:
                  if balanceOf[caller] > unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_256:
                      revert with 0, 'SafeMath: subtraction overflow'
                  if block.number >= 4294967296:
                      revert with 0, 
                                  32,
                                  55,
                                  0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                  Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[247 len 9])
                  if unknown6fcfff45[stor24[caller]] <= 0:
                      unknownf1127ed8[stor24[caller]][stor26[stor24[caller]]].field_0 = uint32(block.number)
                      unknownf1127ed8[stor24[caller]][stor26[stor24[caller]]].field_256 = unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_256 - balanceOf[caller]
                      unknown6fcfff45[stor24[caller]] = uint32(unknown6fcfff45[stor24[caller]] + 1)
                      log 0xdec2bacd: unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_256, unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_256 - balanceOf[caller], delegates[caller]
                      if _to:
                          if unknown6fcfff45[addr(_to)]:
                              if balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 < unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256:
                                  revert with 0, 'SafeMath: addition overflow'
                              if block.number >= 4294967296:
                                  revert with 0, 
                                              32,
                                              55,
                                              0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                              Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[407 len 9])
                              if unknown6fcfff45[addr(_to)] <= 0:
                                  unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                  unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                                  unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                              else:
                                  if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 += balanceOf[caller]
                                  else:
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                                      unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                              log 0xdec2bacd: unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, _to
                          else:
                              if balanceOf[caller] < 0:
                                  revert with 0, 'SafeMath: addition overflow'
                              if block.number >= 4294967296:
                                  revert with 0, 
                                              32,
                                              55,
                                              0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                              Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[407 len 9])
                              if unknown6fcfff45[addr(_to)] <= 0:
                                  unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                  unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                                  unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                              else:
                                  if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 = balanceOf[caller]
                                  else:
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                                      unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                              log 0xdec2bacd: 0, balanceOf[caller], _to
                  else:
                      if unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_0 == uint32(block.number):
                          unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_256 -= balanceOf[caller]
                          log 0xdec2bacd: unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_256, unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_256 - balanceOf[caller], delegates[caller]
                          if _to:
                              if unknown6fcfff45[addr(_to)]:
                                  if balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 < unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256:
                                      revert with 0, 'SafeMath: addition overflow'
                                  if block.number >= 4294967296:
                                      revert with 0, 
                                                  32,
                                                  55,
                                                  0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                                  Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[343 len 9])
                                  if unknown6fcfff45[addr(_to)] <= 0:
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                                      unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  else:
                                      if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 += balanceOf[caller]
                                      else:
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                                          unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  log 0xdec2bacd: unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, _to
                              else:
                                  if balanceOf[caller] < 0:
                                      revert with 0, 'SafeMath: addition overflow'
                                  if block.number >= 4294967296:
                                      revert with 0, 
                                                  32,
                                                  55,
                                                  0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                                  Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[343 len 9])
                                  if unknown6fcfff45[addr(_to)] <= 0:
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                                      unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  else:
                                      if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 = balanceOf[caller]
                                      else:
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                                          unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  log 0xdec2bacd: 0, balanceOf[caller], _to
                      else:
                          unknownf1127ed8[stor24[caller]][stor26[stor24[caller]]].field_0 = uint32(block.number)
                          unknownf1127ed8[stor24[caller]][stor26[stor24[caller]]].field_256 = unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_256 - balanceOf[caller]
                          unknown6fcfff45[stor24[caller]] = uint32(unknown6fcfff45[stor24[caller]] + 1)
                          log 0xdec2bacd: unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_256, unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_256 - balanceOf[caller], delegates[caller]
                          if _to:
                              if unknown6fcfff45[addr(_to)]:
                                  if balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 < unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256:
                                      revert with 0, 'SafeMath: addition overflow'
                                  if block.number >= 4294967296:
                                      revert with 0, 
                                                  32,
                                                  55,
                                                  0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                                  Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[407 len 9])
                                  if unknown6fcfff45[addr(_to)] <= 0:
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                                      unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  else:
                                      if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 += balanceOf[caller]
                                      else:
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                                          unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  log 0xdec2bacd: unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, _to
                              else:
                                  if balanceOf[caller] < 0:
                                      revert with 0, 'SafeMath: addition overflow'
                                  if block.number >= 4294967296:
                                      revert with 0, 
                                                  32,
                                                  55,
                                                  0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                                  Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[407 len 9])
                                  if unknown6fcfff45[addr(_to)] <= 0:
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                                      unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  else:
                                      if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 = balanceOf[caller]
                                      else:
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                                          unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  log 0xdec2bacd: 0, balanceOf[caller], _to
              else:
                  if balanceOf[caller] > 0:
                      revert with 0, 'SafeMath: subtraction overflow'
                  if block.number >= 4294967296:
                      revert with 0, 
                                  32,
                                  55,
                                  0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                  Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[247 len 9])
                  if unknown6fcfff45[stor24[caller]] <= 0:
                      unknownf1127ed8[stor24[caller]][stor26[stor24[caller]]].field_0 = uint32(block.number)
                      unknownf1127ed8[stor24[caller]][stor26[stor24[caller]]].field_256 = -balanceOf[caller]
                      unknown6fcfff45[stor24[caller]] = uint32(unknown6fcfff45[stor24[caller]] + 1)
                      log 0xdec2bacd: 0, -balanceOf[caller], delegates[caller]
                      if _to:
                          if unknown6fcfff45[addr(_to)]:
                              if balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 < unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256:
                                  revert with 0, 'SafeMath: addition overflow'
                              if block.number >= 4294967296:
                                  revert with 0, 
                                              32,
                                              55,
                                              0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                              Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[407 len 9])
                              if unknown6fcfff45[addr(_to)] <= 0:
                                  unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                  unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                                  unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                              else:
                                  if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 += balanceOf[caller]
                                  else:
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                                      unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                              log 0xdec2bacd: unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, _to
                          else:
                              if balanceOf[caller] < 0:
                                  revert with 0, 'SafeMath: addition overflow'
                              if block.number >= 4294967296:
                                  revert with 0, 
                                              32,
                                              55,
                                              0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                              Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[407 len 9])
                              if unknown6fcfff45[addr(_to)] <= 0:
                                  unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                  unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                                  unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                              else:
                                  if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 = balanceOf[caller]
                                  else:
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                                      unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                              log 0xdec2bacd: 0, balanceOf[caller], _to
                  else:
                      if unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_0 == uint32(block.number):
                          unknownf1127ed8[stor24[caller]][stor26[stor24[caller]] - 1 << 224].field_256 = -balanceOf[caller]
                          log 0xdec2bacd: 0, -balanceOf[caller], delegates[caller]
                          if _to:
                              if unknown6fcfff45[addr(_to)]:
                                  if balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 < unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256:
                                      revert with 0, 'SafeMath: addition overflow'
                                  if block.number >= 4294967296:
                                      revert with 0, 
                                                  32,
                                                  55,
                                                  0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                                  Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[343 len 9])
                                  if unknown6fcfff45[addr(_to)] <= 0:
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                                      unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  else:
                                      if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 += balanceOf[caller]
                                      else:
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                                          unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  log 0xdec2bacd: unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, _to
                              else:
                                  if balanceOf[caller] < 0:
                                      revert with 0, 'SafeMath: addition overflow'
                                  if block.number >= 4294967296:
                                      revert with 0, 
                                                  32,
                                                  55,
                                                  0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                                  Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[343 len 9])
                                  if unknown6fcfff45[addr(_to)] <= 0:
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                                      unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  else:
                                      if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 = balanceOf[caller]
                                      else:
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                                          unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  log 0xdec2bacd: 0, balanceOf[caller], _to
                      else:
                          unknownf1127ed8[stor24[caller]][stor26[stor24[caller]]].field_0 = uint32(block.number)
                          unknownf1127ed8[stor24[caller]][stor26[stor24[caller]]].field_256 = -balanceOf[caller]
                          unknown6fcfff45[stor24[caller]] = uint32(unknown6fcfff45[stor24[caller]] + 1)
                          log 0xdec2bacd: 0, -balanceOf[caller], delegates[caller]
                          if _to:
                              if unknown6fcfff45[addr(_to)]:
                                  if balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 < unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256:
                                      revert with 0, 'SafeMath: addition overflow'
                                  if block.number >= 4294967296:
                                      revert with 0, 
                                                  32,
                                                  55,
                                                  0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                                  Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[407 len 9])
                                  if unknown6fcfff45[addr(_to)] <= 0:
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                                      unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  else:
                                      if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 += balanceOf[caller]
                                      else:
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256
                                          unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  log 0xdec2bacd: unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, balanceOf[caller] + unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256, _to
                              else:
                                  if balanceOf[caller] < 0:
                                      revert with 0, 'SafeMath: addition overflow'
                                  if block.number >= 4294967296:
                                      revert with 0, 
                                                  32,
                                                  55,
                                                  0x645341544f5348493a3a5f7772697465436865636b706f696e743a20626c6f63,
                                                  Mask(184, 0, 0x6b206e756d626572206578636565647320333220626974, mem[407 len 9])
                                  if unknown6fcfff45[addr(_to)] <= 0:
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                      unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                                      unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  else:
                                      if unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_0 == uint32(block.number):
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)] - 1 << 224].field_256 = balanceOf[caller]
                                      else:
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_0 = uint32(block.number)
                                          unknownf1127ed8[addr(_to)][stor26[addr(_to)]].field_256 = balanceOf[caller]
                                          unknown6fcfff45[addr(_to)] = uint32(unknown6fcfff45[addr(_to)] + 1)
                                  log 0xdec2bacd: 0, balanceOf[caller], _to

