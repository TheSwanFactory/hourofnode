var AWS = require('aws-sdk');
var fs = require('fs');

AWS.config.region = 'us-west-1';
var s3 = new AWS.S3();
var bucket = 'hourofnode.org';
var filename = 'web/main.js';

fs.readFile(filename, function (err, data) {
  var params = {Bucket: bucket, Key: filename, Body: data};
  var result = s3.putObject(params, function(err, data) {
    if (err) {
      console.log("Error uploading data: ", err);
    } else {
      console.log("Successfully uploaded data to myBucket/myKey");
    }
  });
});
