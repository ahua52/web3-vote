<script setup>
import useWeb3 from "@/hooks/useWeb3";
import { onMounted, ref } from "vue";
const voteInfo = ref({})
const currentAccount = ref("");

const { getAccount,voteContract } = useWeb3();

const getVoteInfo = async() => {
    voteInfo.value = await voteContract.methods.voters(currentAccount.value).call()
    console.log(1111,voteInfo.value)
}

const delegate = () => {
    voteContract.methods.delegate(delegatorAddress.value).send({from: currentAccount})
    .on('receipt',() => {
        console.log('委托成功')
    })
    console.log(1111,delegatorAddress)
}

const delegatorAddress = ref("")

onMounted ( async() => {
    currentAccount.value = await getAccount();
    
    getVoteInfo();
})
console.log(ref)
</script>

<template>
  <div class="box2">
    <van-divider>account info</van-divider>
    <van-space>
        <p class="label">current account</p>
        <p class="address">{{ currentAccount }}</p>
    </van-space>
    <van-space>
        <p class="label">the voting amount of an account</p>
        <p class="address">
            {{ voteInfo.amount }}
        </p>
    </van-space>
    <van-space>
        <p class="label">the delegator account</p>
        <p class="address">
            {{ voteInfo.delegator }}
        </p>
    </van-space>
    <van-space>
        <p class="label">Candidate id</p>
        <p class="address">
            {{ voteInfo.targetId }}
        </p>
    </van-space>
    <van-space>
        <p class="label">is Voted</p>
        <p class="address">
            {{ voteInfo.isVoted }}
        </p>
    </van-space>
    <br />
    <div class="btn">
        <van-cell-group inset>
            <van-field
                v-model="delegatorAddress"
                label="受委托人地址"
                placeholder="请输入受委托人地址"
                />
            <van-button block @click="delegate">
                委托他人代投
            </van-button>
        </van-cell-group>
    </div>
  </div>
</template>
