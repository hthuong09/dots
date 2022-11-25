import { ActionPanel, Action, Icon, List, closeMainWindow, popToRoot } from "@raycast/api";
import { useEffect, useState } from "react";
import fs from "fs";
import { resolvePath } from "./utils";
import { execa } from "execa";

async function runKitty(...args: string[]) {
  execa("/opt/homebrew/bin/kitty", ["-d", "~", "--instance-group", "session", "-1", ...args], { detached: true });
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
