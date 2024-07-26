<script setup>
import { ref,onMounted } from "vue";
import useWeb3 from "../hooks/useWeb3";

const { voteContract,getAccount } = useWeb3();
const currentAccount = ref("");
const boardList = ref([]);

const getBoardInfo = async() => {
    const result = await voteContract.methods.getBoardInfo().call();
    boardList.value = result
}

const vote = (i) => {
    try{
         voteContract.methods.vote(i).send({from: currentAccount.value})
    }catch(err) {
        console.log(err)
    }
   
}

const initEventListen = () => {
    voteContract.events.voteSuccess({fromBlock: 0},(err, event) => {
        console.log("监听执行...")
        console.log(event);
    }).on('data',(event) => {
        console.log("the event trigged by smart contract", event);
    })
}
onMounted(async() => {
    currentAccount.value = await getAccount()
    getBoardInfo()
    initEventListen

})
</script>

<template>
  <div class="box3">
    <van-divider>voting board</van-divider>
    <van-cell :title="b.name"  :key="i+b.name" icon="shop-o" v-for="(b,i) in boardList">
        <template #right-icon>
            <van-button @click="vote(i)">{{ b.totalAmount}}</van-button>
        </template>
    </van-cell>
  </div>
</template>
