From: Marcel Ziswiler <marcel-mitwqZ+T+m9Wk0Htik3J/w@public.gmane.org>
Subject: [REGRESSION] commit 0461a41 "spi: Pump transfers inside calling
 context for spi_sync()" breaks Apalis/Colibri T30 with MCP2515 SPI CAN
 controller
Date: Fri, 10 Apr 2015 15:00:53 +0200
Message-ID: <1428670853.7008.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Ziswiler <marcel-mitwqZ+T+m9Wk0Htik3J/w@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Christian Pellegrin <chripell-VaTbYqLCNhc@public.gmane.org>, "DavidS.Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hi there

Over Easter I had a look at our T30 hardware running latest mainline
kernels (both 4.0.0-rc7 as well as latest tegra for-next). Unfortunately
both just hang infinitely during boot (full logs attached below). Doing
a git bisection on that issue led to the following:

0461a4149836c792d186027c8c859637a4cfb11a is the first bad commit
commit 0461a4149836c792d186027c8c859637a4cfb11a
Author: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date:   Tue Dec 9 21:38:05 2014 +0000

    spi: Pump transfers inside calling context for spi_sync()

Reverting above commit makes them all fly again like before.

Unfortunately the commit message concerning standard SPI message pump
and all drivers being transitioned over to that did not ring any bell.

I also have not yet looked further into what exactly is happening and
whether or not the SPI stack, the Tegra SPI controller driver or the
MCP2515 SPI CAN driver is to blame but rather decided to ask Mr. Brown
and the community first for any insights they might have to share.
Anybody?

Cheers

