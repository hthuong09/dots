import { Clipboard } from "@raycast/api";
import { runAppleScript } from "run-applescript";
import { isFileExist } from "./file";
import { showErrorToast } from "./ui";

export const readTextFromClipboard = async (): Promise<string | undefined> => {
  return await Clipboard.readText();
};

export const readFilePathFromClipBoard = async (): Promise<string | undefined> => {
  const url = await runAppleScript(`copy (POSIX path of (the clipboard as «class furl»)) to stdout`);
  return url === "" ? undefined : url;
};

const validateTextAndGetContent = async (text: string): Promise<Clipboard.Content | undefined> => {
  if (!text) {
    await showErrorToast("Text can't be empty");
    return;
  }
  return {
    text,
  };
};

const validateFileAndGetContent = async (file: string): Promise<Clipboard.Content | undefined> => {
  const fileExits = await isFileExist(file);
  if (!fileExits) {
    await showErrorToast("File can be empty");
    return;
  }
  return {
    file,
  };
};

export const copyTextToClipboard = async (text: string): Promise<void> => {
  const content = await validateTextAndGetContent(text);
  if (!content) {
    return;
  }

  await Clipboard.copy(content);
};

export const copyFileToClipboard = async (file: string): Promise<void> => {
  const content = await validateFileAndGetContent(file);
  if (!content) {
    return;
  }

  await Clipboard.copy(content);
};

export const pasteText = async (text: string): Promise<void> => {
  const content = await validateTextAndGetContent(text);
  if (!content) {
    return;
  }

  await Clipboard.paste(content);
};

export const pasteFile = async (file: string): Promise<void> => {
  const content = await validateTextAndGetContent(file);
  if (!content) {
    return;
  }

  await Clipboard.paste(content);
};
