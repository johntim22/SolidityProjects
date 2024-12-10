var MyBank = artifacts. require( " ./MyBank.sol" ) ;

module . exports = function(deployer) {
	deployer.deploy(MyBank, { value: 30000000000000000000});
};