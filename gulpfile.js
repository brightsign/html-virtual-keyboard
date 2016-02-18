var gulp = require('gulp');
var mainBowerFiles = require('main-bower-files');
var useref = require('gulp-useref');
var clean = require('gulp-clean');
var es = require('event-stream');

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

gulp.task('default', ['clean', 'useref']);