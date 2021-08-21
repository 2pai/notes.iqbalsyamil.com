<template>
  <div class="home">
      <c-box :p="4" shadow="md" border-width="1px" mx="auto" w="80%">
          <c-text mx="40px" fontSize="xl" text-align="center"> 
            <c-grid
              h="250px"
              w="auto"
              template-rows="repeat(4, 1fr)"
              template-columns="repeat(5, 1fr)"
              gap="6"
              my="10px"
            >
              <c-grid-item row-span="3" col-span="1" >
                <c-image mx="10px" size="250px" src="https://bit.ly/chakra-sarah-drasner" alt="Sarah Drasner" />
              </c-grid-item>
              <c-grid-item row-span="1" col-span="4">
                <c-heading text-align="center">
                  Belajar Untuk Dibayar
                </c-heading>
              </c-grid-item>
              <c-grid-item row-span="2" col-span="4" >
                  <c-text fontSize="xl" text-align="left">
                    Tahun 2020 merupakan tahun yang cukup berat, bagi saya dan mungkin kita semua. Terlebih lagi hal-hal personal yang saya alami. Saya ingat di akhir tahun 2019 mencoba untuk menerbangkan mimpi-mimpi yang ingin saya capai dan berusaha menggapainya di tahun 2020. Tetapi apa boleh buat, terkadang apa yang sudah kita rencanakan tidak semua berjalan sebagaimana apa yang kita harapkan.
                  <c-link to="/" color="pink.500">Read More</c-link>
                  </c-text>
              </c-grid-item>
            </c-grid>
            
            <c-divider />

            <c-grid
              h="250px"
              w="auto"
              template-rows="repeat(3, 1fr)"
              template-columns="repeat(5, 1fr)"
              gap="6"
              my="10px"
            >
              <c-grid-item row-span="3" col-span="1" >
                <c-image mx="10px" size="250px" src="https://bit.ly/chakra-sarah-drasner" alt="Sarah Drasner" />
              </c-grid-item>
              <c-grid-item row-span="1" col-span="4">
                <c-heading text-align="center">
                  Belajar Untuk Dibayar
                </c-heading>
              </c-grid-item>
              <c-grid-item row-span="2" col-span="4" >
                  <c-text fontSize="xl" text-align="left">
                    Tahun 2020 merupakan tahun yang cukup berat, bagi saya dan mungkin kita semua. Terlebih lagi hal-hal personal yang saya alami. Saya ingat di akhir tahun 2019 mencoba untuk menerbangkan mimpi-mimpi yang ingin saya capai dan berusaha menggapainya di tahun 2020. Tetapi apa boleh buat, terkadang apa yang sudah kita rencanakan tidak semua berjalan sebagaimana apa yang kita harapkan.
                  <c-link to="/" color="pink.500">Read More</c-link>
                  </c-text>
              </c-grid-item>
            </c-grid>

          </c-text>
      </c-box>
      
  </div>
</template>

<script>
import { CDivider, CGrid, CGridItem, CHeading, CBox,CText } from '@chakra-ui/vue';
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
    CDivider,
    CGrid,
    CGridItem,
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