Marcel

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.0.0-rc7-00042-ge5e02de
(zim-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org) (gcc version 4.7.2 20120910 (prerelease)
(crosstool-NG linaro-1.13.1-2012.09-20120921 - Linaro GCC 2012.09) ) #1
SMP PREEMPT Fri Apr 10 12:48:12 CEST 2015
[    0.000000] CPU: ARMv7 Processor [412fc099] revision 9 (ARMv7),
cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: Toradex Apalis T30 on Apalis Evaluation
Board
[    0.000000] cma: Reserved 64 MiB at 0xfb000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] PERCPU: Embedded 11 pages/cpu @edfc5000 s12672 r8192
d24192 u45056
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 519456
[    0.000000] Kernel command line: core_edp_mv=1300 usb_high_speed=1
ip=off root=/dev/mmcblk0p2 rw,noatime rootfstype=ext3 rootwait
igb_mac=00:14:2d:28:e6:ad consoleblank=0 no_console_suspend=1
console=tty1 console=ttyS0,115200n8 debug_uartport=lsport,0 vmalloc=256M
mem=2035M@2048M fbmem=12M@4083M video=tegrafb0:1920x1080-16@60
fbcon=map:1
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] Memory: 1991016K/2083840K available (6618K kernel code,
317K rwdata, 2256K rodata, 300K init, 351K bss, 27288K reserved, 65536K
cma-reserved, 1248256K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xef800000 - 0xff000000   ( 248 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef000000   ( 752 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc08b2cf4   (8876 kB)
[    0.000000]       .init : 0xc08b3000 - 0xc08fe000   ( 300 kB)
[    0.000000]       .data : 0xc08fe000 - 0xc094d7a0   ( 318 kB)
[    0.000000]        .bss : 0xc094d7a0 - 0xc09a53f0   ( 352 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Additional per-CPU info printed with stalls.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C: platform modifies aux control register: 0x02080000
-> 0x3e480001
[    0.000000] L2C: DT/platform modifies aux control register:
0x02080000 -> 0x3e480001
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310: enabling full line of zeros but not enabled in
Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode
enabled
[    0.000000] L2C-310 cache controller enabled, 8 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x7e480001
[    0.000017] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps
every 2147483648000ns
[    0.000050] Switching to timer-based delay loop, resolution 1000ns
[    0.001177] Console: colour dummy device 80x30
[    0.002114] console [tty1] enabled
[    0.002161] Calibrating delay loop (skipped), value calculated using
timer frequency.. 2.00 BogoMIPS (lpj=10000)
[    0.002218] pid_max: default: 32768 minimum: 301
[    0.002865] Mount-cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.002914] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.005300] Initializing cgroup subsys freezer
[    0.005371] Initializing cgroup subsys debug
[    0.005480] CPU: Testing write buffer coherency: ok
[    0.006018] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.006166] Setting up static identity map for 0x806451a0 -
0x80645238
[    0.040436] Tegra Unknown SKU 177
[    0.040503] Tegra Revision: A03 SKU: 177 CPU Process: 2 Core Process:
0
[    0.062022] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.081983] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.101969] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.102077] Brought up 4 CPUs
[    0.102192] SMP: Total of 4 processors activated (8.00 BogoMIPS).
[    0.102221] CPU: All CPU(s) started in SVC mode.
[    0.103633] devtmpfs: initialized
[    0.106469] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.112119] pinctrl core: initialized pinctrl subsystem
[    0.146102] NET: Registered protocol family 16
[    0.149142] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[    0.179980] cpuidle: using governor ladder
[    0.209977] cpuidle: using governor menu
[    0.243698] No ATAGs?
[    0.243756] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.243827] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.315941] 5v0: Failed to create debugfs directory
[    0.316701] usbo1_vbus: Failed to request enable GPIO157: -517
[    0.316966] reg-fixed-voltage regulators:regulator@2: Failed to
register regulator: -517
[    0.317039] platform regulators:regulator@2: Driver reg-fixed-voltage
requests probe deferral
[    0.317746] usbh_vbus: Failed to request enable GPIO233: -517
[    0.317998] reg-fixed-voltage regulators:regulator@3: Failed to
register regulator: -517
[    0.318067] platform regulators:regulator@3: Driver reg-fixed-voltage
requests probe deferral
[    0.321375] vgaarb: loaded
[    0.323770] SCSI subsystem initialized
[    0.325587] usbcore: registered new interface driver usbfs
[    0.325931] usbcore: registered new interface driver hub
[    0.326217] usbcore: registered new device driver usb
[    0.339281] vrtc: supplied by 5v0
[    0.349989] vdd_1v8_gen: supplied by 3v3
[    0.359987] vddio_ddr_1v35: supplied by 3v3
[    0.364536] vdd_pexa,vdd_pexb,vdd_sata: supplied by 3v3
[    0.373034] ldo1: supplied by vdd_1v8_gen
[    0.379978] en_3v3: supplied by vdd_1v8_gen
[    0.383601] avdd_dsi_csi,pwrdet_mipi: supplied by 3v3
[    0.389987] vdd_rtc: supplied by 3v3
[    0.399983] avdd_vdac: supplied by 3v3
[    0.403222] avdd_plle: supplied by vdd_1v8_gen
[    0.409981] avdd_pll: supplied by vdd_1v8_gen
[    0.419982] vdd_ddr_hs: supplied by vdd_1v8_gen
[    0.422119] stmpe-i2c 3-0041: stmpe811 detected, chip id: 0x811
[    0.427921] Linux video capture interface: v2.00
[    0.428179] pps_core: LinuxPPS API ver. 1 registered
[    0.428213] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.428383] PTP clock support registered
[    0.429861] Advanced Linux Sound Architecture Driver Initialized.
[    0.432283] Bluetooth: Core ver 2.20
[    0.432462] NET: Registered protocol family 31
[    0.432496] Bluetooth: HCI device and connection manager initialized
[    0.432556] Bluetooth: HCI socket layer initialized
[    0.432608] Bluetooth: L2CAP socket layer initialized
[    0.432703] Bluetooth: SCO socket layer initialized
[    0.434023] cfg80211: Calling CRDA to update world regulatory domain
[    0.435601] Switched to clocksource timer_us
[    0.475678] NET: Registered protocol family 2
[    0.477987] TCP established hash table entries: 8192 (order: 3, 32768
bytes)
[    0.478157] TCP bind hash table entries: 8192 (order: 4, 65536
bytes)
[    0.478370] TCP: Hash tables configured (established 8192 bind 8192)
[    0.479384] TCP: reno registered
[    0.479434] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.479528] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.480184] NET: Registered protocol family 1
[    0.481328] RPC: Registered named UNIX socket transport module.
[    0.481374] RPC: Registered udp transport module.
[    0.481402] RPC: Registered tcp transport module.
[    0.481429] RPC: Registered tcp NFSv4.1 backchannel transport
module.
[    0.485392] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7
counters available
[    0.489804] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.494274] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.499171] bounce: pool size: 64 pages
[    0.499229] io scheduler noop registered (default)
[    0.503226] tegra30-pinctrl 70000868.pinmux: invalid group
"uart3_cts_n_pa1" for function "rsvd1"
[    0.503766] tegra30-pinctrl 70000868.pinmux: invalid group "gpio_pu6"
for function "pwm3"
[    0.503848] tegra30-pinctrl 70000868.pinmux: does not have pin group
gpio_pu6
[    0.503889] tegra30-pinctrl 70000868.pinmux: could not map group
config for "gpio_pu6"
[    0.503947] tegra30-pinctrl 70000868.pinmux: invalid group "gpio_pu5"
for function "pwm2"
[    0.504022] tegra30-pinctrl 70000868.pinmux: does not have pin group
gpio_pu5
[    0.504059] tegra30-pinctrl 70000868.pinmux: could not map group
config for "gpio_pu5"
[    0.504115] tegra30-pinctrl 70000868.pinmux: invalid group "gpio_pu4"
for function "pwm1"
[    0.504186] tegra30-pinctrl 70000868.pinmux: does not have pin group
gpio_pu4
[    0.504223] tegra30-pinctrl 70000868.pinmux: could not map group
config for "gpio_pu4"
[    0.504278] tegra30-pinctrl 70000868.pinmux: invalid group "gpio_pu3"
for function "pwm0"
[    0.504349] tegra30-pinctrl 70000868.pinmux: does not have pin group
gpio_pu3
[    0.504386] tegra30-pinctrl 70000868.pinmux: could not map group
config for "gpio_pu3"
[    0.509853] tegra-pcie 3000.pcie-controller: 4x1, 1x2 configuration
[    0.512235] tegra-pcie 3000.pcie-controller: probing port 0, using 4
lanes
[    0.917348] tegra-pcie 3000.pcie-controller: link 0 down, retrying
[    1.323517] tegra-pcie 3000.pcie-controller: link 0 down, retrying
[    1.729677] tegra-pcie 3000.pcie-controller: link 0 down, retrying
[    1.731744] tegra-pcie 3000.pcie-controller: link 0 down, ignoring
[    1.731807] tegra-pcie 3000.pcie-controller: probing port 1, using 1
lanes
[    2.137967] tegra-pcie 3000.pcie-controller: link 1 down, retrying
[    2.544096] tegra-pcie 3000.pcie-controller: link 1 down, retrying
[    2.950229] tegra-pcie 3000.pcie-controller: link 1 down, retrying
[    2.952295] tegra-pcie 3000.pcie-controller: link 1 down, ignoring
[    2.952349] tegra-pcie 3000.pcie-controller: probing port 2, using 1
lanes
[    2.977373] tegra-pcie 3000.pcie-controller: PCI host bridge to bus
0000:00
[    2.977427] pci_bus 0000:00: root bus resource [mem
0x20000000-0x27ffffff]
[    2.977467] pci_bus 0000:00: root bus resource [mem
0x28000000-0x3fffffff pref]
[    2.977516] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.977551] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
[    2.978730] PCI: bus0: Fast back to back transfers disabled
[    2.978777] pci 0000:00:03.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    2.995747] PCI: bus1: Fast back to back transfers disabled
[    2.995908] pci 0000:00:03.0: BAR 8: assigned [mem
0x20000000-0x200fffff]
[    2.995953] pci 0000:00:03.0: BAR 7: assigned [io  0x1000-0x1fff]
[    2.995998] pci 0000:01:00.0: BAR 0: assigned [mem
0x20000000-0x2001ffff]
[    2.996041] pci 0000:01:00.0: BAR 3: assigned [mem
0x20020000-0x20023fff]
[    2.996081] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    2.996120] pci 0000:00:03.0: PCI bridge to [bus 01]
[    2.996153] pci 0000:00:03.0:   bridge window [io  0x1000-0x1fff]
[    2.996188] pci 0000:00:03.0:   bridge window [mem
0x20000000-0x200fffff]
[    2.996244] pci 0000:00:03.0: nv_msi_ht_cap_quirk didn't locate host
bridge
[    2.996450] pcieport 0000:00:03.0: enabling device (0140 -> 0143)
[    2.997160] pcieport 0000:00:03.0: Signaling PME through PCIe PME
interrupt
[    2.997206] pci 0000:01:00.0: Signaling PME through PCIe PME
interrupt
[    2.998095] backlight supply power not found, using dummy regulator
[    3.017130] tegra-apbdma 6000a000.dma: Tegra20 APB DMA driver
register 32 channels
[    3.018034] tegra-pmc 7000e400.pmc: i2c-thermtrip node not found,
emergency thermal reset disabled.
[    3.019296] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.025294] console [ttyS0] disabled
[    3.025397] 70006000.serial: ttyS0 at MMIO 0x70006000 (irq = 331,
base_baud = 25500000) is a Tegra
[    5.077693] console [ttyS0] enabled
[    5.089043] 70006040.serial: ttyTHS1 at MMIO 0x70006040 (irq = 332,
base_baud = 0) is a TEGRA_UART
[    5.105111] 70006200.serial: ttyTHS2 at MMIO 0x70006200 (irq = 333,
base_baud = 0) is a TEGRA_UART
[    5.121183] 70006300.serial: ttyTHS3 at MMIO 0x70006300 (irq = 334,
base_baud = 0) is a TEGRA_UART
[    5.139556] [drm] Initialized drm 1.1.0 20060810
[    5.150772] tegra-dc 54200000.dc: failed to probe RGB output: -517
[    5.162878] platform 54200000.dc: Driver tegra-dc requests probe
deferral
[    5.177016] 54280000.hdmi supply hdmi not found, using dummy
regulator
[    5.193122] panel supply power not found, using dummy regulator
[    5.228089] loop: module loaded
[    5.253390] CAN device driver interface
[    5.263459] spi32765.1 supply vdd not found, using dummy regulator
[    5.275675] spi32765.1 supply xceiver not found, using dummy
regulator

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.0.0-rc7-00042-ge5e02de
(zim-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org) (gcc version 4.7.2 20120910 (prerelease)
(crosstool-NG linaro-1.13.1-2012.09-20120921 - Linaro GCC 2012.09) ) #1
SMP PREEMPT Fri Apr 10 12:48:12 CEST 2015
[    0.000000] CPU: ARMv7 Processor [412fc099] revision 9 (ARMv7),
cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: Toradex Colibri T30 on Colibri Evaluation
Board
[    0.000000] cma: Reserved 64 MiB at 0xbb400000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] PERCPU: Embedded 11 pages/cpu @f67cf000 s12672 r8192
d24192 u45056
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 257312
[    0.000000] Kernel command line: core_edp_mv=1300 usb_high_speed=1
ip=off root=/dev/mmcblk0p2 rw,noatime rootfstype=ext3 rootwait asix_mac=
consoleblank=0 no_console_suspend=1 console=tty1 console=ttyS0,115200n8
debug_uartport=lsport,0 vmalloc=128M mem=1012M@2048M fbmem=12M@3060M
video=tegrafb0:640x480-16@60
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] Memory: 951692K/1036288K available (6618K kernel code,
317K rwdata, 2256K rodata, 300K init, 351K bss, 19060K reserved, 65536K
cma-reserved, 69632K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf7800000 - 0xff000000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf7000000   ( 880 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc08b2cf4   (8876 kB)
[    0.000000]       .init : 0xc08b3000 - 0xc08fe000   ( 300 kB)
[    0.000000]       .data : 0xc08fe000 - 0xc094d7a0   ( 318 kB)
[    0.000000]        .bss : 0xc094d7a0 - 0xc09a53f0   ( 352 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Additional per-CPU info printed with stalls.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C: platform modifies aux control register: 0x02080000
-> 0x3e480001
[    0.000000] L2C: DT/platform modifies aux control register:
0x02080000 -> 0x3e480001
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310: enabling full line of zeros but not enabled in
Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode
enabled
[    0.000000] L2C-310 cache controller enabled, 8 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x7e480001
[    0.000019] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps
every 2147483648000ns
[    0.000052] Switching to timer-based delay loop, resolution 1000ns
[    0.001128] Console: colour dummy device 80x30
[    0.002053] console [tty1] enabled
[    0.002099] Calibrating delay loop (skipped), value calculated using
timer frequency.. 2.00 BogoMIPS (lpj=10000)
[    0.002158] pid_max: default: 32768 minimum: 301
[    0.002809] Mount-cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.002858] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.005256] Initializing cgroup subsys freezer
[    0.005326] Initializing cgroup subsys debug
[    0.005435] CPU: Testing write buffer coherency: ok
[    0.005970] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.006122] Setting up static identity map for 0x806451a0 -
0x80645238
[    0.040409] Tegra Unknown SKU 177
[    0.040478] Tegra Revision: A03 SKU: 177 CPU Process: 2 Core Process:
0
[    0.062139] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.082099] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.102092] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.102203] Brought up 4 CPUs
[    0.102320] SMP: Total of 4 processors activated (8.00 BogoMIPS).
[    0.102350] CPU: All CPU(s) started in SVC mode.
[    0.103779] devtmpfs: initialized
[    0.106609] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.112539] pinctrl core: initialized pinctrl subsystem
[    0.141415] NET: Registered protocol family 16
[    0.145125] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[    0.169982] cpuidle: using governor ladder
[    0.199978] cpuidle: using governor menu
[    0.230486] No ATAGs?
[    0.230548] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.230618] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.295931] 5v0: Failed to create debugfs directory
[    0.296671] usbc_vbus: supplied by 5v0
[    0.297558] usbh_vbus: Failed to request enable GPIO178: -517
[    0.297826] reg-fixed-voltage regulators:regulator@3: Failed to
register regulator: -517
[    0.297899] platform regulators:regulator@3: Driver reg-fixed-voltage
requests probe deferral
[    0.301113] vgaarb: loaded
[    0.303550] SCSI subsystem initialized
[    0.305376] usbcore: registered new interface driver usbfs
[    0.305685] usbcore: registered new interface driver hub
[    0.305984] usbcore: registered new device driver usb
[    0.317997] vrtc: supplied by 5v0
[    0.329991] vdd_1v8_gen: supplied by 3v3
[    0.339986] vddio_ddr_1v35: supplied by 3v3
[    0.344173] vdd2: supplied by 3v3
[    0.353041] ldo1: supplied by vdd_1v8_gen
[    0.359978] en_3v3: supplied by vdd_1v8_gen
[    0.363206] ldo3: supplied by 3v3
[    0.369986] vdd_rtc: supplied by 3v3
[    0.379983] avdd_vdac: supplied by 3v3
[    0.383557] avdd_plle: supplied by vdd_1v8_gen
[    0.389981] avdd_pll: supplied by vdd_1v8_gen
[    0.399981] vdd_ddr_hs: supplied by vdd_1v8_gen
[    0.404369] Linux video capture interface: v2.00
[    0.404637] pps_core: LinuxPPS API ver. 1 registered
[    0.404670] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.404826] PTP clock support registered
[    0.406282] Advanced Linux Sound Architecture Driver Initialized.
[    0.408672] Bluetooth: Core ver 2.20
[    0.408854] NET: Registered protocol family 31
[    0.408889] Bluetooth: HCI device and connection manager initialized
[    0.408947] Bluetooth: HCI socket layer initialized
[    0.408999] Bluetooth: L2CAP socket layer initialized
[    0.409106] Bluetooth: SCO socket layer initialized
[    0.410494] cfg80211: Calling CRDA to update world regulatory domain
[    0.412059] Switched to clocksource timer_us
[    0.452268] NET: Registered protocol family 2
[    0.454608] TCP established hash table entries: 8192 (order: 3, 32768
bytes)
[    0.454778] TCP bind hash table entries: 8192 (order: 4, 65536
bytes)
[    0.454990] TCP: Hash tables configured (established 8192 bind 8192)
[    0.456007] TCP: reno registered
[    0.456059] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.456151] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.456825] NET: Registered protocol family 1
[    0.457994] RPC: Registered named UNIX socket transport module.
[    0.458041] RPC: Registered udp transport module.
[    0.458069] RPC: Registered tcp transport module.
[    0.458096] RPC: Registered tcp NFSv4.1 backchannel transport
module.
[    0.462006] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7
counters available
[    0.466412] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.471075] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.476067] bounce: pool size: 64 pages
[    0.476128] io scheduler noop registered (default)
[    0.484468] backlight supply power not found, using dummy regulator
[    0.503717] tegra-apbdma 6000a000.dma: Tegra20 APB DMA driver
register 32 channels
[    0.504544] tegra-pmc 7000e400.pmc: i2c-thermtrip node not found,
emergency thermal reset disabled.
[    0.505747] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.511615] console [ttyS0] disabled
[    0.511727] 70006000.serial: ttyS0 at MMIO 0x70006000 (irq = 329,
base_baud = 25500000) is a Tegra
[    1.946567] console [ttyS0] enabled
[    1.957859] 70006040.serial: ttyTHS1 at MMIO 0x70006040 (irq = 330,
base_baud = 0) is a TEGRA_UART
[    1.973928] 70006300.serial: ttyTHS2 at MMIO 0x70006300 (irq = 331,
base_baud = 0) is a TEGRA_UART
[    1.992198] [drm] Initialized drm 1.1.0 20060810
[    2.003457] tegra-dc 54200000.dc: failed to probe RGB output: -517
[    2.015567] platform 54200000.dc: Driver tegra-dc requests probe
deferral
[    2.029617] 54280000.hdmi supply hdmi not found, using dummy
regulator
[    2.045522] panel supply power not found, using dummy regulator
[    2.080700] loop: module loaded
[    2.099959] CAN device driver interface
[    2.110044] spi32766.0 supply vdd not found, using dummy regulator
[    2.122238] spi32766.0 supply xceiver not found, using dummy
regulator

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
