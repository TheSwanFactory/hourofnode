var AWS = require('aws-sdk');
var fs = require('fs');

AWS.config.region = 'us-west-1';
var bucket = new AWS.S3({params: {Bucket: 'hourofnode.org'}});

var filename = '../web/main.js';
fs.readFile(filename, function (err, data) {
  var params = {Key: file, Body: data};
  bucket.putObject(params).done(function (resp) {
    console.log('Successfully uploaded package.');
  });
});
