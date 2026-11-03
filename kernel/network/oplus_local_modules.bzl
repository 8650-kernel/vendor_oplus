load("//build/kernel/kleaf:kernel.bzl", "ddk_headers")
load("//build/kernel/oplus:oplus_modules_define.bzl", "define_oplus_ddk_module")
load("//build/kernel/oplus:oplus_modules_dist.bzl", "ddk_copy_to_dist_dir")

def define_oplus_local_modules():

    define_oplus_ddk_module(
        name = "oplus_network_rf_cable_monitor",
        srcs = native.glob([
            "**/*.h",
            "oplus_rf_cable_monitor/oplus_rf_cable_monitor.c",
        ]),
        conditional_defines = {
            "qcom":  ["QCOM_PLATFORM"],
        },
        includes = ["."],
    )

    define_oplus_ddk_module(
        name = "oplus_network_oem_qmi",
        srcs = native.glob([
            "**/*.h",
            "oplus_network_oem_qmi/oem_qmi_client.c",
        ]),
        conditional_defines = {
            "qcom":  ["QCOM_PLATFORM"],
        },
        includes = ["."],
    )

    define_oplus_ddk_module(
        name = "oplus_network_esim",
        srcs = native.glob([
            "**/*.h",
            "oplus_network_esim/oplus_network_esim.c",
        ]),
        ko_deps = [
            "//vendor/oplus/kernel/network:oplus_network_oem_qmi",
        ],
        conditional_defines = {
            "qcom":  ["QCOM_PLATFORM"],
        },
        includes = ["."],
    )

    define_oplus_ddk_module(
        name = "oplus_network_sim_detect",
        srcs = native.glob([
            "**/*.h",
            "oplus_network_sim_detect/sim_detect.c",
        ]),
        ko_deps = [
            "//vendor/oplus/kernel/network:oplus_network_oem_qmi",
        ],
        conditional_defines = {
            "qcom":  ["QCOM_PLATFORM"],
        },
        includes = ["."],
    )

    ddk_headers(
        name = "config_headers",
        hdrs  = native.glob([
            "**/*.h",
        ]),
        includes = ["."],
    )

    ddk_copy_to_dist_dir(
        name = "oplus_network",
        module_list = [
            "oplus_network_rf_cable_monitor",
            "oplus_network_oem_qmi",
            "oplus_network_esim",
            "oplus_network_sim_detect",
        ],
    )
