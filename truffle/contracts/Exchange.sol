// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

import "./EcoCashToken.sol";
import "./OneMoneyToken.sol";
import "./InnBucksToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol"; 

contract Exchange is Ownable {
    EcoCashToken public ecoCashToken;
    OneMoneyToken public oneMoneyToken;
    InnBucksToken public innBucksToken;

    event Deposit(address indexed user, uint256 amount, string tokenType);
    event Transfer(address indexed sender, address indexed recipient, uint256 amount, string fromToken, string toToken);
    event Withdrawal(address indexed user, uint256 amount, string tokenType);

    constructor(
        address _ecoCashTokenAddress,
        address _oneMoneyTokenAddress,
        address _innBucksTokenAddress
    ) 
    Ownable(msg.sender) { // Call the Ownable constructor
        ecoCashToken = EcoCashToken(_ecoCashTokenAddress);
        oneMoneyToken = OneMoneyToken(_oneMoneyTokenAddress);
        innBucksToken = InnBucksToken(_innBucksTokenAddress);
    }

    // Deposit tokens into the contract
    function deposit(uint256 amount, string calldata tokenType) external {
        require(amount > 0, "Amount must be greater than zero");

        if (keccak256(bytes(tokenType)) == keccak256(bytes("ECO"))) {
            ecoCashToken.transferFrom(msg.sender, address(this), amount);
            emit Deposit(msg.sender, amount, "EcoCash");
        } else if (keccak256(bytes(tokenType)) == keccak256(bytes("ONE"))) {
            oneMoneyToken.transferFrom(msg.sender, address(this), amount);
            emit Deposit(msg.sender, amount, "OneMoney");
        } else if (keccak256(bytes(tokenType)) == keccak256(bytes("INN"))) {
            innBucksToken.transferFrom(msg.sender, address(this), amount);
            emit Deposit(msg.sender, amount, "InnBucks");
        } else {
            revert("Invalid token type");
        }
    }

    // Transfer tokens between accounts
    function transfer(address recipient, uint256 amount, string calldata fromToken, string calldata toToken) external {
        require(amount > 0, "Amount must be greater than zero");

        if (keccak256(bytes(fromToken)) == keccak256(bytes("ECO")) && keccak256(bytes(toToken)) == keccak256(bytes("ONE"))) {
            require(ecoCashToken.balanceOf(address(this)) >= amount, "Insufficient EcoCash balance");
            ecoCashToken.transferFrom(msg.sender, address(this), amount);
            oneMoneyToken.transfer(recipient, amount);
            emit Transfer(msg.sender, recipient, amount, "EcoCash", "OneMoney");
        } else if (keccak256(bytes(fromToken)) == keccak256(bytes("ONE")) && keccak256(bytes(toToken)) == keccak256(bytes("ECO"))) {
            require(oneMoneyToken.balanceOf(address(this)) >= amount, "Insufficient OneMoney balance");
            oneMoneyToken.transferFrom(msg.sender, address(this), amount);
            ecoCashToken.transfer(recipient, amount);
            emit Transfer(msg.sender, recipient, amount, "OneMoney", "EcoCash");
        } else if (keccak256(bytes(fromToken)) == keccak256(bytes("ECO")) && keccak256(bytes(toToken)) == keccak256(bytes("INN"))) {
            require(ecoCashToken.balanceOf(address(this)) >= amount, "Insufficient EcoCash balance");
            ecoCashToken.transferFrom(msg.sender, address(this), amount);
            innBucksToken.transfer(recipient, amount);
            emit Transfer(msg.sender, recipient, amount, "EcoCash", "InnBucks");
        } else if (keccak256(bytes(fromToken)) == keccak256(bytes("INN")) && keccak256(bytes(toToken)) == keccak256(bytes("ECO"))) {
            require(innBucksToken.balanceOf(address(this)) >= amount, "Insufficient InnBucks balance");
            innBucksToken.transferFrom(msg.sender, address(this), amount);
            ecoCashToken.transfer(recipient, amount);
            emit Transfer(msg.sender, recipient, amount, "InnBucks", "EcoCash");
        } else if (keccak256(bytes(fromToken)) == keccak256(bytes("ONE")) && keccak256(bytes(toToken)) == keccak256(bytes("INN"))) {
            require(oneMoneyToken.balanceOf(address(this)) >= amount, "Insufficient OneMoney balance");
            oneMoneyToken.transferFrom(msg.sender, address(this), amount);
            innBucksToken.transfer(recipient, amount);
            emit Transfer(msg.sender, recipient, amount, "OneMoney", "InnBucks");
        } else if (keccak256(bytes(fromToken)) == keccak256(bytes("INN")) && keccak256(bytes(toToken)) == keccak256(bytes("ONE"))) {
            require(innBucksToken.balanceOf(address(this)) >= amount, "Insufficient InnBucks balance");
            innBucksToken.transferFrom(msg.sender, address(this), amount);
            oneMoneyToken.transfer(recipient, amount);
            emit Transfer(msg.sender, recipient, amount, "InnBucks", "OneMoney");
        } else {
            revert("Invalid token type or transfer direction");
        }
    }

    // Withdraw tokens from the contract
    function withdraw(uint256 amount, string calldata tokenType) external {
        require(amount > 0, "Amount must be greater than zero");

        if (keccak256(bytes(tokenType)) == keccak256(bytes("ECO"))) {
            require(ecoCashToken.balanceOf(address(this)) >= amount, "Insufficient EcoCash balance");
            ecoCashToken.transfer(msg.sender, amount);
            emit Withdrawal(msg.sender, amount, "EcoCash");
        } else if (keccak256(bytes(tokenType)) == keccak256(bytes("ONE"))) {
            require(oneMoneyToken.balanceOf(address(this)) >= amount, "Insufficient OneMoney balance");
            oneMoneyToken.transfer(msg.sender, amount);
            emit Withdrawal(msg.sender, amount, "OneMoney");
        } else if (keccak256(bytes(tokenType)) == keccak256(bytes("INN"))) {
            require(innBucksToken.balanceOf(address(this)) >= amount, "Insufficient InnBucks balance");
            innBucksToken.transfer(msg.sender, amount);
            emit Withdrawal(msg.sender, amount, "InnBucks");
        } else {
            revert("Invalid token type");
        }
    }
}