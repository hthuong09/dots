import { ActionPanel, Action, Icon, List, closeMainWindow, popToRoot } from "@raycast/api";
import { useEffect, useState } from "react";
import fs from "fs";
import { resolvePath } from "./utils";
import { runAppleScript } from "run-applescript";

async function runWezterm(...args: string[]) {
  const script = `do shell script "LC_ALL=en_US.UTF-8 PATH=$PATH:/opt/homebrew/bin/ wezterm start ${args.join(
    " "
  )} > /dev/null 2>&1 &"`;
  console.log("test", await runAppleScript(script));
}

export default function Command() {
  const noSession = "Default";
  const [workspaces, setWorkspaces] = useState<string[]>([]);
  const configPath = "~/.config/wezterm/workspaces";
  const absolutePath = resolvePath(configPath);

  useEffect(() => {
    setWorkspaces([noSession, ...fs.readdirSync(absolutePath).map((workspace) => workspace.replace(".lua", ""))]);
  }, []);

  return (
    <List>
      {workspaces.map((item) => (
        <List.Item
          key={item}
          icon="wezterm.png"
          title={item}
          accessories={[{ icon: Icon.Terminal }]}
          actions={
            <ActionPanel>
              <Action
                title="Open Wezterm with this workspace"
                onAction={async () => {
                  setTimeout(() => {
                    if (item === noSession) {
                      runWezterm();
                    } else {
                      runWezterm("--", item);
                    }
                  }, 0);
                  await closeMainWindow();
                  await popToRoot({ clearSearchBar: true });
                }}
              />
            </ActionPanel>
          }
        />
      ))}
    </List>
  );
}
