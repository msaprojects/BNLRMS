<template lang="">
    <div class='login'>
        <input type='text' v-model="username" placeholder="Username"/>
        <input type='password' v-model="password" placeholder="Password"/>
        <button v-on:click='LoginClick'>Login</button>
    </div>
</template>
<script>
export default {
    name: "Login",
    data(){
        return{
            username:'',
            password: ''
        }
    },
    methods:{
        LoginClick(){
            console.log(this.username, this.password)
        }
    }    
}
</script>
