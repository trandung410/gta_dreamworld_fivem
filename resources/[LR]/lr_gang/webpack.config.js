var path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    /* entry: './src/index.js', */
    entry: {
        app: './src/index.js',
        home: './src/home.js',
        member: './src/member.js',
        store: './src/store.js',
        upgrade: './src/upgrade.js',
    },
    output:{
        path: path.resolve(__dirname, 'build'),
        filename: '[name].bundle.js',
    },
    module: {
        rules: [
            {
                test: /\.(js)$/,
                use: {
                    loader: 'babel-loader',
                    options: {
                      presets: ['@babel/preset-env']
                    }
                }
            },
            {
                test: /\.css$/i,
                use: ['style-loader', 'css-loader'],
            },
            {
                test: /\.(png|jpe?g|gif|svg|eot|ttf|woff|woff2)$/i,
                loader: 'file-loader',
                options: {
                    name: '[path][name].[ext]',
                },
            },
        ]
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: './src/index.html'
        })
    ],
    mode: 'development',
}