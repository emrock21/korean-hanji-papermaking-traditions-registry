// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract HanjiPapermakingRegistry {

    struct HanjiTradition {
        string paperType;           // jeonju hanji, andong hanji, window hanji, etc.
        string region;              // Jeonju, Andong, Wonju
        string materials;           // mulberry bark (dak), hollyhock mucilage
        string techniques;          // webal, ssangbal, pounding, sheet formation
        string functionalProperties;// durability, translucency, preservation quality
        string culturalContext;     // calligraphy, architecture, rituals, restoration
        string uniqueness;          // UNESCO status, regional identity, rare methods
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct HanjiInput {
        string paperType;
        string region;
        string materials;
        string techniques;
        string functionalProperties;
        string culturalContext;
        string uniqueness;
    }

    HanjiTradition[] public traditions;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event HanjiRecorded(uint256 indexed id, string paperType, address indexed creator);
    event HanjiVoted(uint256 indexed id, bool like, uint256 likes, uint256 dislikes);

    constructor() {
        traditions.push(
            HanjiTradition({
                paperType: "Example (replace manually)",
                region: "example",
                materials: "example",
                techniques: "example",
                functionalProperties: "example",
                culturalContext: "example",
                uniqueness: "example",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordHanji(HanjiInput calldata h) external {
        traditions.push(
            HanjiTradition({
                paperType: h.paperType,
                region: h.region,
                materials: h.materials,
                techniques: h.techniques,
                functionalProperties: h.functionalProperties,
                culturalContext: h.culturalContext,
                uniqueness: h.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit HanjiRecorded(traditions.length - 1, h.paperType, msg.sender);
    }

    function voteHanji(uint256 id, bool like) external {
        require(id < traditions.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;
        HanjiTradition storage h = traditions[id];

        if (like) h.likes++;
        else h.dislikes++;

        emit HanjiVoted(id, like, h.likes, h.dislikes);
    }

    function totalHanji() external view returns (uint256) {
        return traditions.length;
    }
}
