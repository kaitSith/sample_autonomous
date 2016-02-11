const gulp = require('gulp');
const browserSync = require('browser-sync');
const browserify = require('browserify');
const babelify = require('babelify');
const riotify = require('riotify');
const source = require('vinyl-source-stream');

gulp.task('browserSync', ()=>{
  browserSync({
  	server: {
  	  baseDir: '../'
  	}
  });
});

gulp.task('reload', ()=>{
  browserSync.reload();
})

gulp.task('concat', ()=>{
  return browserify({
  	debug: true,
  	entries: ['js/main'],
    extensions: ['.js']
  }).transform([riotify])
    .bundle()
    .pipe(source('main.bundle.js'))
    .pipe(gulp.dest('../assets/js/'));
});

gulp.task('watch', ()=>{
  gulp.watch([
  	'js/**/**'
  	], ['concat','reload']
  );	
})

gulp.task('default', ['concat', 'browserSync', 'watch']);