// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin";


contract DioPokemon is ERC721{

    struct Pokemon{
        string name;
        uint level;
        string img;
    }
    Pokemon [] public pokemons;
    address public gameOwner;

    constructor () ERC721 ("DioPokemon","PKD"){
        gameOwner == msg.sender;
    }

    modifier onlyOwnerOf(uint _monsterId){
        require(ownerOf(_monsterId) == msg.sender, "Apenas o dono pode batalhar com esse pokemon");
        _;
    }

    function  battle (uint _attackingPokemon, uint _defendingPokemon) public  onlyOwnerOf(_attackingPokemon){
        Pokemon storage attacker = pokemons[_attackingPokemon];
        Pokemon storage defender = pokemons[_defendingPokemon];

        if(attacker.level >= defender.level){
            attacker.level += 2;
            defender.level +=2;

        }else{
            attacker.level +=1;
            defender.level +=2;
        }
    }

    function createNewPokemon (string memory _name, address _to, string memory _img) public{
        require(msg.sender ==gameOwner, "Apenas o dono do jogo pode criar novos pokemons");
        uint id = pokemons.length;
        pokemons.push(Pokemon(_name, 1, _img));
        _safeMint(_to, id);

    }
    
}