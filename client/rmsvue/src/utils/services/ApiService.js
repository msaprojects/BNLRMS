const axios = require('axios');
var url = 'http://server.bnl.id:9990/api/v1/'
export async function getAllPengguna() {
    console.log('load here..?')
    const response = await axios.get(url + 'pengguna');
    console.log('Data?', response.data.data);
    return response.data.data;
}
class ApiService {
    login(data) {
        const response = axios.post(url + 'login',
        {   username: data.username, 
            password: data.password
        }).then((dataresponse) => {
            if (dataresponse.data.access_token) {
                localStorage.setItem('authentication', JSON.stringify(dataresponse.data));
            }
            console.log(dataresponse);
            return dataresponse.data;
        }).catch((err) => {
            console.log(err);
        });
        return response;
    }
}

export default new ApiService();