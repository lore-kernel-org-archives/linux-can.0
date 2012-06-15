From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Socketcan-users] Flexcan on i.mx536 Infotainment Platform
Date: Fri, 15 Jun 2012 07:51:25 +0200
Message-ID: <4FDACD5D.9000903@grandegger.com>
References: <1338845698.76889.YahooMailNeo@web140802.mail.bf1.yahoo.com> <4FD9DB62.50302@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40511 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab2FOFve (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Jun 2012 01:51:34 -0400
In-Reply-To: <4FD9DB62.50302@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Keith Jones <keith.rjones@yahoo.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

Hello,

I forgot to switch to the new Linux-CAN mailing list... doing it now.

On 06/14/2012 02:38 PM, Wolfgang Grandegger wrote:
> On 06/04/2012 11:34 PM, Keith Jones wrote:
>> Hello,
>>
>> I booted up my new Infotainment demo board after ported 2.6.39 flexcan (flexcan.h flexcan.c) support into my 2.6.35 linux distro. 
>>
>> After seeing flexcan driver register and performing the following commands, I get constant interrupts and error packets visualized using my Canoe CANbus sniffer. I am using 250K baud. Did not check termination. No oscilloscope was used as yet. Can not receive any packets. can state goes from ERROR-ACTIVE to ERROR-PASSIVE.
>>
>>
>> Any clues?
> 
> Is there at least one more CAN node on the bus acknowledging the
> message? If not, the behavior is normal. Also improper termination or
> bit-timing could cause bus errors.
> 
> Is Flexcan known to work on that hardware and software? The transceivers
> might still be off, etc.

The 2.6.35 kernel you use, is it from Freescale? If that's the case, you
need also to port the platform code for the Flexcan controller.

Wolfgang.

>> --------------------------------------------------
>>
>> .
>> .
>>
>> vcan: Virtual CAN interface driver
>> CAN device driver interface
>> flexcan netdevice driver
>> flexcan flexcan.0: device registered (reg_base=e09f0000, irq=82)
>> flexcan flexcan.1: device registered (reg_base=e09f8000, irq=83)
>> .
>> .
>> .
>> ----------------------------------------------------------------
>>
>> root@freescale ~$  ip link set can0 up type can bitrate 250000
>> root@freescale /usr/bin$ ip -d -s link show can0
>> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
>>     link/can
>>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>>     bitrate 250000 sample-point 0.875
>>     tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>>     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>>     clock 24000000
>>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>>     0          0          0          4          4          0
>>     RX: bytes  packets  errors  dropped overrun mcast
>>     64         8        0       0       0       0
>>     TX: bytes  packets  errors  dropped carrier collsns
>>     4          0        0
>>
>> root@freescale ~$ cansend can0 123#1122334455
>> root@freescale /usr/bin$ ip -d -s link show can0
>> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
>>     link/can
>>     can state ERROR-PASSIVE (berr-counter tx 128 rx 0) restart-ms 0
>>     bitrate 250000 sample-point 0.875
>>     tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>>     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>>     clock 24000000
>>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>>     0          0          0          5          5          0
>>     RX: bytes  packets  errors  dropped overrun mcast
>>     80         10       0       0       0       0
>>     TX: bytes  packets  errors  dropped carrier collsns
>>     5          0        0       0       0       0
>> root@freescale /usr/bin$ cat /proc/interrupts
>>            CPU0
>>   1:       1491    MXC_TZIC  mxsdhci
>>   2:          0    MXC_TZIC  mxsdhci
>>   6:          1    MXC_TZIC  mxc_sdma
>>   8:          2    MXC_TZIC  mxc_nd
>>   9:          0    MXC_TZIC  VPU_CODEC_IRQ
>>  10:          0    MXC_TZIC  mxc_ipu
>>  11:          2    MXC_TZIC  mxc_ipu
>>  12:          0    MXC_TZIC  ydx
>>  14:          0    MXC_TZIC  usb_wakeup, ehci_hcd:usb2
>>  16:          0    MXC_TZIC  usb_wakeup, ehci_hcd:usb3
>>  18:          0    MXC_TZIC  usb_wakeup, fsl-usb2-otg, ehci_hcd:usb1, fsl-usb2-udc
>>  24:          0    MXC_TZIC  mxc_rtc
>>  28:          0    MXC_TZIC  ahci
>>  31:       4093    MXC_TZIC  mxcintuart
>>  36:          1    MXC_TZIC  CSPI_IRQ
>>  39:      69290    MXC_TZIC  i.MX Timer Tick
>>  63:        198    MXC_TZIC  imx-i2c
>>  64:         60    MXC_TZIC  imx-i2c
>>  66:          0    MXC_TZIC  asrc
>>  69:          0    MXC_TZIC  mxc_iim
>>  73:          0    MXC_TZIC  dvfs
>>  82:    1283596    MXC_TZIC  can0
>>  84:          0    MXC_TZIC  g12
>> 129:          0           -  mxsdhci
>> 132:          0           -  mxsdhci
>> 191:          0           -  eth0
>> Err:          0
>> root@freescale /usr/bin$
>>
>>
>>
>> _______________________________________________
>> Socketcan-users mailing list
>> Socketcan-users@lists.berlios.de
>> https://lists.berlios.de/mailman/listinfo/socketcan-users
> 
> _______________________________________________
> Socketcan-users mailing list
> Socketcan-users@lists.berlios.de
> https://lists.berlios.de/mailman/listinfo/socketcan-users
> 
> 

