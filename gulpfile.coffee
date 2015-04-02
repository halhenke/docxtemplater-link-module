gulp = require("gulp")
watch = require("gulp-watch")
mocha = require("gulp-mocha")
coffee = require("gulp-coffee")
uglify = require("gulp-uglify")
config = uglify: false
paths =
  coffee: [
    "coffee/subContent.coffee"
    "coffee/docxQrCode.coffee"
    "coffee/xmlUtil.coffee"
    "coffee/docUtils.coffee"
    "coffee/imgManager.coffee"
    "coffee/imgReplacer.coffee"
    "coffee/index.coffee"
  ]
  coffeeTest: ["coffee/test.coffee"]
  testDirectory: __dirname + "/test"
  js: "js/"

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
      f = files.pipe(coffee(bare: true)).pipe(gulp.dest(paths.js))
      f )
  gulp.watch paths.coffeeTest, ["mocha"]


gulp.task "mocha", ->
  gulp.src("./coffee/test.coffee",
    read: false
    ui: "bdd"
    reporter: "doc"
    # debug: true
  ).pipe mocha(reporter: "nyan")


gulp.task "default", [
  "mocha"
  "watch"
]
