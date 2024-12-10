// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Agreement {
    address public partyA;
    address public partyB;
    string public terms;
    bool public partyASigned;
    bool public partyBSigned;

    event TermsDisplayed(string terms);
    event Signed(address signer);
    event AgreementFinalized();

    constructor(address _partyA, address _partyB, string memory _terms) {
        partyA = _partyA;
        partyB = _partyB;
        terms = _terms;

        // Emit the terms when the contract is deployed
        emit TermsDisplayed(terms);
    }

    modifier onlyParty() {
        require(msg.sender == partyA || msg.sender == partyB, "Not an authorized party");
        _;
    }

    function signAgreement() public onlyParty {
        if (msg.sender == partyA) {
            require(!partyASigned, "Party A already signed");
            partyASigned = true;
            emit Signed(msg.sender);
        } else if (msg.sender == partyB) {
            require(!partyBSigned, "Party B already signed");
            partyBSigned = true;
            emit Signed(msg.sender);
        }

        if (partyASigned && partyBSigned) {
            emit AgreementFinalized();
        }
    }

    function isAgreementFinalized() public view returns (bool) {
        return partyASigned && partyBSigned;
    }
}
