<template>
  <div class="home">
    <c-stack :spacing="5">
      <c-box shadow="md" bg="pink.400" w="80%" p="4" mx="auto" color="white">
        <c-heading textAlign="center" fontSize="6xl">Mint Your Support2Pai NFT</c-heading>
        <c-text textAlign="center" >Donate your MATIC token to mint NFT Token</c-text>
      </c-box>
      <c-box :p="4" shadow="md" border-width="1px" mx="auto" w="80%">
        <c-button variant-color="orange" v-show="!walletEnabled" v-on:click="enableWallet" variant="solid" mx="auto">
          💳 Connect Wallet
        </c-button>
        <c-box bg="indigo.500" v-show="walletEnabled" w="100%" p="4" color="white" mx="auto">
          <c-heading fontSize="3xl"> ✨ Welcome, {{ account }} </c-heading>
          <c-text fontSize="2xl">Total Balance = {{ balance }} {{this.$currency}}</c-text>
          <c-divider />
          <c-text fontSize="xl" text-align="center">Mint Your NFT Here</c-text>
          <c-button-group w="600px" :spacing="4" mx="auto">
            <c-button v-on:click="executeContract(1,1000)" :is-loading="isWaiting[1]" variant="solid" size="lg" variant-color="vue">1 {{this.$currency}}</c-button>
            <c-button v-on:click="executeContract(2,100)" :is-loading="isWaiting[2]" variant="solid" size="lg" variant-color="orange">0.01 {{this.$currency}}</c-button>
            <c-button v-on:click="executeContract(3,1)" :is-loading="isWaiting[3]" variant="solid" size="lg" variant-color="pink"> 0.001 {{this.$currency}}</c-button>
            <c-button variant="solid" size="lg" variant-color="pink" v-on:click="loadNftUser"> Load nft</c-button>
          </c-button-group>
        </c-box>
      </c-box>

    </c-stack>
      
  </div>
</template>

<script>
import { CHeading, CStack, CBox,CText,CButton } from '@chakra-ui/vue';
import Support2Pai from '../abi/IqbalNotes.json'
import Web3 from 'web3';
export default {
  name: 'Home',
  data(){
    return{
      walletEnabled:false,
      account:'',
      balance:0,
      isWaiting:{
        1:false,
        2:false,
        3:false
      }
    }
  },
  components:{
    CBox,
    CText,
    CButton,
    CStack,
    CHeading
  },
  methods:{
    async loadNftUser(){
      const contract = window.Support2PaiContract
      let tx;
        try {
          tx = await contract.methods.balanceOf(this.account).call()
        } catch (error) {
          this.$toast({
            title: 'Error.',
            description: `${error.message}`,
            status: 'error',
            duration: 10000
          })
        }
        alert(tx)
    },
    async executeContract(comp,amount){
      let tx;
      this.isWaiting[comp] = true
      const contract = window.Support2PaiContract
      const weiValue = Web3.utils.toWei(Web3.utils.toBN(amount),'milli');
      try {
        tx = await contract.methods.mintKyud().send({from: this.account, value: weiValue})
      } catch (error) {
        this.$toast({
          title: 'Error.',
          description: `${error.message}`,
          status: 'error',
          duration: 10000
        })
      }
      if(tx){
        const tokenId = tx.events.Transfer.returnValues.tokenId
        tx = tx.transactionHash
        this.$toast({
          title: 'Congratulations.',
          description: `Your NFTs is Minted with TokenId = ${tokenId} on ${tx}`,
          status: 'success',
          duration: 10000
        })
      }
      this.isWaiting[comp] = false
    },
    enableWallet(){
      if(window.ethereum.enable()){
        this.walletEnabled = true
      }
      window.web3.eth.getAccounts((err,acc) => {
      if (err != null || acc.length === 0) {
          return;
      }
      this.account = acc[0];
      window.web3.eth.getBalance(this.account,(err,bal) => {
        
          this.balance = window.web3.utils.fromWei(bal, 'ether');
      })
    })
      

    }
  },
  mounted: function () {
    
    if(window.ethereum){      
      window.web3 = new Web3(window.ethereum);
      window.Support2PaiContract = new window.web3.eth.Contract(Support2Pai.abi,"0xA94B7f0465E98609391C623d0560C5720a3f2D33")
      
      window.ethereum.on('accountsChanged', function (accounts) {
        this.account = accounts[0]
      })

    }else{
        this.$toast({
          title: 'Error.',
          description: `Please Install Metamask on your Browser`,
          status: 'error',
          duration: 10000
        })
    }

  }
}

</script>
