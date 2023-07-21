// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract GoTransferTBNB {

    address public executiveManagingDirector; 
    address public escrow;
    address public tax;
 

//============={Events}====================================
    
    event Withdrawn(address token, address indexed client, uint256 amount, uint date);
    event ClientSentToken( address token, address indexed client, address indexed receiver, address indexed escrow, uint amount, uint date );
    event ClientPaidFees( address token, address indexed dexAddress, address indexed escrow, uint dexShare, uint date );
    
    event TransferSucesseful (address token, address indexed client, address indexed receiver, uint amount, uint date);


//============={bool}=====================================

    bool public clientSentCrypto; 
    bool public clientPaidFees;

//============={balances mapping}=====================================  
    mapping(address => mapping(address => uint256)) public accountBalances;
    mapping(address => mapping(address => uint256)) public _deposits;
    mapping(address => mapping(address => uint256)) public _withdrawals;


    constructor () {
        executiveManagingDirector = msg.sender; 
        clientSentCrypto = false;  
        clientPaidFees = false;
        escrow = address(this);
    }

    //======================={add new tokens to the acceptible tokens list}=================================
    function whitelistToken(address token) public view returns (address) {
        require(msg.sender ==  executiveManagingDirector, 'This function is not public');

        return(token);
    }


    function changeED (address _newExecutiveManagingDirector) public returns (address) {
        require(msg.sender == executiveManagingDirector);
        executiveManagingDirector = _newExecutiveManagingDirector;
        return executiveManagingDirector;
    }


//=========================={                          }=============================================
//=========================={   Transfer Any Token     }=============================================
//=========================={                          }=============================================

    receive() external payable {} // Receive sent tokens or deposits


//=============================={Dex Operations with Service Fees}==============================================================================
    function dexDepositToken(address token, uint256 amount) public {
        accountBalances[msg.sender][token] += amount;
        ERC20(token).transferFrom(msg.sender, address(this), amount);
    }

    function dexWithdrawToken(address token, uint256 amount, uint dexShare, address dexAddress) public payable {

        require(accountBalances[msg.sender][token] >= amount, 'Insufficent funds');

        require(msg.value >= dexShare, 'Insufficent funds');
       
        accountBalances[msg.sender][token] -= amount;
        payable(dexAddress).transfer(dexShare); // from conneted wallet andnot from the user's token as service Fee
        ERC20(token).transfer(msg.sender, amount); // alternatively
    }

   function dexSendToken(address token, uint256 amount, address receiver, uint dexShare, address dexAddress) public payable {
    
    require(accountBalances[msg.sender][token] >= amount, 'Insufficent funds');
    require(msg.value >= dexShare, 'Insufficent funds');

    accountBalances[msg.sender][token] -= amount;
    payable(dexAddress).transfer(dexShare); // from conneted wallet of the user as a service Fee for the transaction
    ERC20(token).transfer(receiver, amount);

  }

    function dexDepositAndSendTokens(address token, uint amount,  address receiver, uint dexShare, address dexAddress) public payable {

        address client = msg.sender;
    
        //======================={Deposit token }========================================
        dexDepositToken(token, amount); // send payment to escrow contract

        //======================={Transfer token }========================================
        dexSendToken(token, amount, receiver, dexShare, dexAddress);  // pay receiver //1000
       
   
        clientSentCrypto = true;   
        clientPaidFees = true;
    
       
        emit ClientSentToken( token, client, receiver, escrow, amount, block.timestamp);
        emit ClientPaidFees( token, dexAddress, escrow, dexShare, block.timestamp);
        emit TransferSucesseful (token, client, receiver, amount, block.timestamp);

    }

//======{Get Contract balance}=============================

    function getBalanceByClient(address token) public view returns( uint ) {
        return accountBalances[msg.sender][token];
    }

    function getAnyBalance(address token, address client) public view returns( uint ) {
        return accountBalances[client][token];
    }

    function getContractBalance(address token) public view returns( uint ) {
        return accountBalances[escrow][token];
    }

}