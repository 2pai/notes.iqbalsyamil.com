<template>
  <div class="about">
    <c-box :p="4" shadow="md" border-width="1px" mx="auto" w="80%">
      <c-heading as="h2" size="xl">About This Website</c-heading>
      <c-text fontSize="xl">
        <p>
        "Decentralization" was the one of the topic that have so much attention on tech landscape for the past 5 years, The rising of smart contract from ethereum and IPFS make the ecosystem of decentralization tech more mature. 
        Decentralization comes as an option, to remove for trusting 3rd party (i.e. GovT, broker, etc.), meaning that all of content that live in decentralize world is censorship resistant, trustless & secure.
        In 2021, we Saw lot of Designer & Artist mint their atwork onchain as an NFT (Non Fungible Token), making billion of $ comes into NFT world.
        </p>
        <p>
        This website is one of the implementation of multiple Decentralization tech stack, such as IPFS (To Store File) & Smart Contract (Ethereum). 
        Different with other blog, we use Smart Contract to store the metadata every single article and pegged into ERC721 Token. We also use IPFS to store the body content (Images, Text, etc.), making this blog live in decentralize world.
        
        </p>
      </c-text>
    </c-box>
  </div>
</template>

<script>
import { CBox, CHeading, CText } from '@chakra-ui/vue';

export default {
  name: 'About',
  components: {
    CBox,
    CHeading,
    CText
  }
}
</script>