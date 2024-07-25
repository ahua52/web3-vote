const { defineConfig } = require('@vue/cli-service');

// const NodePolyfillWebpackPlugin = require("node-polyfill-webpack-plugin");

const { VantResolver }  = require('unplugin-vue-components/resolvers');
const ComponnetsPlugin = require('unplugin-vue-components/webpack');

// new NodePolyfillWebpackPlugin,
module.exports = defineConfig({
  transpileDependencies: true,
  configureWebpack: {
    plugins: [
      ComponnetsPlugin({ resolvers: [ VantResolver() ] })
    ]
  }
})
