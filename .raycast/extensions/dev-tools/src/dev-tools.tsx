import { List } from "@raycast/api";
import encoding from "./tools/encoding/encoding";
import timestampConvert from "./tools/timestamp-convert/timestamp-convert";
import jsonFormatter from "./tools/json-format/json-format";
import string from "./tools/string/string";
import pasteToMarkdown from "./tools/markdown/paste-to-markdown";

export default function Command() {
  return <List>{[...encoding, ...timestampConvert, ...jsonFormatter, ...string, ...pasteToMarkdown]}</List>;
}
