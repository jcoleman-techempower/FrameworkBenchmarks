import * as express from "express";
import { ContextResponse, GET, Path } from "typescript-rest";

@Path("/plaintext")
export default class Plaintext {
  /**
   * Sends the plaintext message
   */

  @GET
  plaintext(@ContextResponse response: express.Response): string {
    response.contentType("text/plain"); // defaults to `text/html` for this function
    return "Hello, World!";
  }
}
