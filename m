From: Michael Muldoon <mbmuldoon07@gmail.com>
Subject: Re: can acknowledgment
Date: Thu, 5 Sep 2013 15:45:47 -0400
Message-ID: <CAJU5jUKkim-Pp5=VZjUfKUfRYB8b8zufwh9jtYFnhAcaYNgN5w@mail.gmail.com>
References: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com>
	<11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp>
	<CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com>
	<818b112277dbc87b883edf93f165ecff@grandegger.com>
	<CAJU5jULyMTQYRuaJ2UMgONaGtm8CPfdW4-u1Dtx59ndzUNC=Zw@mail.gmail.com>
	<6aada00421e51a3bffc2e4354e6fbb34@grandegger.com>
	<CAJU5jULo5Lu1Qbe2Qibr78OZuAMhyD=bD+vP+xrXERV2ZeN-2A@mail.gmail.com>
	<430e94b292fb21c91a1f128f83bb8ad3@grandegger.com>
	<CAJU5jULTsLvi4BrB5kuKC7QGVeUjTKY4ad_UA7sJ9aoXNax__g@mail.gmail.com>
	<57acf912689fb58466cb5aaac1993a59@grandegger.com>
	<CAJU5jU+F6t+WSLnsF8j7V2v9WBW+BVqQFf=00E2469RybocjzA@mail.gmail.com>
	<5228DA82.4050203@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:63895 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158Ab3IETpt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Sep 2013 15:45:49 -0400
Received: by mail-wi0-f175.google.com with SMTP id ez12so14707wid.2
        for <linux-can@vger.kernel.org>; Thu, 05 Sep 2013 12:45:47 -0700 (PDT)
In-Reply-To: <5228DA82.4050203@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

Here it is:

Linux version 3.2.20 (tomh@turbo_tom) (gcc version 4.5.3 (Buildroot
2012.05) ) #2 Wed Dec 5 14:33:28 CST 2012
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: Atmel AT91SAM9G20-EK
Memory policy: ECC disabled, Data cache writeback
AT91: Detected soc type: at91sam9g20
AT91: Detected soc subtype: Unknown
AT91: sram at 0x200000 of 0x4000 mapped at 0xfef74000
AT91: sram at 0x300000 of 0x4000 mapped at 0xfef70000
On node 0 totalpages: 16384
free_area_init_node: node 0, pgdat c03b4220, node_mem_map c03ce000
  Normal zone: 128 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 16256 pages, LIFO batch:3
Clocks: CPU 396 MHz, master 132 MHz, main 18.432 MHz
pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16=
256
Kernel command line: mem=3D64M console=3DttyS0,115200 ubi.mtd=3D1
root=3Dubi0:rootfs rw rootfstype=3Dubifs
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB =3D 64MB total
Memory: 61036k/61036k available, 4500k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc4800000 - 0xfee00000   ( 934 MB)
    lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc036cd20   (3476 kB)
      .init : 0xc036d000 - 0xc038f000   ( 136 kB)
      .data : 0xc0390000 - 0xc03b49e0   ( 147 kB)
       .bss : 0xc03b4a04 - 0xc03cdb88   ( 101 kB)
