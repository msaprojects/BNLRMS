module.exports = {
    devServer: {
      proxy: {
        '^/api': {
          target: 'http://server.bnl.id:9990/api/v1',
          changeOrigin: true
        },
      }
    }
  }