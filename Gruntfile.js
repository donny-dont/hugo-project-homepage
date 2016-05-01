// Copyright (c) 2016, the Hugo Project Homepage Authors.
// Please see the AUTHORS file for details.
// This program is free software. It comes without any warranty, to
// the extent permitted by applicable law. You can redistribute it
// and/or modify it under the terms of the Do What The Fuck You Want
// To Public License, Version 2, as published by Sam Hocevar. See
// http://www.wtfpl.net/ for more details.

module.exports = function(grunt) {
  var dest = grunt.option('target') || 'master';

  grunt.initConfig({
    // Config
    globalConfig: {
      src: 'build/web',
      dest: dest + '/static',
      cssSrc: '<%= globalConfig.src %>/packages/project_homepage'
    },

    // Copy compiled files
    copy: {
      main: {
        files: [
          {
            expand: true,
            cwd: '<%= globalConfig.src %>',
            src: ['*.dart.js'],
            dest: '<%= globalConfig.dest %>/js'
          },
          {
            expand: true,
            cwd: '<%= globalConfig.cssSrc %>',
            src: ['*.min.css'],
            dest: '<%= globalConfig.dest %>/css'
          }
        ]
      }
    },

    // Minify css files
    cssmin: {
      target: {
        files: [{
          expand: true,
          cwd: '<%= globalConfig.cssSrc %>',
          src: ['*.css', '!*.min.css'],
          dest: '<%= globalConfig.cssSrc %>',
          rename: function(dest, src) {
            return dest + '/' + src.substring(0, src.indexOf('.css')) + '.min.css';
          }
        }]
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-cssmin');

  grunt.registerTask('default', ['cssmin']);
  grunt.registerTask('deploy', ['copy']);
};
