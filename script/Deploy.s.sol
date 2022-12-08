// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Script.sol";
import "../src/OnChainBears.sol";

contract DeployScript is Script {
    using stdJson for string;

    OnChainBears public ocb;

    struct TraitData {
        string pixels;
        string name;
        string value;
    }

    string[6] public files = [
        "hats",
        "eyes",
        "noses",
        "mouths",
        "furs",
        "backgrounds"
    ];

    uint256[6] public counts = [
        16, 15, 3, 12, 10, 11
    ];

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        ocb = new OnChainBears();
        addHats();
        addEyes();
        addNoses();
        addMouths();
        addFurs();
        addBackgrounds();
        vm.stopBroadcast();
    }

    function addHats() public {
        string memory json = vm.readFile('./traits/hats.json');
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits = new OnChainBears.Trait[](16);

        for (uint256 id = 0; id < 16; id++) {
            data = json.parseRaw(string(abi.encodePacked(
                ".[", vm.toString(id), "]"
            )));
            
            traitData = abi.decode(data, (TraitData));
            
            traits[id] = OnChainBears.Trait(
                traitData.name,
                traitData.value,
                traitData.pixels
            );
        }

        ocb.addTraits(0, traits);
    }

    function addEyes() public {
        string memory json = vm.readFile('./traits/eyes.json');
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits = new OnChainBears.Trait[](15);

        for (uint256 id = 0; id < 15; id++) {
            data = json.parseRaw(string(abi.encodePacked(
                ".[", vm.toString(id), "]"
            )));
            
            traitData = abi.decode(data, (TraitData));
            
            traits[id] = OnChainBears.Trait(
                traitData.name,
                traitData.value,
                traitData.pixels
            );
        }

        ocb.addTraits(1, traits);
    }

    function addNoses() public {
        string memory json = vm.readFile('./traits/noses.json');
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits = new OnChainBears.Trait[](3);

        for (uint256 id = 0; id < 3; id++) {
            data = json.parseRaw(string(abi.encodePacked(
                ".[", vm.toString(id), "]"
            )));
            
            traitData = abi.decode(data, (TraitData));
            
            traits[id] = OnChainBears.Trait(
                traitData.name,
                traitData.value,
                traitData.pixels
            );
        }

        ocb.addTraits(2, traits);
    }

    function addMouths() public {
        string memory json = vm.readFile('./traits/mouths.json');
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits = new OnChainBears.Trait[](12);

        for (uint256 id = 0; id < 12; id++) {
            data = json.parseRaw(string(abi.encodePacked(
                ".[", vm.toString(id), "]"
            )));
            
            traitData = abi.decode(data, (TraitData));
            
            traits[id] = OnChainBears.Trait(
                traitData.name,
                traitData.value,
                traitData.pixels
            );
        }

        ocb.addTraits(3, traits);
    }

    function addFurs() public {
        string memory json = vm.readFile('./traits/furs.json');
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits = new OnChainBears.Trait[](10);

        for (uint256 id = 0; id < 10; id++) {
            data = json.parseRaw(string(abi.encodePacked(
                ".[", vm.toString(id), "]"
            )));
            
            traitData = abi.decode(data, (TraitData));
            
            traits[id] = OnChainBears.Trait(
                traitData.name,
                traitData.value,
                traitData.pixels
            );
        }

        ocb.addTraits(4, traits);
    }

    function addBackgrounds() public {
        string memory json = vm.readFile('./traits/backgrounds.json');
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits = new OnChainBears.Trait[](11);

        for (uint256 id = 0; id < 11; id++) {
            data = json.parseRaw(string(abi.encodePacked(
                ".[", vm.toString(id), "]"
            )));
            
            traitData = abi.decode(data, (TraitData));
            
            traits[id] = OnChainBears.Trait(
                traitData.name,
                traitData.value,
                traitData.pixels
            );
        }

        ocb.addTraits(5, traits);
    }

}
