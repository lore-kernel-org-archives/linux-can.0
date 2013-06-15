From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: Re: [Socketcan-users] [socketcan]problem to using CAN with BeagleBone
 Black A5A
Date: Sun, 16 Jun 2013 01:48:32 +0200
Message-ID: <CABMxt4ibf7VK1vAwQud2KCvnigg53cPXpCRn5Smy3gYzkgEx-Q@mail.gmail.com>
References: <zarafa.51b62efb.7aff.1ab85acd7547c22a@v14647.1blu.de>
	<51B6C3F1.7090608@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:58822 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710Ab3FOXse convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 15 Jun 2013 19:48:34 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so1506154lbh.23
        for <linux-can@vger.kernel.org>; Sat, 15 Jun 2013 16:48:32 -0700 (PDT)
In-Reply-To: <51B6C3F1.7090608@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

Hi Michael,

I fail to load the second can channel dcan1. I followed the
instructions mentionned in site but without success.
I can't find the source of problem.

Regards,
Mohamed

my kernel message log :
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.8.13-bone19 (root@pearl) (gcc version
4.7.3 20130226 (prerelease) (crosstool-NG
linaro-1.13.1-4.7-2013.03-20130313 - Linaro GCC 2013.03) ) #1 SMP
PREEMPT Mon Jun 3 15:59:59 CEST 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D=
10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model:
TI AM335x BeagleBone
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 130816
[    0.000000] free_area_init_node: node 0, pgdat c0971bc0,
node_mem_map c09eb000
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 129792 pages, LIFO batch:31
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0dfa000 s14208 r8192 d144=
64 u36864
[    0.000000] pcpu-alloc: s14208 r8192 d14464 u36864 alloc=3D9*4096
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 129792
[    0.000000] Kernel command line: console=3DttyO0,115200n8
root=3D/dev/mmcblk0p2 rw rootfstype=3Dext4 rootwait fixrtc
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] allocated 1048576 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't
want memory cgroups
[    0.000000] Memory: 511MB =3D 511MB total
[    0.000000] Memory: 507456k/507456k available, 16832k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc08a90a4   (8837 kB)
[    0.000000]       .init : 0xc08aa000 - 0xc08f2780   ( 290 kB)
[    0.000000]       .data : 0xc08f4000 - 0xc09749f0   ( 515 kB)
[    0.000000]        .bss : 0xc09749f0 - 0xc09eaa7c   ( 473 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D1.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with
128 interrupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 24000000 Hz
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps
every 178956ms
[    0.000000] OMAP clocksource: GPTIMER2 at 24000000 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000423] Calibrating delay loop... 363.67 BogoMIPS (lpj=3D354304)
[    0.017364] pid_max: default: 32768 minimum: 301
[    0.017636] Security Framework initialized
[    0.017746] Mount-cache hash table entries: 512
[    0.028252] Initializing cgroup subsys cpuacct
[    0.028291] Initializing cgroup subsys memory
[    0.028363] Initializing cgroup subsys blkio
[    0.028523] CPU: Testing write buffer coherency: ok
[    0.029209] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.029289] Setting up static identity map for 0x805fe250 - 0x805fe2=
a8
[    0.048637] Brought up 1 CPUs
[    0.048664] SMP: Total of 1 processors activated (363.67 BogoMIPS).
[    0.049932] devtmpfs: initialized
[    0.114898] pinctrl core: initialized pinctrl subsystem
[    0.115209] rstctl core: initialized rstctl subsystem
[    0.115750] regulator-dummy: no parameters
[    0.116334] NET: Registered protocol family 16
[    0.117272] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.127437] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 =
size 568
[    0.128261] platform 49000000.edma: alias fck already exists
[    0.128295] platform 49000000.edma: alias fck already exists
[    0.128323] platform 49000000.edma: alias fck already exists
[    0.129580] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.129782] OMAP GPIO hardware version 0.1
[    0.131367] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.132754] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.134125] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.134839] of_get_named_gpio_flags exited with status 52
[    0.134873] gpio-rctrl rstctl.3: loaded OK
[    0.136845] platform 481d0000.d_can: alias fck already exists
[    0.141201] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.143488] cpsw.0: No hwaddr in dt. Using c8:a0:30:af:d7:87 from ef=
use
[    0.143523] cpsw.1: No hwaddr in dt. Using c8:a0:30:af:d7:89 from ef=
use
[    0.158608] bio: create slab <bio-0> at 0
[    0.170881] edma-dma-engine edma-dma-engine.0: TI EDMA DMA engine dr=
iver
[    0.171127] of_get_named_gpio_flags: can't parse gpios property
[    0.171352] vmmcsd_fixed: 3300 mV
[    0.174487] SCSI subsystem initialized
[    0.174939] usbcore: registered new interface driver usbfs
[    0.175056] usbcore: registered new interface driver hub
[    0.175397] usbcore: registered new device driver usb
[    0.177735] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
[    0.180333] DCDC1: at 1500 mV
[    0.181685] vdd_mpu: 925 <--> 1325 mV at 1100 mV
[    0.182905] vdd_core: 925 <--> 1150 mV at 1100 mV
[    0.184222] LDO1: at 1800 mV
[    0.185486] LDO2: at 3300 mV
[    0.187624] LDO3: 1800 mV
[    0.188817] LDO4: at 3300 mV
[    0.189987] tps65217 0-0024: TPS65217 ID 0xe version 1.2
[    0.190809] omap_i2c 44e0b000.i2c: unable to select pin group
[    0.191740] omap_i2c 4819c000.i2c: bus 1 rev0.11 at 100 kHz
[    0.194596] omap_i2c 4819c000.i2c: unable to select pin group
[    0.194845] media: Linux media interface: v0.10
[    0.194954] Linux video capture interface: v2.00
[    0.195852] Advanced Linux Sound Architecture Driver Initialized.
[    0.196904] NetLabel: Initializing
[    0.196925] NetLabel:  domain hash size =3D 128
[    0.196938] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.197203] NetLabel:  unlabeled traffic allowed by default
[    0.197525] Switching to clocksource gp_timer
[    0.258408] NET: Registered protocol family 2
[    0.259558] TCP established hash table entries: 4096 (order: 3, 3276=
8 bytes)
[    0.259706] TCP bind hash table entries: 4096 (order: 4, 81920 bytes=
)
[    0.259870] TCP: Hash tables configured (established 4096 bind 4096)
[    0.259975] TCP: reno registered
[    0.260004] UDP hash table entries: 256 (order: 1, 12288 bytes)
[    0.260051] UDP-Lite hash table entries: 256 (order: 1, 12288 bytes)
[    0.260576] NET: Registered protocol family 1
[    0.261274] RPC: Registered named UNIX socket transport module.
[    0.261297] RPC: Registered udp transport module.
[    0.261311] RPC: Registered tcp transport module.
[    0.261325] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.262666] CPU PMU: probing PMU on CPU 0
[    0.262704] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver,
5 counters available
[    0.263256] omap2_mbox_probe: platform not supported
[    0.503080] VFS: Disk quotas dquot_6.5.2
[    0.503344] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    0.504803] NFS: Registering the id_resolver key type
[    0.504921] Key type id_resolver registered
[    0.504940] Key type id_legacy registered
[    0.505018] fuse init (API version 7.20)
[    0.505953] Btrfs loaded
[    0.506146] msgmni has been set to 991
[    0.509651] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 250)
[    0.509679] io scheduler noop registered
[    0.509694] io scheduler deadline registered
[    0.509752] io scheduler cfq registered (default)
[    0.511616] tps65217-bl tps65217-bl: no platform data provided
[    0.511661] tps65217-bl: probe of tps65217-bl failed with error -22
[    0.512716] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.515460] omap_uart 44e09000.serial: did not get pins for uart0 er=
ror: -19
[    0.515810] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq =3D 88) i=
s
a OMAP UART0
[    1.231952] console [ttyO0] enabled
[    1.236771] [drm] Initialized drm 1.1.0 20060810
[    1.255922] brd: module loaded
[    1.266584] loop: module loaded
[    1.270058] at24 0-0050: 32768 byte 24c256 EEPROM, writable, 1 bytes=
/write
[    1.277376] at24 1-0054: 32768 byte 24c256 EEPROM, writable, 1 bytes=
/write
[    1.284673] at24 1-0055: 32768 byte 24c256 EEPROM, writable, 1 bytes=
/write
[    1.291971] at24 1-0056: 32768 byte 24c256 EEPROM, writable, 1 bytes=
/write
[    1.299262] at24 1-0057: 32768 byte 24c256 EEPROM, writable, 1 bytes=
/write
[    1.313442] bone-capemgr bone_capemgr.9: Baseboard:
'A335BNLT,0A5A,1713BBBK0838'
[    1.321261] bone-capemgr bone_capemgr.9:
compatible-baseboard=3Dti,beaglebone-black
[    2.328829] omap_i2c 4819c000.i2c: controller timed out
[    3.338303] omap_i2c 4819c000.i2c: controller timed out
[    3.350003] bone-capemgr bone_capemgr.9: slot #0: No cape found
[    4.355874] omap_i2c 4819c000.i2c: controller timed out
[    5.367853] omap_i2c 4819c000.i2c: controller timed out
[    5.379299] bone-capemgr bone_capemgr.9: slot #1: No cape found
[    6.385167] omap_i2c 4819c000.i2c: controller timed out
[    7.396932] omap_i2c 4819c000.i2c: controller timed out
[    7.408594] bone-capemgr bone_capemgr.9: slot #2: No cape found
[    8.414674] omap_i2c 4819c000.i2c: controller timed out
[    9.426231] omap_i2c 4819c000.i2c: controller timed out
[    9.437890] bone-capemgr bone_capemgr.9: slot #3: No cape found
[    9.444185] bone-capemgr bone_capemgr.9: slot #4: specific override
[    9.450802] bone-capemgr bone_capemgr.9: bone: Using override
eeprom data at slot 4
[    9.458851] bone-capemgr bone_capemgr.9: slot #4:
'Bone-LT-eMMC-2G,00A0,Texas Instrument,BB-BONE-EMMC-2G'
[    9.469031] bone-capemgr bone_capemgr.9: slot #5: specific override
[    9.475646] bone-capemgr bone_capemgr.9: bone: Using override
eeprom data at slot 5
[    9.483695] bone-capemgr bone_capemgr.9: slot #5:
'Bone-Black-HDMI,00A0,Texas Instrument,BB-BONELT-HDMI'
[    9.494199] bone-capemgr bone_capemgr.9: loader: before slot-4
BB-BONE-EMMC-2G:00A0 (prio 1)
[    9.503131] bone-capemgr bone_capemgr.9: initialized OK.
[    9.508747] bone-capemgr bone_capemgr.9: loader: before slot-5
BB-BONELT-HDMI:00A0 (prio 1)
[    9.519644] OneNAND driver initializing
[    9.523814] bone-capemgr bone_capemgr.9: loader: check slot-4
BB-BONE-EMMC-2G:00A0 (prio 1)
[    9.532617] bone-capemgr bone_capemgr.9: loader: check slot-5
BB-BONELT-HDMI:00A0 (prio 1)
[    9.542775] usbcore: registered new interface driver cdc_ether
[    9.548974] bone-capemgr bone_capemgr.9: loader: after slot-4
BB-BONE-EMMC-2G:00A0 (prio 1)
[    9.557854] usbcore: registered new interface driver rndis_host
[    9.564114] bone-capemgr bone_capemgr.9: loader: after slot-5
BB-BONELT-HDMI:00A0 (prio 1)
[    9.572977] usbcore: registered new interface driver cdc_ncm
[    9.578978] bone-capemgr bone_capemgr.9: slot #4: Requesting
firmware 'cape-bone-2g-emmc1.dtbo' for board-name 'Bone-LT-eMMC-2G',
version '00A0'
[    9.593368] Initializing USB Mass Storage driver...
[    9.598699] usbcore: registered new interface driver usb-storage
[    9.605060] bone-capemgr bone_capemgr.9: slot #4: dtbo
'cape-bone-2g-emmc1.dtbo' loaded; converting to live tree
[    9.615743] USB Mass Storage support registered.
[    9.620800] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[    9.627191] bone-capemgr bone_capemgr.9: slot #5: Requesting
firmware 'cape-boneblack-hdmi-00A0.dtbo' for board-name
'Bone-Black-HDMI', version '00A0'
[    9.641645] bone-capemgr bone_capemgr.9: slot #4: #2 overlays
[    9.648149] musb-hdrc musb-hdrc.0.auto: pdev->id =3D 0
[    9.653752] bone-capemgr bone_capemgr.9: slot #4: Applied #2 overlay=
s.
[    9.660652] musb-hdrc musb-hdrc.0.auto:
drivers/usb/musb/musb_dsps.c:462 dsps_musb_init: OK
[    9.669453] bone-capemgr bone_capemgr.9: slot #5: dtbo
'cape-boneblack-hdmi-00A0.dtbo' loaded; converting to live tree
[    9.680695] bone-capemgr bone_capemgr.9: loader: done slot-4
BB-BONE-EMMC-2G:00A0 (prio 1)
[    9.689406] musb-hdrc: ConfigData=3D0xde (UTMI-8, dyn FIFOs, bulk
combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
[    9.689427] musb-hdrc: MHDRC RTL version 2.0
[    9.689442] musb-hdrc: setup fifo_mode 4
[    9.689469] musb-hdrc: 28/31 max ep, 16384/16384 memory
[    9.689621] musb-hdrc musb-hdrc.0.auto: *** mode=3D3
[    9.695783] musb-hdrc musb-hdrc.0.auto: *** power=3D250
[    9.701401] bone-capemgr bone_capemgr.9: slot #5: #4 overlays
[    9.708278] musb-hdrc musb-hdrc.1.auto: pdev->id =3D 1
[    9.715967] platform 4830e000.fb: alias fck already exists
[    9.721825] musb-hdrc musb-hdrc.1.auto:
drivers/usb/musb/musb_dsps.c:462 dsps_musb_init: OK
[    9.732365] bone-capemgr bone_capemgr.9: slot #5: Applied #4 overlay=
s.
[    9.739313] musb-hdrc: ConfigData=3D0xde (UTMI-8, dyn FIFOs, bulk
combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
[    9.739334] musb-hdrc: MHDRC RTL version 2.0
[    9.739348] musb-hdrc: setup fifo_mode 4
[    9.739373] musb-hdrc: 28/31 max ep, 16384/16384 memory
[    9.739520] musb-hdrc musb-hdrc.1.auto: *** mode=3D1
[    9.744597] bone-capemgr bone_capemgr.9: loader: done slot-5
BB-BONELT-HDMI:00A0 (prio 1)
[    9.753184] musb-hdrc musb-hdrc.1.auto: *** power=3D250
[    9.758514] musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
[    9.765164] musb-hdrc musb-hdrc.1.auto: new USB bus registered,
assigned bus number 1
[    9.773510] musb-hdrc musb-hdrc.1.auto: supports USB remote wakeup
[    9.773642] usb usb1: default language 0x0409
[    9.773707] usb usb1: udev 1, busnum 1, minor =3D 0
[    9.773730] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    9.780930] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    9.788564] usb usb1: Product: MUSB HDRC host driver
[    9.793839] usb usb1: Manufacturer: Linux 3.8.13-bone19 musb-hcd
[    9.800201] usb usb1: SerialNumber: musb-hdrc.1.auto
[    9.806253] usb usb1: usb_probe_device
[    9.806282] usb usb1: configuration #1 chosen from 1 choice
[    9.806359] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[    9.806576] hub 1-0:1.0: usb_probe_interface
[    9.806600] hub 1-0:1.0: usb_probe_interface - got id
[    9.806635] hub 1-0:1.0: USB hub found
[    9.810702] hub 1-0:1.0: 1 port detected
[    9.814893] hub 1-0:1.0: standalone hub
[    9.814914] hub 1-0:1.0: individual port power switching
[    9.814933] hub 1-0:1.0: no over-current protection
[    9.814951] hub 1-0:1.0: Single TT
[    9.814972] hub 1-0:1.0: TT requires at most 8 FS bit times (666 ns)
[    9.814992] hub 1-0:1.0: power on to power good time: 10ms
[    9.815040] hub 1-0:1.0: local power source is good
[    9.815180] hub 1-0:1.0: enabling power on all ports
[    9.821613] mousedev: PS/2 mouse device common for all mice
[    9.829877] omap_rtc 44e3e000.rtc: rtc core: registered 44e3e000.rtc=
 as rtc0
