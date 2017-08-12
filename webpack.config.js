'use strict';

const path = require('path');
const webpack = require('webpack');

const vendorPaths = /\/(frontend\/javascripts\/vendor|node_modules)\//;

const config = {
  // the base path which will be used to resolve entry points
  devtool: 'cheap-module-source-map',
  context: path.join(__dirname, 'app/frontend/javascripts'),
  entry: {
    app: './application.js',
    vendor: './vendor.js',
  },
  output: {
    path: path.join(__dirname, 'app', 'assets', 'javascripts'),
    filename: 'app.js',

    devtoolModuleFilenameTemplate: '[resourcePath]',
    devtoolFallbackModuleFilenameTemplate: '[resourcePath]?[hash]',

    // if the webpack code-splitting feature is enabled, this is the path it'll use to download bundles
    publicPath: '/assets/',
  },

  resolve: {
    extensions: ['', '.js', '.jsx'],
    modulesDirectories: ['node_modules'],
  },
  module: {
    preLoaders: [
      { test: /\.jsx?$/, exclude: vendorPaths, loader: 'babel-loader' },
    ],
    loaders: [
      // { test: /\.js$/, exclude: /node_modules/, loader: 'eslint-loader' },
      { test: require.resolve('jquery'), loader: 'expose?$!expose?jQuery' },
      { test: require.resolve('moment'), loader: 'expose?moment' },
      { test: require.resolve('react'), loader: 'expose?React' },
      { test: require.resolve('react-bootstrap'), loader: 'expose?ReactBoostrap' },
      { test: /\.jsx?$/, exclude: /node_modules/, loader: 'babel' },
      { test: /\.json$/, loader: 'json' },
      { test: /\.less$/, loader: 'style!css!less' },
      { test: /\.css$/, loader: 'style!css' },
      { test: /\.png$/, loader: 'url?limit=100000' },
      { test: /\.(jpg|gif)$/, loader: 'file' },
      { test: /\.(woff|woff2)(\?v=\d+\.\d+\.\d+)?$/, loader: 'url?limit=10000&mimetype=application/font-woff' },
      { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: 'url?limit=10000&mimetype=application/octet-stream' },
      { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: 'file' },
      { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: 'url?limit=10000&mimetype=image/svg+xml' },
    ],
  },
  plugins: [
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
    }),
    new webpack.DefinePlugin({
      'process.env': {
        'NODE_ENV': JSON.stringify('production')
      }
    }),
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    }),
    new webpack.optimize.CommonsChunkPlugin(
        /* chunkName= */'vendor', /* filename= */'vendor.js'
    ),
  ],
};

module.exports = config;