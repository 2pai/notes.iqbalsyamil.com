    pragma solidity ^0.8.0;

    import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
    import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
    import "@openzeppelin/contracts/utils/Counters.sol";

    contract IqbalNotes is ERC721, ERC721URIStorage {
        using Counters for Counters.Counter;
        Counters.Counter private articleNumber;

        event NewArticlePublished(uint indexed _articleId, string indexed _slug, uint _timestamp, string _title);
        event PromoteNewBaseURI(string indexed _baseURI, uint timestamp);

        string public BASEURI;
        address public owner;
        constructor() ERC721("notes.iqbalsyamil.com", "IQBALNOTES") {
            // BASEURI = "https://github.com/2pai/support-me/item/"
            owner = msg.sender;
        }
        
        struct Article {
            string title;
            string slug;
            string body;
            string signature;
            uint timestamp;
        }

        mapping(uint => Article) Articles;

        modifier onlyOwner {
            require(msg.sender == owner, "This Method can only be called by owner");
            _;
        }
        /**
          @dev Read the metadata onchain
          @notice Use this function to get article metadata by inserting article id
          @return title Of the article
          @return slug of the article
          @return body that contain IPFS CID that store article
          @return signature that given proof that this article is minted by author
          @return timestamp The time that article was published & minted to blockhain
        */
        function article(uint _id) public view returns(string memory, string memory, string memory, string memory, uint timestamp){
            Article memory _article = Articles[_id];
            
            return (_article.title, _article.slug, _article.body, _article.signature, _article.timestamp);
        }

        /**
        
        */
        function insertArticle(uint _id, string memory _slug, string memory _title, string memory _body, string memory _signature) internal returns (bool) {
            Articles[_id].title = _title;
            Articles[_id].body = _body;
            Articles[_id].signature = _signature;
            Articles[_id].slug = _slug;
            Articles[_id].timestamp = block.timestamp;

            emit NewArticlePublished(_id, _slug, block.timestamp, _title);
            
            return true;
        }

        /**
            @notice Use this function to create new article and mint into ERC721 Token (NFT)
            @param title the title of article
            @param slug the slug of the article
            @param body IPFS CID that store article
            @param signature a signature of the author that can be verified by owner publickey 
            @return token id of ERC721 that represent the article
          */
        function writeNewArticle(string memory title, string memory slug, string memory body, string memory signature) external onlyOwner returns (uint256) {
            
            articleNumber.increment(); 
            uint256 newArticleNumber = articleNumber.current();
            
            require(insertArticle(newArticleNumber, slug, title, body, signature), "Failed write article to the blockchain");
            
            _mint(msg.sender, newArticleNumber); // Mint NFT Token of the article
            _setTokenURI(newArticleNumber, slug);

            return newArticleNumber;
        }

        /**
          @notice Change the contract BASEURI global variable
          @param newBaseURI the new URI that replace old BASEURI
          @return true if the changes happend
        */
        function promoteNewBaseURI(string memory newBaseURI) external onlyOwner returns(bool){
            BASEURI = newBaseURI;
            emit PromoteNewBaseURI(BASEURI, block.timestamp);
            return true;
        }

        function _baseURI() internal view override returns (string memory) {
            return BASEURI;
        }
        
        function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
            super._burn(tokenId);
        }
        
        function tokenURI(uint256 tokenId)
            public
            view
            override(ERC721, ERC721URIStorage)
            returns (string memory)
        {
            return super.tokenURI(tokenId);
        }

    }
