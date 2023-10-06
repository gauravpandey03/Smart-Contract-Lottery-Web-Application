// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Lottery {
    address public manager;
    address payable[] public participants ;

    constructor(){
        manager =msg.sender;// global variable   tranfering to manager
      //  when we complie this them manager will have address of current address . 
    }

    receive() external  payable {

        require(msg.value==1 ether);
         participants.push(payable (msg.sender)); // receiving ether from participant to contract 
    } 


   function getbalance() public view returns(uint){
       require(msg.sender==manager);// when we complie this them manager will have address of current address . 
       return address (this).balance;//get the balance of contract 
   }

  function random() public view returns(uint){
     return  uint (keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));

      //participation array ki length ko return karega..
  }
    function winner () public{
        require(msg.sender==manager);
        require(participants.length>=3);
        uint  r =random();
        address payable winner;
        uint index = r % participants.length;
        winner=participants[index];
       // return winner;

       winner.transfer(getbalance());
         participants = new address payable [](0);
    }

  

}


