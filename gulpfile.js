var gulp = require('gulp');
var useref = require('gulp-useref');
var es = require('event-stream');
var uglify = require('gulp-uglify');
var minifyCss = require('gulp-clean-css');
var ngAnnotate = require('gulp-ng-annotate');
var gulpif = require('gulp-if');
const zip = require('gulp-zip');
var del = require('del');

var dest = './dest';

function clean() {
    return del(['dest']);
}

function userefHtml(cb){
    cb();
    return es.merge(
        gulp.src(['bsvirtualkb.html'])
            .pipe(useref())
            .pipe(gulp.dest(dest)),
        gulp.src(['autorun.brs', 'bsvirtualkb.json'])
            .pipe(gulp.dest(dest))
    );
}

function zipFiles(){
    return gulp.src(['bsvirtualkb.html', 'bsvirtualkb.json'])
           .pipe(useref())
           .pipe(gulpif('*.js', ngAnnotate()))
           .pipe(gulpif('*.js', uglify()))
           .pipe(gulpif('*.css', minifyCss()))
           .pipe(zip('keyboard.zip'))
           .pipe(gulp.dest('./presentation'));
}

var build = gulp.series(clean, userefHtml, zipFiles);

exports.clean   = clean;
exports.useref  = userefHtml;
exports.zip     = zipFiles;

exports.default = build;