[    9.837745] i2c /dev entries driver
[    9.842954] Driver for 1-wire Dallas network protocol.
[    9.849929] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout =
60 sec
[    9.857564] cpuidle: using governor ladder
[    9.861907] cpuidle: using governor menu
[    9.866461] of_get_named_gpio_flags: can't parse gpios property
[    9.866482] of_get_named_gpio_flags: can't parse gpios property
[    9.866498] of_get_named_gpio_flags: can't parse gpios property
[    9.866535] omap_hsmmc mmc.4: of_parse_phandle_with_args of 'reset' =
failed
[    9.873785] omap_hsmmc mmc.4: Failed to get rstctl; not using any
[    9.880223] omap_hsmmc mmc.4: unable to select pin group
[    9.886103] edma-dma-engine edma-dma-engine.0: allocated channel for=
 0:25
[    9.893346] edma-dma-engine edma-dma-engine.0: allocated channel for=
 0:24
[    9.900780] mmc.4 supply vmmc_aux not found, using dummy regulator
[    9.907453] omap_hsmmc mmc.4: pins are not configured from the drive=
r
[    9.916551] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
[    9.916645] hub 1-0:1.0: hub_suspend
[    9.916689] usb usb1: bus auto-suspend, wakeup 1
[    9.941980] of_get_named_gpio_flags: can't parse gpios property
[    9.942003] of_get_named_gpio_flags: can't parse gpios property
[    9.942019] of_get_named_gpio_flags: can't parse gpios property
[    9.942073] gpio-rctrl rstctl.3: gpio_rctrl_request eMMC_RSTn
[    9.948322] omap_hsmmc mmc.5: Got rstctl (gpio:#0 name eMMC_RSTn)
label:eMMC_RSTn
[    9.956278] gpio-rctrl rstctl.3: gpio_rctrl_deassert eMMC_RSTn
[    9.962860] edma-dma-engine edma-dma-engine.0: allocated channel for=
 0:3
[    9.970062] edma-dma-engine edma-dma-engine.0: allocated channel for=
 0:2
[    9.977785] mmc.5 supply vmmc_aux not found, using dummy regulator
[    9.984498] omap_hsmmc mmc.5: pins are not configured from the drive=
r
[   10.018711] pinctrl-single 44e10800.pinmux: pin 44e10854 already
requested by 44e10800.pinmux; cannot claim for gpio-leds.8
[   10.030432] pinctrl-single 44e10800.pinmux: pin-21 (gpio-leds.8) sta=
tus -22
[   10.037787] pinctrl-single 44e10800.pinmux: could not request pin
21 on device pinctrl-single
[   10.046806] leds-gpio gpio-leds.8: pins are not configured from the =
driver
[   10.054101] of_get_named_gpio_flags exited with status 53
[   10.054128] of_get_named_gpio_flags exited with status 54
[   10.054150] of_get_named_gpio_flags exited with status 55
[   10.054172] of_get_named_gpio_flags exited with status 56
[   10.054229] of_get_named_gpio_flags exited with status 53
[   10.054473] of_get_named_gpio_flags exited with status 54
[   10.054768] of_get_named_gpio_flags exited with status 55
[   10.055068] of_get_named_gpio_flags exited with status 56
[   10.055588] ledtrig-cpu: registered to indicate activity on CPUs
[   10.062552] edma-dma-engine edma-dma-engine.0: allocated channel for=
 0:36
[   10.069890] omap-sham 53100000.sham: hw accel on OMAP rev 4.3
[   10.078775] omap-aes 53500000.aes: OMAP AES hw accel rev: 3.2
[   10.085189] edma-dma-engine edma-dma-engine.0: allocated channel for=
 0:5
[   10.092363] mmc0: host does not support reading read-only switch.
assuming write-enable.
[   10.101068] edma-dma-engine edma-dma-engine.0: allocated channel for=
 0:6
[   10.109441] usbcore: registered new interface driver usbhid
[   10.115512] mmc0: new high speed SDHC card at address aaaa
[   10.122298] usbhid: USB HID core driver
[   10.126519] mmcblk0: mmc0:aaaa SU04G 3.69 GiB
[   10.135522] of_get_named_gpio_flags exited with status 59
[   10.135949]  mmcblk0: p1 p2
[   10.140954] davinci_evm sound.13:  nxp-hdmi-hifi <-> 48038000.mcasp
mapping ok
[   10.154246] TCP: cubic registered
[   10.157991] NET: Registered protocol family 10
[   10.164523] NET: Registered protocol family 17
[   10.169853] Key type dns_resolver registered
[   10.174728] VFP support v0.3: implementor 41 architecture 3 part 30
variant c rev 3
[   10.183023] ThumbEE CPU extension supported.
[   10.187639] Registering SWP/SWPB emulation handler
[   10.193959] registered taskstats version 1
[   10.200950] of_get_named_gpio_flags: can't parse gpios property
[   10.200987] tilcdc 4830e000.fb: No power control GPIO
[   10.232553] mmc1: BKOPS_EN bit is not set
[   10.239552] mmc1: new high speed MMC card at address 0001
[   10.246117] mmcblk1: mmc1:0001 MMC02G 1.78 GiB
[   10.251442] mmcblk1boot0: mmc1:0001 MMC02G partition 1 1.00 MiB
[   10.258083] mmcblk1boot1: mmc1:0001 MMC02G partition 2 1.00 MiB
[   10.267020]  mmcblk1: p1 p2
[   10.273146]  mmcblk1boot1: unknown partition table
[   10.280519]  mmcblk1boot0: unknown partition table
[   10.320222] tilcdc 4830e000.fb: found TDA19988
[   10.325749] [drm] Supports vblank timestamp caching Rev 1 (10.10.201=
0).
[   10.332711] [drm] No driver support for vblank timestamp query.
[   10.339361] tilcdc 4830e000.fb: No connectors reported connected wit=
h modes
[   10.346705] [drm] Cannot find any crtc or sizes - going 1024x768
[   10.367356] Console: switching to colour frame buffer device 128x48
[   10.383440] tilcdc 4830e000.fb: fb0:  frame buffer device
[   10.389244] tilcdc 4830e000.fb: registered panic notifier
[   10.394966] [drm] Initialized tilcdc 1.0.0 20121205 on minor 0
[   10.451622] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[   10.458059] davinci_mdio 4a101000.mdio: detected phy mask fffffffe
[   10.465840] libphy: 4a101000.mdio: probed
[   10.470215] davinci_mdio 4a101000.mdio: phy[0]: device
4a101000.mdio:00, driver SMSC LAN8710/LAN8720
[   10.480117] Detected MACID =3D c8:a0:30:af:d7:87
[   10.484896] cpsw 4a100000.ethernet: NAPI disabled
[   10.492033] omap_rtc 44e3e000.rtc: setting system clock to
2000-01-01 00:00:01 UTC (946684801)
[   10.504694] ALSA device list:
[   10.507849]   #0: TI BeagleBone Black
[   10.710902] EXT4-fs (mmcblk0p2): warning: maximal mount count
reached, running e2fsck is recommended
[   10.723573] EXT4-fs (mmcblk0p2): recovery complete
[   10.730774] EXT4-fs (mmcblk0p2): mounted filesystem with ordered
data mode. Opts: (null)
[   10.739335] VFS: Mounted root (ext4 filesystem) on device 179:2.
[   10.747420] devtmpfs: mounted
[   10.751000] Freeing init memory: 288K
here i load the c_can driver:
[  193.453878] CAN device driver interface
[  193.470342] c_can_platform 481d0000.d_can: invalid resource
[  193.476750] c_can_platform 481d0000.d_can: control memory is not
used for raminit
[  193.485588] c_can_platform 481d0000.d_can: c_can_platform device
registered (regs=3Dfa1d0000, irq=3D71)

On Tue, Jun 11, 2013 at 8:30 AM, Wolfgang Grandegger <wg@grandegger.com=
> wrote:
> On 06/10/2013 09:54 PM, Michael Luxen wrote:
>> Hello Wolfgang,
>>
>> from the Raspberry Pi point of view I can say that I've patched alre=
ady the original raspbmc based kernel MCP251x driver to the MCP2515 asy=
nchronous of Andre B. Oliveira. I've also patched the raspbmc SPI drive=
r to use DMA mode for low latency issues.
>> With these modifications the MCP2515 runs on my setup with the Raspi=
 without any message lost. Also with busload >50% @ 1000kbit/s.
>
> Ah, I was not aware of that. What about pushing these modifications t=
o
> mainline? We would assist in getting it accepted.
>
>> More details for Raspi users can be found here:
>> http://elinux.org/RPi_CANBus
>>
>> But keep in mind as soon as a second MCP2515 is used on the MCP2515 =
one of them stops sending/receiving after a few seconds as the ISR seem=
s to hang.
>
> OK, sounds more like a hardware problem.
>
> Wolfgang.
>
>> Regards
>> Mike
>>
>> -----Urspr=FCngliche Nachricht-----
>> Von:  Wolfgang Grandegger <wg@grandegger.com>
>> Gesendet:     Mo 10.06.2013 19:50
>> Betreff:      Re: [Socketcan-users] [socketcan]problem to using CAN =
with BeagleBone Black A5A
>> An:   Michael Luxen <mluxen@gmx.net>;
>> CC:   Oliver Hartkopp <socketcan@hartkopp.net>; linux-can@vger.kerne=
l.org;
>>> On 06/10/2013 06:24 PM, Michael Luxen wrote:
>>> ...
>>>>>> I'm not sure about the cpu-load, latency and messages lost probl=
ems. My
>>>>> experience on the RasperryPi is that 2x MCP2515 on one SPI-Channe=
l doesn't
>>> work
>>>>> with busload above 10% at 500kbit/s.
>>>>>
>>>>> That's not that much. But it's an interesting information to get =
an
>>> estimation
>>>>> what one might get with this setup.
>>>> But keep in mind that the Raspi has only one SPI channel where I'v=
e connected
>>> two MCP2515 (only independetn ChipSelect and Interrupt lines). Ther=
efore I'm
>>> interested in to sees how the BeagleBone Black can handle two MCP25=
15 on
>>> idenpendent SPI channels (SPI1/SPI2).
>>>
>>> The problem is not (only) SPI hardware but software. The CAN messag=
es
>>> are not read-out quickly enough due to latencies resulting in messa=
ge
>>> losses. May user do report that problem with the MPC251x. The follo=
wing
>>> link does have some nice figures:
>>>
>>>   http://clientes.netvisao.pt/anbadeol/mcp2515.html
>>>
>>> I think the software can do better but still latency is critical fo=
r the
>>> MPC251x, especialy MPC2510.
>>>
>>> Wolfgang.
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>> Regards
>>>> Mike
>>>>
>>>>>> -----Urspr=FCngliche Nachricht-----
>>>>>> Von:      Oliver Hartkopp <socketcan@hartkopp.net>
>>>>>> Gesendet: Sa 08.06.2013 13:46
>>>>>> Betreff:  Re: AW: [Socketcan-users] [socketcan]problem to using =
CAN with
>>>>> BeagleBone Black A5A
>>>>>> An:       Michael Luxen <mluxen@gmx.net>;
>>>>>> CC:       linux-can@vger.kernel.org;
>>>>>>> Hello Mike,
>>>>>>>
>>>>>>> thanks for pointing to that comprehensive documentation.
>>>>>>>
>>>>>>> I was asked by a colleague how to get both internal CAN control=
lers working
>>>>>>> instead of adding SPI-based MCP2515 interfaces.
>>>>>>>
>>>>>>> Good job!
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Oliver
>>>>>>>
>>>>>>> On 07.06.2013 21:46, Michael Luxen wrote:
>>>>>>>> Hello Mohamed,
>>>>>>>>
>>>>>>>> is you question still open or answered already?
>>>>>>>>
>>>>>>>> If still open, please have a look on this page where you can f=
ind how to
>>>>>>> enable the CAN-Devices on BeagleBone Black.
>>>>>>>> http://www.aero-box.co.uk/beaglebone-black#TOC-Enable-CANbus-d=
evice
>>>>>>>>
>>>>>>>> The only thing you have to do is to edit the am335x-bone-commo=
n.dtsi file
>>>>> for
>>>>>>> enabling dcan0 and/or dcan1.
>>>>>>>> Please have in mind that dcan0 is normaly used for the optiona=
l Capes, as
>>>>>>> they use the I2C2 pins which are muxed on the same pins than dc=
an0.
>>>>>>>> Nevertheless I've edited am335x-bone-common.dtsi successfully =
to enable
>>>>> dcan0
>>>>>>> and dcan1. On my BeagleBone Black (Hardware A5A) eveything is r=
unning fine
>>>>> on
>>>>>>> both internal CAN-Interfaces with latest Angstrom and latest De=
bian as
>>> well.
>>>>>>>> Keep in mind that you have to put a CAN-transceiver on the Pin=
s 20/19
>>>>> (DCAN0)
>>>>>>> an 24/26 (DCAN1) on your BeagleBone Black.
>>>>>>>>
>>>>>>>> Regards
>>>>>>>> Mike
>>>>>>>>
>>>>>>>> -----Urspr=FCngliche Nachricht-----
>>>>>>>> Von:    Martin Gysel <m.gysel@gmail.com>
>>>>>>>> Gesendet:       Di 04.06.2013 13:32
>>>>>>>> Betreff:        Re: [Socketcan-users] [socketcan]problem to us=
ing CAN with
>>>>>>> BeagleBone Black A5A
>>>>>>>> An:     linux-can@vger.kernel.org;
>>>>>>>> CC:     socketcan-users@lists.berlios.de;
>>>>>>>>> Am 25.05.2013 00:49, schrieb Mohamed HAMZAOUI:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> I started with beaglebone black A5A, i installed on it the l=
atest
>>>>>>>>>> Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May=
 20
>>>>>>>>>> 17:07:58 CEST 2013 armv7l GNU/Linux
>>>>>>>>>>
>>>>>>>>>> I have a problem when I try to add a can device, i load with=
 modprobe
>>>>>>>>>> all necessary kernel module (can, ti_hecc, c_can, c_can_plat=
form,
>>>>>>>>>> can-raw, can-bcm) but when i execute
>>>>>>>>>>> ip link add can0 type can
>>>>>>>>>> I have : RTNETLINK answers: Operation not supported
>>>>>>>>>> I used a recent version of iproute2.
>>>>>>>>>
>>>>>>>>> did you initialize the can module? do you use a can cape? if =
yes, does
>>>>>>>>> your kernel already include the needed dts to enable the can =
module?
>>>>>>>>>
>>>>>>>>> /martin
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe lin=
ux-can" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe linu=
x-can" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.=
html
>>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux=
-can" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
>>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-=
can" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-c=
an" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-ca=
n" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>
>>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
