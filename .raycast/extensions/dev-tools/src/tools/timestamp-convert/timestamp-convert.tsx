import { Action, ActionPanel, Icon, List } from "@raycast/api";
import {
  cleanUpAndCloseWindow,
  showErrorToast,
  copyTextToClipboard,
  readTextFromClipboard,
  showHUD,
  showSuccessToast,
} from "../../utils";

enum Conversion {
  ISO8601ToUnixTimestamp = "ISO 8601 To Unix Timestamp",
  ISO8601ToUnixTimestampMilisec = "ISO 8601 To Unix Timestamp (milisecs)",
  UnixTimestampToDate = "Unix Timestamp to Date",
}

const validateISOStringAndReturnDate = (text: string): Date | undefined => {
  const date = new Date(text);
  if (date.toString() === "Invalid Date") {
    showErrorToast("Invalid ISO date string");
    return;
  }
  return date;
};

const handle = (conversion: Conversion) => async (): Promise<void> => {
  const text = await readTextFromClipboard();
  if (!text) {
    showErrorToast("No text found in clipboard");
    return;
  }
  const handlers = {
    [Conversion.ISO8601ToUnixTimestamp]: () => {
      const date = validateISOStringAndReturnDate(text);
      if (!date) {
        return;
      }
      const unixTimestamp = Math.round(date.getTime() / 1000);
      copyTextToClipboard(unixTimestamp.toString());
      showHUD("Copied timestamp to clipboard");
      cleanUpAndCloseWindow();
    },
    [Conversion.ISO8601ToUnixTimestampMilisec]: () => {
      const date = validateISOStringAndReturnDate(text);
      if (!date) {
        return;
      }
      copyTextToClipboard(date.getTime().toString());
      showHUD("Copied timestamp (milisecs) to clipboard");
      cleanUpAndCloseWindow();
    },
    [Conversion.UnixTimestampToDate]: () => {
      let date: Date | null = null;
      if (text.length === 10) {
        date = new Date(Number(`${text}000`));
      }

      if (text.length === 13) {
        date = new Date(Number(text));
      }

      if (!date) {
        showErrorToast("Timestamp is incorrect");
        return;
      }
      showSuccessToast(date.toLocaleString());
    },
  };
  const handler = handlers[conversion];
  if (!handlers) {
    showErrorToast(`Unable to handle ${conversion}`);
  }
  handler();
};

export default Object.values(Conversion).map((conversion) => (
  <List.Item
    key={conversion}
    title={conversion}
    accessories={[{ icon: Icon.Clock }]}
    icon="clock.png"
    actions={
      <ActionPanel>
        <Action title="Convert now" onAction={handle(conversion)} />
      </ActionPanel>
    }
  />
));
