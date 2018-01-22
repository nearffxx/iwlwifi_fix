# SPDX-License-Identifier: GPL-2.0
# common
obj-$(CONFIG_IWLWIFI)	+= iwlwifi.o
iwlwifi-objs		+= iwl-io.o
iwlwifi-objs		+= iwl-drv.o
iwlwifi-objs		+= iwl-debug.o
iwlwifi-objs		+= iwl-eeprom-read.o iwl-eeprom-parse.o
iwlwifi-objs		+= iwl-phy-db.o iwl-nvm-parse.o
iwlwifi-objs		+= pcie/drv.o pcie/rx.o pcie/tx.o pcie/trans.o
iwlwifi-objs		+= pcie/ctxt-info.o pcie/trans-gen2.o pcie/tx-gen2.o
iwlwifi-$(CONFIG_IWLDVM) += cfg/1000.o cfg/2000.o cfg/5000.o cfg/6000.o
iwlwifi-$(CONFIG_IWLMVM) += cfg/7000.o cfg/8000.o cfg/9000.o cfg/a000.o
iwlwifi-objs		+= iwl-trans.o
iwlwifi-objs		+= fw/notif-wait.o
iwlwifi-$(CONFIG_IWLMVM) += fw/paging.o fw/smem.o fw/init.o fw/dbg.o
iwlwifi-$(CONFIG_IWLMVM) += fw/common_rx.o fw/nvm.o

iwlwifi-objs += $(iwlwifi-m)

iwlwifi-$(CONFIG_IWLWIFI_DEVICE_TRACING) += iwl-devtrace.o

ccflags-y += -I$(src)

obj-$(CONFIG_IWLDVM)	+= dvm/
obj-$(CONFIG_IWLMVM)	+= mvm/

CFLAGS_iwl-devtrace.o := -I$(src)

KSRC := /usr/lib/modules/`uname -r`/build

all:
	$(MAKE) -C $(KSRC) M=$(PWD) modules -j2
clean:
	$(MAKE) -C $(KSRC) M=$(PWD) clean
install:
	xz -kf iwlwifi.ko
	sudo cp iwlwifi.ko.xz /usr/lib/modules/`uname -r`/kernel/drivers/net/wireless/intel/iwlwifi
	xz -kf mvm/iwlmvm.ko
	sudo cp mvm/iwlmvm.ko.xz /usr/lib/modules/`uname -r`/kernel/drivers/net/wireless/intel/iwlwifi/mvm
	xz -kf dvm/iwldvm.ko
	sudo cp dvm/iwldvm.ko.xz /usr/lib/modules/`uname -r`/kernel/drivers/net/wireless/intel/iwlwifi/dvm
