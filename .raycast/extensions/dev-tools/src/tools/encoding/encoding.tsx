import { ActionPanel, Action, Icon, List } from "@raycast/api";
import {
  cleanUpAndCloseWindow,
  readTextFromFile,
  showErrorToast,
  showHUD,
  copyTextToClipboard,
  readFilePathFromClipBoard,
  readTextFromClipboard,
} from "../../utils";

enum EncodingList {
  Base64Decode = "Base64 decode",
  Base64Encode = "Base64 encode",
  UrlEncode = "URL encode",
  UrlDecode = "URL decode",
}

enum Input {
  FromTextClipboard = "from text",
  FromFileClipboard = "from file",
}

const icons = {
  [EncodingList.Base64Decode]: "base64.png",
  [EncodingList.Base64Encode]: "base64.png",
  [EncodingList.UrlDecode]: "url.png",
  [EncodingList.UrlEncode]: "url.png",
};

const encodeHandler = {
  [EncodingList.Base64Encode]: (text: string): string => {
    return Buffer.from(text, "utf8").toString("base64");
  },
  [EncodingList.Base64Decode]: (text: string): string => {
    const decoded = Buffer.from(text, "base64").toString("utf8");
    const encoded = Buffer.from(decoded, "utf8").toString("base64");
    if (encoded !== text) {
      throw "Not a valid base64 encoded string";
    }
    return decoded;
  },
  [EncodingList.UrlEncode]: (text: string): string => {
    return encodeURIComponent(text).replace(/'/g, "%27").replace(/"/g, "%22");
  },
  [EncodingList.UrlDecode]: (text: string): string => {
    return decodeURIComponent(text.replace(/\+/g, " "));
  },
};

const readFromClipboard = async (input: Input): Promise<string | undefined> => {
  if (input === Input.FromTextClipboard) {
    return await readTextFromClipboard();
  }

  const filePath = await readFilePathFromClipBoard();
  if (!filePath) {
    return;
  }
  return await readTextFromFile(filePath);
};

const handle = (encoding: EncodingList, input: Input) => async () => {
  if (!encodeHandler[encoding]) {
    return await showErrorToast(`Unable to handle encode for ${encoding}`);
  }

  const text = await readFromClipboard(input);
  if (!text) {
    return await showErrorToast("Unable to find text in clipboard");
  }

  try {
    const encodedText = encodeHandler[encoding](text);
    await copyTextToClipboard(encodedText);
    cleanUpAndCloseWindow();
    showHUD("Copied to clipboard");
  } catch (err) {
    await showErrorToast(String(err) || "Unable to encode/decode");
  }
};

const items: React.ReactNode[] = [];

Object.values(Input).forEach((input) => {
  Object.values(EncodingList).forEach((encoding) =>
    items.push(
      <List.Item
        key={encoding + input}
        title={`${encoding} ${input}`}
        accessories={[{ icon: Icon.Code }]}
        icon={icons[encoding]}
        actions={
          <ActionPanel>
            <Action title="Read from clipboard and execute" onAction={handle(encoding, input)} />
          </ActionPanel>
        }
      />
    )
  );
});

export default items;
