// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contracts Create{
    using Counters for Counters.Counters;

    Counters.Counters public _voterId;
    Counters.Counters public _candidateId;

    address public votingOrganizer;

    //CANDIDATE FOR VOTING

    struct Candidate {
        uint256 candidateId;
        string age;
        string name;
        string image;
        uint256 voteCount;
        address _address;
        string ipfs;
    }

    event CandidateCreate(
        uint256 indexed candidateId,
        string age,
        string name,
        string image;
        uint256 voteCount,
        address _address,
        string ipfs
    );

    address[] public candidateAddrss;

    mapping (address=>Candidate) public candidates;


    //--------Voter Data

    address[] public votdrVoters;
    address[] public voterAddress;
    mapping(address=>Voter) public voters;

    struct Voter{
        uint256 voter_voterId;
        string voter_name;
        address voter_address;
        uint256 voter_allowed;
        bool voter_voted;
        uint256 voter_vote;
        string voter_ipfs;

    }

    event VoterCreated(
        uint256 indexed voter_voterId;
        string voter_name;
        address voter_address;
        uint256 voter_allowed;
        bool voter_voted;
        uint256 voter_vote;
        string voter_ipfs;

    );

    constructor(){
        votingOrganizer = msg.sender;
    }

    function setCandidate(address _address,string memory _age,string memory _name,string memory _image,string memory _ipfs)public {
        require(votingOrganizer == msg.sender,"Only organizer can set candiate");
        uint256 idNumber = _candidateId.current();
        _candidateId.increment();
        Candidate storage candidate = candidates[_address];
        candidate.age  = _age;
        candidate.name = _name;
        candidate.candidateId = idNumber;
        candidate.image = _image;
        candidate.voteCount = 0;
        candidate._address = _address;
        candidate.ifps = _ipfs;

        candidateAddrss.push(_address);

        emit CandidateCreate(
            idNumber,
            _age,
            _name,
            candidate.voteCount,
            _address,
            _ipfs,

        );

        
    }


    function getCandidate()public view returns(address[] memory){
        returns candidateAddrss;
    }

    

    function getCandidatedata(address _address)public view returns(string memory,string memory,uint256,string memory,uint256 ,string memory,address){
        return(
            candidate[_address].age,
            candidate[_address].name,
            candidate[_address].candidateId,
            candidate[_address].image,
            candidate[_address].voteCount,
            candidate[_address].ipfs,
            candidate[_address]._address,

        )

    }

    function getCandidateLength()public view returns(uint256){
        returns candidateAddrss.length;
    }

    //----VOTER section


    function voterRight(address _address,string memory _name,string memory _image,string memory _ipfs) public {
        require(votingOrganizer == msg.sender,"Only organizer can create voter");
        _voterId.increment();

        uint256 idNumber = _voterId.current();
        Voter storage voter  =  voters[_address];
        require(voter.voter_allowed == 0);
        voter.voter_allowed = 1;
        voter.voter_name = _name;
        voter.voter_iamge = _image;
        voter.voter_address = _address;
        voter.voter_voterId = idNumber;
        voter.voter_vote = 1000;
        voter.voter_voted = false;
        voter.voter_ipfs = _ipfs;

        voterAddress.push(_address);

        emit VoterCreated(
            idNumber,
            _name,
            _address,
            voter.voter_allowed,
            voter.voter_voted,
            voter.voter_vote,
            _ipfs



        );
        

    }

    function vote(address _candidateAddress,uint256 _candidateVoteId) external {
        Voter storage voter = voters[msg.sender];
        require(!voter.voter_voted,"You have already voted");
        require(voter.voter_allowed != 0,"You have no right to vote");
        voter.voter_voted = true;
        voter.voter_vote = _candidateVoteId;
        votdrVoters.push(msg.sender);
        candidate[_candidateAddress].voteCount += voter.voter_allowed;
    }

    function getVoterLength()public view return(uint256){
        return voterAddress.length;
    }

    function getVoterdata(address _address) public view returns(uint256,string memory,string memory,address,string memory,uint256,bool){
        return(
            voters[_address].voter_voterId,
            voters[_address].voter_name,
            voters[_address].voter_image,
            voters[_address].voter_address,
            voters[_address].voter_ipfs,
            voters[_address].voter_allowed,
            voters[_address].voter_voted,
        )

    
    }

    function getVotedVoterList() public view returns (address[] memory){
        return votdrVoters;
    }


    function getVoterList()public view returns(address[] memory){
        return voterAddress;

    }



    

    

    


}