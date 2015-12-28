/**
 * Created by jsinai on 9/28/15.
 */

var gulp = require('gulp');
var clean = require('gulp-clean');
var injectfile = require("gulp-inject-file");

var dest = './dest';

gulp.task('clean', function () {
    return gulp.src(dest, {read: false})
        .pipe(clean({force: true}));
});
gulp.task('inject', ['clean'], function () {
    return gulp.src('bsvirtualkb.html')
        .pipe(injectfile({
            // <filename> token will be replaced by the actual filename
            pattern: '/\\*\\sinject:\\s<filename>\\s\\*/'
        }))
        .pipe(gulp.dest(dest))
});

gulp.task('default', ['clean', 'inject']);
