import { Action, ActionPanel, Alert, confirmAlert, Icon, List } from "@raycast/api";
import {
  cleanUpAndCloseWindow,
  showErrorToast,
  copyTextToClipboard,
  readTextFromClipboard,
  showSuccessToast,
  showHUD,
} from "../../utils";
import jsonlint from "jsonlint";
import { unescape } from "querystring";

enum Formatter {
  Format = "JSON format",
  TrimSpace = "JSON trim whitespace",
  Lint = "JSON lint",
  Unescape = "JSON unescape",
}

const validateJSONAndReturnObject = (text: string): object | undefined => {
  try {
    return JSON.parse(text);
  } catch (err) {
    showErrorToast("Can't parse JSON");
    return;
  }
};

const handle = (formatter: Formatter) => async (): Promise<void> => {
  const text = await readTextFromClipboard();
  if (!text) {
    showErrorToast("No text found in clipboard");
    return;
  }
  const handlers = {
    [Formatter.Format]: () => {
      const obj = validateJSONAndReturnObject(text);
      if (!obj) {
        return;
      }
      copyTextToClipboard(JSON.stringify(obj, null, 2));
      showHUD("Copied to clipboard");
      cleanUpAndCloseWindow();
    },
    [Formatter.TrimSpace]: () => {
      const obj = validateJSONAndReturnObject(text);
      if (!obj) {
        return;
      }
      copyTextToClipboard(JSON.stringify(obj));
      showHUD("Copied to clipboard");
      cleanUpAndCloseWindow();
    },
    [Formatter.Lint]: async () => {
      try {
        const formatted = jsonlint.formatJson(text);
        jsonlint.parse(formatted);
      } catch (err) {
        await confirmAlert({
          title: "Validation Result",
          message: String(err),
          primaryAction: {
            title: "OK",
          },
        });
        return;
      }
      showSuccessToast("No errors found");
    },
    [Formatter.Unescape]: () => {
      const unescaped = text
        .replace(/(\\n)/g, "")
        .replace(/(\\r)/g, "")
        .replace(/(\\t)/g, "")
        .replace(/(\\f)/g, "")
        .replace(/(\\b)/g, "")
        .replace(/(\")/g, '"')
        .replace(/("{)/g, "{")
        .replace(/(}")/g, "}")
        .replace(/(\\)/g, "")
        .replace(/(\/)/g, "/");
      copyTextToClipboard(unescaped);
      showHUD("Copied to clipboard");
      cleanUpAndCloseWindow();
    },
  };
  const handler = handlers[formatter];
  if (!handlers) {
    showErrorToast(`Unable to handle ${formatter}`);
  }
  handler();
};

export default Object.values(Formatter).map((formatter) => (
  <List.Item
    key={formatter}
    title={formatter}
    accessories={[{ icon: Icon.Code }]}
    icon="json.png"
    actions={
      <ActionPanel>
        <Action title="Format now" onAction={handle(formatter)} />
      </ActionPanel>
    }
  />
));
