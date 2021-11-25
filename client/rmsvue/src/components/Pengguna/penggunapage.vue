<template>
    <div class="hello">
        <Header/>
        <div class="row mrgnbtm">
            <Pengguna v-if="pengguna.length > 0" :pengguna="pengguna"/>
        </div>
    </div>
</template>

<script>
import Header from '../Header/header.vue'
import Pengguna from './pengguna.vue'
import {getAllPengguna} from '../../utils/services/ApiService.js'
console.log('dashboard calling');
export default {
    name: 'Dashboard',
    components: {
        Header, Pengguna
    }, data(){
        return{
            pengguna:[]
        }
    },
    methods: {
        getAllPengguna(){
            getAllPengguna().then(response => {
            console.log(response)
            this.pengguna = response
            console.log(this.pengguna.nama, this.pengguna.jabatan, this.pengguna.username, this.pengguna.idpengguna);
        })}
    },
    mounted() {
        this.getAllPengguna()
    }
}
</script>