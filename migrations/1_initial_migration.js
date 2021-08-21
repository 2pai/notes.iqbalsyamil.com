const NFT = artifacts.require("IqbalNotes");

module.exports = function (deployer) {
  deployer.deploy(NFT);
};
