module.exports = {
  // entry: 'mocha!./webpack.entry.js',
  entry: './webpack.entry.js',
  output: {
    filename: './test/bundle.js',
    // filename: './public/bundle.js',
    // // export itself to a global var
    // libraryTarget: "var",
    // // name of the global var: "Foo"
    // library: "webpacked",
    // libraryTarget: "commonjs2"

    // Export everything to the global namesapce
    // libraryTarget: "this"
  },
  node: {
    fs: "empty"
  },
  module: {
      loaders: [
          { test: /\.coffee$/, loader: "coffee-loader" },
          // { test: /\.jade$/, loader: "jade" },
          // => "jade" loader is used for ".jade" files
          { test: /\.css$/, loader: "style!css" },
          // Alternative syntax:
          // { test: /\.css$/, loaders: ["style", "css"] },
      ]
  }
};
