var HealthCare = artifacts.require("./HealthCare.sol");
const TO_LAB_ADMIN_ADDRESS = "0x8b6d682c0f892ed2d83ea70a15e1aaac35f009f0"; // hard coded address from Ganache

module.exports = function(deployer) {
  deployer.deploy(HealthCare, TO_LAB_ADMIN_ADDRESS);
};