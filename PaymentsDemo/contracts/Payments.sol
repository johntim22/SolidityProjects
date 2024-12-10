// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransferETHInInstallments {
    address public recipient;
    uint256 public totalAmount = 50 ether;  // Total amount to be transferred
    uint256 public installmentAmount = 16.6667 ether;  // Amount for each installment
    uint256 public numInstallments = 3;  // Total installments
    uint256 public installmentsMade = 0;  // Track how many installments have been made

    // Constructor to initialize the recipient
    constructor(address _recipient) {
        recipient = _recipient;
    }

    // Function to transfer ETH in installments
    function transferInstallments() public payable {
        require(installmentsMade < numInstallments, "All installments have already been transferred.");

        // Calculate the amount to transfer
        uint256 amountToTransfer = installmentAmount;

        // Ensure we are not transferring more than the remaining amount
        if (installmentsMade == numInstallments - 1) {
            amountToTransfer = totalAmount - (installmentsMade * installmentAmount);
        }

        // Perform the transfer
        payable(recipient).transfer(amountToTransfer);
        installmentsMade++;
    }

    // Helper function to check how many installments are left
    function installmentsRemaining() public view returns (uint256) {
        return numInstallments - installmentsMade;
    }
}
