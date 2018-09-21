#include <kore/kore.h>
#include <kore/http.h>
#include <time.h>
#include <json-c/json.h>

#define HELLO_RESPONSE   "Hello, World!"
#define PLAINTEXT_HEADER "text/plain"
#define JSON_HEADER      "application/json"

char *date_now(void);
int res_plaintext(struct http_request *);
int res_json(struct http_request *);

char *date_now(void) {
  time_t now = time(NULL);

  return ctime(&now);
}

int res_plaintext(struct http_request *req) {
  http_response_header(req, "Content-Type", PLAINTEXT_HEADER);
  http_response_header(req, "Date", date_now());
  http_response(req, 200, HELLO_RESPONSE, strlen(HELLO_RESPONSE));

  return (KORE_RESULT_OK);
}

int res_json(struct http_request *req) {
  json_object *obj = json_object_new_object();
  json_object *message = json_object_new_string(HELLO_RESPONSE);
  json_object_object_add(obj, "message", message);

  const char *response_string = json_object_to_json_string(obj);

  http_response_header(req, "Content-Type", JSON_HEADER);
  http_response_header(req, "Date", date_now());
  http_response(req, 200, response_string, strlen(response_string));

  return (KORE_RESULT_OK);
}
