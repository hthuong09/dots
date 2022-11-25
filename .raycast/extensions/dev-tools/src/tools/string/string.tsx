import { ActionPanel, Action, Icon, List, confirmAlert } from "@raycast/api";
import { showErrorToast, readTextFromClipboard } from "../../utils";

export default [
  <List.Item
    key="char count"
    title="String Char/Word Count"
    accessories={[{ icon: Icon.Code }]}
    icon="text.png"
    actions={
      <ActionPanel>
        <Action
          title="Count character"
          onAction={async () => {
            const text = await readTextFromClipboard();
            if (!text) {
              showErrorToast("No text was found from clipboard");
              return;
            }
            const charCount = text.length;
            const wordCount = text.split(" ").length;
            confirmAlert({
              title: "String Info",
              message: `Character Count: ${charCount}\nWord Count: ${wordCount}`,
            });
          }}
        />
      </ActionPanel>
    }
  />,
];
