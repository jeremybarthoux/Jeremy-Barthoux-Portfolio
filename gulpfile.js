'use strict';
// generated on 2014-11-12 using generator-gulp-webapp 0.1.0

var gulp = require('gulp');

// load plugins
var $ = require('gulp-load-plugins')();

gulp.task('scripts', function ()   {
    return gulp.src('app/scripts/**/*.coffee')
        .pipe($.plumber())
        .pipe($.coffee())
        .pipe(gulp.dest('.tmp/scripts'));
});

gulp.task('jade', function ()   {
    return gulp.src('app/*.jade')
        .pipe($.plumber())
        .pipe($.jade({
            pretty: true
        }))
        .pipe(gulp.dest('.tmp'));
});

gulp.task('styles', function () {
    return gulp.src('app/styles/main.scss')
        .pipe($.plumber())
        .pipe($.rubySass({
            style: 'expanded',
            precision: 10
        }))
        .pipe($.base64({
            extensions: ['jpg', 'svg', 'png'],
            baseDir: 'app',
            debug: true
        }))
        .pipe($.autoprefixer('> 1%'))
        .pipe(gulp.dest('.tmp/styles'))
        .pipe($.size());
});

gulp.task('copieCompiled', function () {
    return gulp.src('.tmp/**/*.{js,css}')
        .pipe(gulp.dest('dist'));
});

gulp.task('php', function ()   {
    return gulp.src('app/php/*.php')
        .pipe(gulp.dest('.tmp/php'));
});

gulp.task('html', ['styles', 'scripts', 'jade', 'php'], function () {
    var jsFilter = $.filter('**/*.js');
    var cssFilter = $.filter('**/*.css');

    gulp.start('copieCompiled');

    return gulp.src('.tmp/*.html')
        .pipe($.plumber())
        .pipe($.useref.assets({searchPath: '{.tmp,app}'}))
        .pipe(jsFilter)
        .pipe($.uglify())
        .pipe(jsFilter.restore())
        .pipe(cssFilter)
        .pipe($.csso())
        .pipe(cssFilter.restore())
        .pipe($.useref.restore())
        .pipe($.useref())
        .pipe(gulp.dest('dist'))
        .pipe($.size());
});

gulp.task('images', function () {
    return gulp.src('app/images/**/*')
        .pipe($.plumber())
        .pipe($.cache($.imagemin({
            optimizationLevel: 3,
            progressive: true,
            interlaced: true
        })))
        .pipe(gulp.dest('dist/images'))
        .pipe($.size());
});

gulp.task('extras', function () {
    return gulp.src(['app/*.*', '!app/*.jade', 'app/**/vendor/*', 'app/php/*.php'], { dot: true })
        .pipe(gulp.dest('dist'));
});

gulp.task('clean', function () {
    return gulp.src(['.tmp', 'dist'], { read: false }).pipe($.clean());
});

gulp.task('build', ['html', 'images', 'extras']);

gulp.task('default', ['clean'], function () {
    gulp.start('build');
});

gulp.task('connect', function () {
    var connect = require('connect');
    var app = connect()
        .use(require('connect-livereload')({ port: 35729 }))
        .use(connect.static('app'))
        .use(connect.static('.tmp'))
        .use(connect.directory('app'));

    require('http').createServer(app)
        .listen(9000)
        .on('listening', function () {
            console.log('Started connect web server on http://localhost:9000');
        });
});

gulp.task('serve', ['connect', 'styles', 'scripts', 'jade', 'php'], function () {
    require('opn')('http://localhost:9000');
});

gulp.task('watch', ['clean'], function () {
    gulp.start('watchReaload');
});

gulp.task('watchReaload', ['connect', 'serve'], function () {
    var server = $.livereload();

    // watch for changes
    gulp.watch([
        '.tmp/*.html',
        '.tmp/styles/**/*.css',
        '{.tmp,app}/scripts/**/*.js',
        'app/images/**/*',
        'app/php/*.php'
    ]).on('change', function (file) {
        server.changed(file.path);
    });

    gulp.watch('app/*.jade', ['jade']);
    gulp.watch('app/styles/**/*.scss', ['styles']);
    gulp.watch('app/scripts/**/*.coffee', ['scripts']);
    gulp.watch('app/images/**/*', ['styles']);
    gulp.watch('app/php/*.php', ['php']);
});
