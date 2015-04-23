gulp = require("gulp")
watch = require("gulp-watch")
mocha = require("gulp-mocha")
webpack = require("gulp-webpack")
coffee = require("gulp-coffee")
uglify = require("gulp-uglify")
config = uglify: false
paths =
  coffee: [
    "coffee/docUtils.coffee"
    "coffee/linkManager.coffee"
    "coffee/index.coffee"
  ]
  coffeeTest: [
    "coffee/test.coffee"
    "coffee/fixtures/**.coffee"
  ]
  testDirectory: __dirname + "/test"
  js: "js/"
  webpack:
    entry: "./webpack.entry.js"
    config: "./webpack.config.js"

gulp.task "allCoffee", ->
  gulp.src(paths.coffee)
    .pipe(coffee(bare: true))
    .pipe gulp.dest(paths.js)
  a = gulp.src(paths.coffeeTest)
    .pipe(coffee(map: true))
  a = a.pipe(uglify())  if config.uglify
  a = a.pipe(gulp.dest(paths.testDirectory))

gulp.task "watch", ->
  gulp.src(paths.coffee)
    .pipe watch((files) ->
      f = files
        .pipe(coffee(bare: true))
        .pipe(gulp.dest(paths.js))
      f )
  gulp.watch paths.coffeeTest, ["mocha"]

gulp.task "webpack", ->
  return gulp.src(paths.webpack.entry)
    .pipe(webpack(require(paths.webpack.config)))
    .pipe gulp.dest("test")

gulp.task "mocha", ->
  return gulp.src("./coffee/test.coffee",
    read: false
    ui: "bdd"
    reporter: "doc"
    # debug: true
  ).pipe mocha(reporter: "nyan")


gulp.task "default", [
  "mocha"
  "watch"
]
