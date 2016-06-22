var gulp = require('gulp');
var mainBowerFiles = require('main-bower-files');
var useref = require('gulp-useref');
var clean = require('gulp-clean');
var es = require('event-stream');
var uglify = require('gulp-uglify');
var minifyCss = require('gulp-minify-css');
var ngAnnotate = require('gulp-ng-annotate');
var gulpif = require('gulp-if');
const zip = require('gulp-zip');

var dest = './dest';

gulp.task('clean', function () {
    return gulp.src(dest, {read: false})
        .pipe(clean({force: true}));
});
gulp.task('useref', ['clean'], function () {

    return es.merge(
        gulp.src(['bsvirtualkb.html'])
            .pipe(useref())
            .pipe(gulp.dest(dest)),
        gulp.src(['autorun.brs', 'bsvirtualkb.json'])
            .pipe(gulp.dest(dest))
    );
});

gulp.task('zip', ['clean'], function () {
    return gulp.src(['bsvirtualkb.html', 'bsvirtualkb.json'])
        .pipe(useref())
        .pipe(gulpif('*.js', ngAnnotate()))
        .pipe(gulpif('*.js', uglify()))
        .pipe(gulpif('*.css', minifyCss()))
        .pipe(zip('keyboard.zip'))
        .pipe(gulp.dest('./presentation'));
});

gulp.task('default', ['clean', 'useref', 'zip']);