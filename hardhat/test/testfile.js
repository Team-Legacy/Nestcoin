const { ethers } = require("hardhat");
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

describe("NestCoin", function () {
  let contract;
  

  // quick fix to let gas reporter fetch data from gas station & coinmarketcap
  before((done) => {
    setTimeout(done, 2000);
    
  });

  describe("BulkSender", function () {
    it("Should deploy YourContract", async function () {
      const NestCoin = await ethers.getContractFactory("Nestcoin")
      nestToken = await NestCoin.deploy()
      const BulkSender = await ethers.getContractFactory("BulkSender")
      contract = await BulkSender.deploy(nestToken.address);
  
    });

    describe("Testing Authorizable functions functions ", function () {
      it("Only Owner can add admin", async function () {
        const [owner, admin2] = await ethers.getSigners();

        await contract.connect(owner).addAuthorized(admin2.address);
        expect(await contract.authorized(admin2.address)).to.equal(true);
      });

      it("Only Authorized Admins can add do Airdrops for different values ", async function () {
        const [owner, addr1] = await ethers.getSigners();
        await contract.connect(owner).addAdmin(addr1.address);
       await expect(contract.connect(addr1).AirdropDifferentValue(
          ["0xFE745cab1c32EA2672a5884ED978042EBEd42A68"], 
          ["5", "5"])).to.be.revertedWith("Not Authorized");
      });
    });
  });
});