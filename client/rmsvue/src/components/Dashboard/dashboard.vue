<template>
    <div class="hello">
        <Header/>
        <!-- <div class="row mrgnbtm">
            <Pengguna v-if="pengguna.length > 0" : pengguna="pengguna"/>
        </div> -->
    </div>
</template>

<script>
import Header from '../Header/header.vue'
import Pengguna from '../Pengguna/pengguna.vue'
import {getAllPengguna} from '../../utils/services/penggunaService'
export default {
    name: 'Dashboard',
    component: {
        Header, Pengguna
    }, data(){
        return{
            pengguna:[]
        }
    },
    methods: {
        getAllPengguna(){getAllPengguna().then(response => {
            console.log(response)
            this.pengguna = response['data']
        })}
    },mounted() {
        this.getAllPengguna()
    },
}
</script>