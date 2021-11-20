const axios = require('axios');

export async function getAllPengguna(){
    console.log('load here..?')
    const response = await axios.get('http://server.bnl.id:9990/api/v1/pengguna');
    console.log('Data?',response.data.data);
    return response.data.data;
}