NR_IRQS:192
AT91: 96 gpio irqs in 3 banks
Console: colour dummy device 80x30
Calibrating delay loop... 197.01 BogoMIPS (lpj=3D985088)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
AT91: Power Management
AT91: Starting after general reset
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource pit
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (double precision)
JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 119
io scheduler noop registered (default)
atmel_usart.0: ttyS0 at MMIO 0xfffff200 (irq =3D 1) is a ATMEL_SERIAL
console [ttyS0] enabled
atmel_usart.1: ttyS1 at MMIO 0xfffb0000 (irq =3D 6) is a ATMEL_SERIAL
atmel_usart.2: ttyS2 at MMIO 0xfffb4000 (irq =3D 7) is a ATMEL_SERIAL
atmel_usart.3: ttyS3 at MMIO 0xfffb8000 (irq =3D 8) is a ATMEL_SERIAL
atmel_usart.4: ttyS4 at MMIO 0xfffd0000 (irq =3D 23) is a ATMEL_SERIAL
atmel_usart.5: ttyS5 at MMIO 0xfffd4000 (irq =3D 24) is a ATMEL_SERIAL
brd: module loaded
loop: module loaded
atmel_nand atmel_nand: No DMA support for NAND access.
ONFI flash detected
ONFI param page 0 valid
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xa1 (Micron MT29F1G08ABBD=
AH4)
Scanning device for bad blocks
Creating 3 MTD partitions on "atmel_nand":
0x000000000000-0x000000400000 : "Bootstrap"
0x000000400000-0x000004000000 : "Partition 1"
0x000004000000-0x000008000000 : "Partition 2"
UBI: attaching mtd1 to ubi0
UBI: physical eraseblock size:   131072 bytes (128 KiB)
UBI: logical eraseblock size:    129024 bytes
UBI: smallest flash I/O unit:    2048
UBI: sub-page size:              512
UBI: VID header offset:          512 (aligned 512)
UBI: data offset:                2048
UBI: max. sequence number:       1124
UBI: attached mtd1 to ubi0
UBI: MTD device name:            "Partition 1"
UBI: MTD device size:            60 MiB
UBI: number of good PEBs:        480
UBI: number of bad PEBs:         0
UBI: number of corrupted PEBs:   0
UBI: max. allowed volumes:       128
UBI: wear-leveling threshold:    4096
UBI: number of internal volumes: 1
UBI: number of user volumes:     1
UBI: available PEBs:             0
UBI: total number of reserved PEBs: 480
UBI: number of PEBs reserved for bad PEB handling: 4
UBI: max/mean erase counter: 11/2
UBI: image sequence number:  1335236302
UBI: background thread "ubi_bgt0d" started, PID 353
atmel_spi atmel_spi.0: Atmel SPI Controller at 0xfffc8000 (irq 12)
MACB_mii_bus: probed
eth0: Atmel MACB at 0xfffc4000 irq 21 (00:50:c2:9b:a8:8e)
eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=3Dffffffff:00=
, irq=3D-1)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
at91_ohci at91_ohci: AT91 OHCI
at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
at91_ohci at91_ohci: irq 20, io mem 0x00500000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mousedev: PS/2 mouse device common for all mice
rtc-m41t94 spi0.3: rtc core: registered rtc-m41t94 as rtc0
rtc-m41t94: watchdog registered.
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP cubic registered
NET: Registered protocol family 17
rtc-m41t94 spi0.3: setting system clock to 2013-09-05 19:35:20 UTC (137=
8409720)
UBIFS: recovery needed
UBIFS: recovery completed
UBIFS: mounted UBI device 0, volume 0, name "rootfs"
UBIFS: file system size:   59480064 bytes (58086 KiB, 56 MiB, 461 LEBs)
UBIFS: journal size:       9033728 bytes (8822 KiB, 8 MiB, 71 LEBs)
UBIFS: media format:       w4/r0 (latest is w4/r0)
UBIFS: default compressor: lzo
UBIFS: reserved for root:  0 bytes (0 KiB)
VFS: Mounted root (ubifs filesystem) on device 0:12.
=46reeing init memory: 136K
can: controller area network core (rev 20090105 abi 8)
NET: Registered protocol family 29
CAN device driver interface
can: raw protocol (rev 20090105)
mcp251x spi0.0: probed
mcp251x spi0.2: probed
mcp251x spi0.0: CNF: 0x01 0xff 0x02
mcp251x spi0.2: CNF: 0x01 0xff 0x02
eth0: link up (100/Full)

On Thu, Sep 5, 2013 at 3:24 PM, Wolfgang Grandegger <wg@grandegger.com>=
 wrote:
> On 09/05/2013 07:17 PM, Michael Muldoon wrote:
>> Linux version 3.2.20 (tomh@turbo_tom) (gcc version 4.5.3 (Buildroot
>> 2012.05) ) and no I didn't do it myself it came setup.
>
> Well, not that old but a few issues have been fixed in the meantime. =
Any
> chance to switch to a more recent kernel version?
>
> What hardware do you use? MCP2510 or MCP2515? Could you show the boot
> log (output of "dmesg)?
>
> Wolfgang,
>
>>
>> On Thu, Sep 5, 2013 at 11:55 AM, Wolfgang Grandegger <wg@grandegger.=
com> wrote:
>>> On Thu, 5 Sep 2013 11:33:19 -0400, Michael Muldoon <mbmuldoon07@gma=
il.com>
>>> wrote:
>>>> So I noticed that the can state is always UNKNOWN or DOWN could th=
is
>>>> be the problem?
>>>> can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNO=
WN
>>>> mode DEFAULT qlen 10
>>>>     link/can
>>>>     can state BUS-OFF restart-ms 100
>>>>     bitrate 125000 sample-point 0.875
>>>>     tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>>>>     mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
>>>>     clock 10000000
>>>>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>>>>     0          0          0          327        327        0
>>>>     RX: bytes  packets  errors  dropped overrun mcast
>>>>     84592      10574    0       0       0       0
>>>>     TX: bytes  packets  errors  dropped carrier collsns
>>>>     0          0        0       0       0       0
>>>> When I tried "# ip link set can0 type can reastart" can0 was defin=
itely
>>> on.
>>>
>>> Just to be sure: s/reastart/restart/
>>>
>>>> I tried change the settings you suggested still no changes.
>>>
>>> OK, what kernel version and distribution do you use?
>>> Did you do the mc251x platform setup yourself?
>>>
>>> Wolfgang.
>>
>>
>
