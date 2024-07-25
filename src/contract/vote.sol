// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Vote {
    // build voter struct
    struct Voter {
        uint256 amount; // number of votes
        bool isVoted;  
        address delegator;
        uint256 targetId;
    }

    // voting board
    struct Board {
        string name;  //target name
        uint256 totalAmount; // the number of voting target
    }

    //holder info
    address public host;

    //build voter collection
    mapping(address => Voter) public voters;

    //topic collection
    Board[] public board;

    constructor(string[] memory nameList) {
        host = msg.sender;
        voters[host].amount = 1;

        for(uint256 i=0; i< nameList.length; i++) {
            Board memory boardItem = Board(nameList[i],0);
            board.push(boardItem);
        }

    }

    //  return board collection
    function getAddres0() public pure returns(address) {
        return address(0);
    }
    //  return board collection
    function getBoardInfo() public view returns(Board[] memory) {
        return board;
    }

    //mandating voting on some addresses
    function mandate(address[] calldata addressList) public {
        // only host can access this function
        require(host == msg.sender, "Only the owner has permission");
        for (uint256 i=0; i< addressList.length; i++) {
            if(!voters[addressList[i]].isVoted) {
                voters[addressList[i]].amount = 1;
            }
        }
    }

    //Delegate the right to vote
    function delegate(address to) public {
        // get the address of delegator
        Voter storage sender = voters[msg.sender];

        // cannot delegate to others if delegator has voted
        require(!sender.isVoted, "you already voted");
        require(msg.sender != to, "you cannot delegate youself");
        address _to = to;
        //Avoid circular delegation
        while(voters[_to].delegator != address(0)) {
            _to = voters[_to].delegator;
            require(_to != msg.sender, "cannot circular delegation" ); //待验证
        }
        // sender.isVoted = true;
        sender.delegator = to;
        

        //代理人数据的修改
        Voter storage delegator_ = voters[to];
        if(delegator_.isVoted) {
            //追票
            board[delegator_.targetId].totalAmount += sender.amount;
        } else {
            delegator_.amount += sender.amount;
        }
        sender.amount = 0;
    }

    // voting
    function vote(uint targetId) public {
        Voter storage sender = voters[msg.sender];
        require(sender.amount != 0, "Has no right to vote.");
        require(!sender.isVoted, "Already voted.");
        sender.isVoted = true;
        sender.targetId = targetId;
        board[targetId].totalAmount += sender.amount;
        sender.amount = 0;
        emit voteSuccess("voting success");

    }
    event voteSuccess(string);

}

/*

nameList: ["Joe",'Donand','Halis','Obama']

host 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", 
"0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
"0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB",
"0x617F2E2fD72FD9D5503197092aC168c91465E7f2",
"0x17F6AD8Ef982297579C203069C1DbfFE4348c372",
"0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678"]
*/