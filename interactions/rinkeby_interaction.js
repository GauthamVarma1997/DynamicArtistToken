require('dotenv').config()
const Web3 = require("web3");

// const webSocketProvider = new Web3.providers.WebsocketProvider(process.env.RINKEBY_WSS_URL);
const webSocketProvider = process.env.ETH_CLIENT_URL;
const HDWalletProvider = require('@truffle/hdwallet-provider');
const mnemonic = process.env.MNEMONIC;
const contractAddress = process.env.CONTRACT_ADDRESS
const accountAddress = process.env.MAIN_ACCOUNT
const provider = new HDWalletProvider({
    mnemonic,
    providerOrUrl: webSocketProvider,
    addressIndex: 0,
    numberOfAddresses: 3,
});
const web3 = new Web3(provider);

const contractArtifacts = require("../build/contracts/DynamicNFT.json");

const contractInstance = new web3.eth.Contract(contractArtifacts.abi, contractAddress)

const getCurrentTokenID = async () => {
    const response = await contractInstance.methods
        .currentTokenId().call();
    console.log(response);
};
// getCurrentTokenID();

const mintArtistToken = async () => {
    const response  = await contractInstance.methods
        .mintArtistToken().send({from : accountAddress});
    console.log(response);
};
// mintArtistToken();

const mintTokens = async (count) => {
    const response = await contractInstance.methods
        .mint_tokens(count).send({from : accountAddress});
    console.log(response);
}
mintTokens(100);

// const ownerOf = async (tokenId) => {
//     const response = await contractInstance.methods
//         .ownerOf(tokenId).call()
//     console.log(response)
// }
// ownerOf(1)


provider.engine.stop();