// vueを読み込むためのプリローダー
const { VueLoaderPlugin } = require("vue-loader");

module.exports = {
  devtool: 'inline-source-map',
  entry: {
    application: './src/main.js',
  },
  // コンパイル後の出力先
  output: {
    path: __dirname + '/../public/dist', // __dirnameはカレントディレクトリが絶対パスで入ってる
    filename: 'bundle.js'
  },
  module: {
    rules: [
      // webpackも基本的にはjsしか理解できない
      // ファイルの拡張子ごとにプリローダーを指定することで他の言語をまとめてビルドできる
      {
        test: /\.css$/,
        use: ["vue-style-loader", "css-loader"]
      },
      {
        test: /\.vue$/,
        loader: "vue-loader"
      },
      {
        // ローダーの対象 // 拡張子 .js の場合
        test: /\.js$/,
        // ローダーの処理対象から外すディレクトリ
        exclude: /node_modules/,
        // Babel を利用する
        loader: "babel-loader",
        // Babel のオプションを指定する
        options: {
          presets: [
            // プリセットを指定することで、ES2019 を ES5 に変換
            "@babel/preset-env"
          ]
        }
      }
    ]
  },
  plugins: [
    // Vueを読み込めるようにするため
    new VueLoaderPlugin()
  ]
}
