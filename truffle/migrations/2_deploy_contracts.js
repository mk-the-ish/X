const EcoCashToken = artifacts.require("EcoCashToken");
const OneMoneyToken = artifacts.require("OneMoneyToken");
const InnBucksToken = artifacts.require("InnBucksToken");
const Exchange = artifacts.require("Exchange");

module.exports = async function (deployer) {
    // Deploy the token contracts
    await deployer.deploy(EcoCashToken);
    const ecoCashToken = await EcoCashToken.deployed();

    await deployer.deploy(OneMoneyToken);
    const oneMoneyToken = await OneMoneyToken.deployed();

    await deployer.deploy(InnBucksToken);
    const innBucksToken = await InnBucksToken.deployed();

    // Deploy the Exchange contract with the addresses of the token contracts
    await deployer.deploy(Exchange, ecoCashToken.address, oneMoneyToken.address, innBucksToken.address);
};