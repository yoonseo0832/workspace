import { toast } from "react-toastify";

export const topCenterAlert = (msg) => {
  toast(msg, { position: "top-center" });
};

export const bottomCenterAlert = (msg) => {
  toast(msg, { position: "bottom-center" });
};

export const successAlert = (msg) => {
  toast.success(msg);
};

export const errorAlert = (msg) => {
  toast.error(msg);
};
