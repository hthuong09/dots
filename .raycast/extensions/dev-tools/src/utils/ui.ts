import { closeMainWindow, popToRoot, showToast, Toast, showHUD as raycastShowHUB } from "@raycast/api";

export const cleanUpAndCloseWindow = () => {
  closeMainWindow();
  popToRoot();
};

export const showErrorToast = async (title: string, message = ""): Promise<void> => {
  await showToast({
    style: Toast.Style.Failure,
    title,
    message,
  });
};

export const showSuccessToast = async (title: string, message = ""): Promise<void> => {
  await showToast({
    style: Toast.Style.Success,
    title,
    message,
  });
};

export const showHUD = async (message: string): Promise<void> => {
  await raycastShowHUB(message);
};
