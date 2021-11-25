<template>
    <div>
        <h2>Pengguna</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Nama</th>
                    <th>Username</th>
                    <th>Jabatan</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="item in pengguna" :key="item.idpengguna">
                    <td>{{ item.nama }}</td>
                    <td>{{ item.username }}</td>
                    <td>{{ item.jabatan }}</td>
                </tr>
            </tbody>
        </table>
    </div>
</template>
<script>
console.log('Pengguna added');
export default {
    nama: 'Pengguna',
    props: ['pengguna']
}
</script>