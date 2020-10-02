module.exports = {
  test: /\.s(c|a)ss$/,
  use: [
    'vue-style-loader',
    'css-loader',
    {
      loader: 'sass-loader',
      options: {
        sassOptions: {
          indentedSyntax: true
          },
      }
    }
  ]
}
