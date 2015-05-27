From: Michael Gallagher <mjg@isomorphdevelopment.com>
Subject: SocketCAN on Intel Edison with MCP 2515
Date: Wed, 27 May 2015 11:18:54 -0400
Message-ID: <CAKa_yg_Lrpw7J70UzJf5x2EeB6mrmbFarxgbYCf+xHyD8Nb2eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36795 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbE0PSz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 May 2015 11:18:55 -0400
Received: by paza2 with SMTP id a2so162724paz.3
        for <linux-can@vger.kernel.org>; Wed, 27 May 2015 08:18:54 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I am new to SocketCAN and have some basic questions, I'm hoping that
someone might be able to point me in the right direction.

I have recompiled Yocto (uname - r returns 3.10.17-yocoto standard)
and included the SocketCAN module as well as the drivers for the MCP
2515. I can see that the module has been installed, as dmesg | grep
can returns:

[    0.754296] vcan: Virtual CAN interface driver
[    2.033276] can: controller area network core (rev 20120528 abi 9)
[    2.033429] can: raw protocol (rev 20120528)
[    2.033447] can: broadcast manager protocol (rev 20120528 t)
[    2.033476] can: netlink gateway (rev 20130117) max_hops=1

I believe I am running iproute2 because the which ip command returns /sbin/ip.

cat /proc/net/can/version returns :

rev 20120528 abi 9

I can also load all necessary (I think these are all the necessary
drivers?) drivers by issuing the following modprobe commands:

modprobe can
modprobe can-dev
modprobe can-raw
modprobe mcp251x

However, can0 is not recognized:

ifconfig returns:

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

usb0      Link encap:Ethernet  HWaddr 02:00:86:b6:1c:86
          inet addr:192.168.2.15  Bcast:192.168.2.255  Mask:255.255.255.0
          inet6 addr: fe80::86ff:feb6:1c86/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1485 errors:0 dropped:0 overruns:0 frame:0
          TX packets:56 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:297401 (290.4 KiB)  TX bytes:10210 (9.9 KiB)

wlan0     Link encap:Ethernet  HWaddr fc:c2:de:43:ee:f2
          inet addr:192.168.11.26  Bcast:0.0.0.0  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:12169 errors:0 dropped:84 overruns:0 frame:0
          TX packets:609 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1564033 (1.4 MiB)  TX bytes:60145 (58.7 KiB)

and ifconfig can0 up returns:

can0: ERROR while getting interface flags: No such device

One thing I am confused about is how the socketCAN drivers know which
SPI bus to use? I see that this information is provided in the
bcm2708.c source file for the RPI_CANBUS
(http://www.elinux.org/RPi_CANBus) project in the config_spi function.
Is there something similar I would need to do?

I thought maybe socketCAN would automatically use the SSP driver
provided by Intel, which seems like it might provide a layer of
abstraction that would make the config_spi function unnecessary? For
reference, here is what dmesg | grep -a ssp returns:

[    2.022921] merr_dpcm_dummy merr_dpcm_dummy.0:  snd-soc-dummy-dai
<-> ssp2-codec mapping ok
[    2.039652] intel_mid_ssp_spi_unified 0000:00:07.0: found PCI SSP
controller (ID: 8086h:1194h cfg: 0dh)
[    2.040598] intel_mid_ssp_spi_unified 0000:00:07.0: register with
SPI framework (bus spi3)
[    2.040765] intel_mid_ssp_spi_unified 0000:00:07.0: master is
unqueued, this is deprecated
[    2.040795] intel_mid_ssp_spi_unified 0000:00:07.0: Unbalanced
pm_runtime_enable!
[    2.046297] intel_mid_ssp_spi_unified 0000:00:07.1: found PCI SSP
controller (ID: 8086h:1194h cfg: 15h)
[    2.047172] intel_mid_ssp_spi_unified 0000:00:07.1: register with
SPI framework (bus spi5)
[    2.047338] intel_mid_ssp_spi_unified 0000:00:07.1: master is
unqueued, this is deprecated
[    2.049172] intel_mid_ssp_spi_unified 0000:00:07.1: Unbalanced
pm_runtime_enable!
[    2.056516] intel_mid_ssp_spi_unified 0000:00:07.2: found PCI SSP
controller (ID: 8086h:1194h cfg: 19h)
[    2.057360] intel_mid_ssp_spi_unified 0000:00:07.2: register with
SPI framework (bus spi6)
[    2.057527] intel_mid_ssp_spi_unified 0000:00:07.2: master is
unqueued, this is deprecated
[    2.057556] intel_mid_ssp_spi_unified 0000:00:07.2: Unbalanced
pm_runtime_enable!

Based on the above I chose to use SSP5 to wire my Edison to the
MCP2515 but I have connected a scope and never see any spi traffic.
I've also tried configuring the mux options using the following shell
script:

#SSP5_RXD
echo mode1 > /sys/kernel/debug/gpio_debug/gpio114/current_pinmux

#SSP5_CLK
echo mode1 > /sys/kernel/debug/gpio_debug/gpio109/current_pinmux

#SSP5_TXD
echo mode1 > /sys/kernel/debug/gpio_debug/gpio115/current_pinmux

#SSP5_CS
echo mode1 > /sys/kernel/debug/gpio_debug/gpio111/current_pinmux

So in short I think something is breaking in my SPI communication
configuration but I'm not sure exactly where to start. Anything you
could do to point me in the right direction towards the appropriate
documentation would be appreciated.

Thanks,

Mike
