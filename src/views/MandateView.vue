<script setup>
import { ref,onMounted } from "vue";
import { showNotify } from "vant";
import useWeb3 from "../hooks/useWeb3";

const votorAddress = ref("")
const host = ref("")
const { web3, voteContract, getAccount } = useWeb3();

const mandate = async() => {
    console.log("mandate");
    const arr = eval(votorAddress.value);
    const currentAccount = await getAccount();
    voteContract.methods.mandate(arr).send({from:currentAccount})
    .on('receipt',() => {
        showNotify({ type: 'success', message: '选票分发成功' });
    });

}
const getHost = async() => {
    console.log(111);
    host.value = await voteContract.methods.host().call();
}

onMounted( () => {
    getHost();
})
/*

0xBAe081093F0Ae799435c893fC556af135945E13D
["0x35c9947E9e68f14804B7bB689dcF947F0E26159D",
"0x3a167f5b312b285Bc890D0B4eCBEBD52Dc74D219",
"0x00002443084B43065D10efFaa267c2161f5822Bc"]

*/
console.log(1111, web3,voteContract)
</script>

<template>
  <div class="box1">
    <van-divider>分发票权</van-divider>
    <div class="host">
        <van-space>
            <p class="label"><van-icon name="manager" />主持人地址</p>
            <p class="address">
                {{host}}
            </p>
        </van-space>
    </div>
    <div>
        <van-space>
            <p class="label"><van-icon name="friends-o" />投票人地址</p>
            <textarea class="votors" v-model="votorAddress"></textarea>
        </van-space>
    </div>
    <div class="btn">
        <van-button block @click="mandate">开始分发选票</van-button>
    </div>
  </div>
</template>
