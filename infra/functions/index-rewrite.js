// Runs on every viewer request before the cache lookup.
// S3 REST endpoints don't resolve directory indexes, so map "/path/" to "/path/index.html".
function handler(event) {
  var request = event.request;
  var uri = request.uri;

  if (uri.endsWith('/')) {
    request.uri += 'index.html';           // /projects/  →  /projects/index.html
  } else if (!uri.includes('.')) {
    request.uri += '/index.html';          // /projects   →  /projects/index.html
  }
  return request;                          // /css/style.css — without changes
}