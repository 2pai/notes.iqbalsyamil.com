<template>
  <c-theme-provider>
    <c-stack :spacing="5">
    <c-box shadow="md" bg="pink.400" w="80%" p="4" mx="auto" color="white">
        <c-heading textAlign="center" fontSize="6xl">notes.iqbalsyamil.com</c-heading>
        <c-text textAlign="center">Personal Blog that run on the decentralize world (Smart Contract & IPFS)</c-text>
      </c-box>
      <c-box :p="4" shadow="md" border-width="1px" mx="auto" w="80%">
          <c-text fontSize="xl" text-align="center"> 
            <c-link as="router-link" to="/" mx="4">
                🏡 Home
            </c-link>
            <c-link as="router-link" to="/about" mx="4">
                🌕 About
            </c-link>
            <c-link as="router-link" to="/" mx="4">
                ✨ How To Support
            </c-link>
          </c-text>
      </c-box>
    <c-reset />
    <router-view />
    <c-box :p="4" shadow="md" border-width="1px" mx="auto" w="80%">
        <c-text fontSize="xl" text-align="center"> 
          &copy; Iqbal Syamil. 2021
        </c-text>
    </c-box>
    </c-stack>
  </c-theme-provider>
</template>

<script>
import { CStack, CHeading, CBox, CText } from '@chakra-ui/vue';

export default {
  name: 'App',
  components:{
    CBox,
    CText,
    CHeading,
    CStack
  },
}

</script>
