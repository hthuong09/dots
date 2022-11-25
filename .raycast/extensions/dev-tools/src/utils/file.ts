import fs from "fs";
import util from "util";
const existsPromise = util.promisify(fs.exists);
const readFilePromise = util.promisify(fs.readFile);

export const isFileExist = async (filePath: string): Promise<boolean> => {
  return await existsPromise(filePath);
};

export const readTextFromFile = async (filePath: string): Promise<string | undefined> => {
  const fileExists = await isFileExist(filePath);
  if (!fileExists) {
    return "";
  }
  return await readFilePromise(filePath, { encoding: "utf-8" });
};
