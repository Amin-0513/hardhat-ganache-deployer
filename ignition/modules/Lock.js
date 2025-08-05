const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("StudentModule", (m) => {
  const studentContract = m.contract("Solidity", []);

  return { studentContract };
});
