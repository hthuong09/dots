import { ActionPanel, Action, Icon, List, closeMainWindow, popToRoot } from "@raycast/api";
import { useEffect, useState } from "react";
import fs from "fs";
import { resolvePath } from "./utils";
import { runAppleScript } from "run-applescript";

async function runKitty(...args: string[]) {
  const script = `do shell script "LC_ALL=en_US.UTF-8 open -n -a '/Applications/kitty.app' --args -d ~ --instance-group session -1 ${args.join(" ")}"`;
  runAppleScript(script);
}

export default function Command() {
  const noSession = "No session";
  const [profiles, setProfiles] = useState<string[]>([]);
  const configPath = "~/.config/kitty/sessions";
  const absolutePath = resolvePath(configPath);

  useEffect(() => {
    setProfiles([noSession, ...fs.readdirSync(absolutePath)]);
  }, []);

  return (
    <List>
      {profiles.map((item) => (
        <List.Item
          key={item}
          icon="kitty.png"
          title={item}
          accessories={[{ icon: Icon.Terminal }]}
          actions={
            <ActionPanel>
              <Action
                title="Open Kitty with this profile"
                onAction={async () => {
                  // Why async not working??
                  setTimeout(() => {
                    if (item === noSession) {
                      runKitty();
                    } else {
                      runKitty("--session", `${absolutePath}/${item}`, "--title", item);
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
