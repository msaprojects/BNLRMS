const axios = require('axios');
var url = 'http://server.bnl.id:9990/api/v1/'
export async function getAllPengguna(){
    console.log('load here..?')
    const response = await axios.get(url+'pengguna');
    console.log('Data?',response.data.data);
    return response.data.data;
}