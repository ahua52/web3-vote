import Web3 from "web3";
import VoteJSON from "../contract/vote.json";

const useWeb3 = () => {
    const sepolian = "wss://sepolia.infura.io/ws/v3/3b0717db7b8e444db66f87431232170b";
    var web3 = new Web3(Web3.givenProvider || sepolian);
    const contractAddress = "0x7E8D73bcDC9d0D7594D58378B6426E43437E22DD";
    const voteContract = new web3.eth.Contract(VoteJSON.abi, contractAddress);
    const getAccount = async() => {
        console.log(2222);
        const accounts = await web3.eth.requestAccounts();
        return accounts[0]
    }
    
    return {
        web3,
        voteContract,
        contractAddress,
        getAccount
    }
}

export default useWeb3;