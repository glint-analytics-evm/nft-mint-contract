import { task } from "hardhat/config";
import type { TaskArguments } from "hardhat/types";

task("deploy:GLNTToken").setAction(async function (_taskArguments: TaskArguments, { ethers }) {
  const signers = await ethers.getSigners();
  const factory = await ethers.getContractFactory("GLNTToken");
  const contract = await factory.connect(signers[0]).deploy();
  await contract.waitForDeployment();
  console.log("GLNTToken deployed to: ", await contract.getAddress());
});
