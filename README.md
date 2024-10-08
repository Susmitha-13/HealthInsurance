﻿# HealthInsurance
### Steps to Deploy and Interact with the HealthCare Contract

1. Setup the Contract Code:
   - Copy and paste the contract code into [Remix Ethereum IDE](https://remix.ethereum.org/).

2. Setup Local Blockchain:
   - Run an instance of `ganache-cli` on your local machine.
   - Connect your MetaMask wallet to Ganache.

3. Configure MetaMask Accounts:
   - Import the first 3 accounts from Ganache to MetaMask using their private keys.
   - Assign the following names to the accounts:
     - Account 1: Hospital admin
     - Account 2: Lab admin
     - Account 3: Patient

4. Deploy the Contract:
   - In Remix, pass the Lab Admin's address (Account 2) as an argument in the constructor while deploying the contract.
   - Select Injected Web3 in the Environment field and ensure your MetaMask wallet is unlocked. This connects Remix to the first account (Hospital admin) in MetaMask.
   - Deploy the contract.

5. Create a Medical Record:
   - Switch to Account 3 (Patient) in MetaMask.
   - Call the `newRecord` function in Remix with the respective fields to create a new medical record.
   - Verify the record creation and details by calling the `_records` mapping with index `1`.

6. Sign the Medical Record:
   - Switch back to Account 1 (Hospital admin) in MetaMask.
   - Enter the record's `_ID` in the `signRecord` function and click on transact.
   - Repeat the same steps using Account 2 (Lab admin) in MetaMask.
   - Verify the record is approved by checking the `_records` mapping again to see the incremented `signatureCount`.

### Important Notes:
- Only Authorized Accounts: 
  - Only the Hospital admin and Lab admin can sign records.
  - The same account cannot sign a record twice.
  - The Patient account cannot sign the record.

By following these steps, you ensure the secure and authorized creation and signing of medical records on your local Ethereum blockchain.
