load("//build/kernel/kleaf:kernel.bzl", "ddk_headers")
load("//build/kernel/oplus:oplus_modules_define.bzl", "define_oplus_ddk_module")
load("//build/kernel/oplus:oplus_modules_dist.bzl", "ddk_copy_to_dist_dir")

def define_oplus_local_modules():

    define_oplus_ddk_module(
        name = "oplus_bsp_dfr_keyevent_handler",
        srcs = native.glob([
            "**/*.h",
            "common/keyevent_handler/keyevent_handler.c",
        ]),
        includes = ["."],
    )

    define_oplus_ddk_module(
        name = "oplus_bsp_dfr_pmic_monitor",
        srcs = native.glob([
            "**/*.h",
            "qcom/qcom_pmic_monitor/oplus_pmic_info_smem.c",
            "qcom/qcom_pmic_monitor/main.c",
	    "qcom/qcom_pmic_monitor/oplus_pmic_machine_state.c",
	    "qcom/qcom_pmic_monitor/oplus_ocp_dev.c",
	    "qcom/qcom_pmic_monitor/oplus_ocp_state_nvmem.c",
        ]),
        includes = ["."],
    )

    define_oplus_ddk_module(
        name = "oplus_bsp_dfr_dump_device_info",
        srcs = native.glob([
            "**/*.h",
            "qcom/dump_device_info/dump_device_info.c",
        ]),
        includes = ["."],
    )

    define_oplus_ddk_module(
        name = "oplus_bsp_dfr_dump_reason",
        srcs = native.glob([
            "**/*.h",
            "qcom/dump_reason/dump_reason.c",
        ]),
        ko_deps = [
            "//vendor/oplus/kernel/dfr:oplus_bsp_dfr_dump_device_info",
        ],
        includes = ["."],
    )

    define_oplus_ddk_module(
        name = "oplus_bsp_dfr_pmic_watchdog",
        srcs = native.glob([
            "**/*.h",
            "qcom/qcom_pmicwd/qcom_pmicwd.c",
            "qcom/qcom_pmicwd/qcom_pwkpwr.c",
	    "qcom/qcom_pmicwd/qcom_pmicwd_inject.c",
        ]),
        includes = ["."],
    )

    ddk_copy_to_dist_dir(
        name = "oplus_bsp_dfr",
        module_list = [
            "oplus_bsp_dfr_keyevent_handler",
            "oplus_bsp_dfr_pmic_monitor",
            "oplus_bsp_dfr_dump_device_info",
            "oplus_bsp_dfr_dump_reason",
            "oplus_bsp_dfr_pmic_watchdog",
        ],
    )
