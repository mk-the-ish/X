// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract EcoCashToken is ERC20, Ownable {
  constructor() ERC20("EcoCash", "ECO") Ownable(msg.sender) { 
        _mint(msg.sender, 1000000 * 10 **18); 
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) external onlyOwner {
        _burn(msg.sender, amount);
    }
}
