var AWS = require('aws-sdk');
var fs = require('fs');

AWS.config.region = 'us-west-1';
var s3 = new AWS.S3();
var bucket = 'hourofnode.org';
var files = {js: 'main.js'};

for (key in files) {
  var file = files[key];
  console.log("Reading", key, file);
  var source = 'web/' + file;
  fs.readFile(source, function (err, data) {
    console.log("Read", source, file);
    var params = {Bucket: bucket, Key: file, Body: data};
    var result = s3.putObject(params, function(err, data) {
      if (err) {
        console.log("Error uploading data: ", err);
      } else {
        console.log("Successfully uploaded " + file + " to " + bucket);
      }
    });
  });
}
