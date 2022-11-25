export const resolvePath = (filePath: string) => {
  const os = require("os");
  if (!filePath || typeof filePath !== "string") {
    return "";
  }
  if (filePath.startsWith("~/") || filePath === "~") {
    return filePath.replace("~", os.homedir());
  }
  return filePath;
};
