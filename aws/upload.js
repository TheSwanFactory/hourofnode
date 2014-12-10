var AWS = require('aws-sdk');
var fs = require('fs');
var mime = require('mime');

var upload = function(file) {
  var realName = dir + '/' + file;
  fs.readFile(realName, function (err, data) {
    mimeType = mime.lookup(realName);
    console.log("Read", file);
    var params = {
      Bucket: bucket,
      Key: path + file,
      Body: data,
      ACL: 'public-read',
      ContentType: mimeType
    };
    var result = s3.putObject(params, s3done(file, bucket));
  });
};

var s3done = function(file, bucket) {
  return function(err, data) {
    if (err) {
      console.log("Error uploading data: ", err);
    } else {
      console.log("Successfully uploaded " + file + " to " + bucket);
    }
  }
};

var uploadAll = function(err, files) {
  if (err) { return console.log(err); }

  files.forEach(upload)
};

var devMode = process.argv[2] == 'dev';
AWS.config.region = 'us-west-1';
var s3 = new AWS.S3();
var bucket = 'hourofnode.org';
var path = '';
if (devMode) path += 'dev/';
var dir = 'web';

fs.readdir(dir, uploadAll)
