import TurnDownService from "turndown";
import { Action, ActionPanel, Icon, List } from "@raycast/api";
import {
  cleanUpAndCloseWindow,
  copyTextToClipboard,
  readHTMLFromClipboard,
  showErrorToast,
  showHUD,
} from "../../utils";

const handle = () => async () => {
  const html = await readHTMLFromClipboard();
  if (!html) {
    return await showErrorToast("Unable to find text in clipboard");
  }

  try {
    const service = new TurnDownService({
      bulletListMarker: "-",
      codeBlockStyle: "fenced",
    });
    const markdown = service.turndown(html).replace(/\s{2,}\n/g, "\n");
    await copyTextToClipboard(markdown);
    cleanUpAndCloseWindow();
    showHUD("Copied to clipboard");
  } catch (err) {
    await showErrorToast(String(err));
  }
};

const items: React.ReactNode[] = [];

items.push(
  <List.Item
    key="paste-to-markdown"
    title="Paste to Markdown"
    accessories={[{ icon: Icon.Code }]}
    icon="text.png"
    actions={
      <ActionPanel>
        <Action title="Read from clipboard and execute" onAction={handle()} />
      </ActionPanel>
    }
  />
);

export default items;
