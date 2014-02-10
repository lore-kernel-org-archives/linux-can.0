From: Luc Richer <lricher@symboticware.com>
Subject: Re: trouble bringing up can0 interface on intel eg20t chipset
Date: Mon, 10 Feb 2014 13:05:51 -0500
Message-ID: <52F914FF.20902@symboticware.com>
References: <52F903EB.8030107@symboticware.com> <52F904E6.2060605@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:61244 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbaBJSFx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Feb 2014 13:05:53 -0500
Received: by mail-ie0-f180.google.com with SMTP id at1so3768052iec.11
        for <linux-can@vger.kernel.org>; Mon, 10 Feb 2014 10:05:53 -0800 (PST)
In-Reply-To: <52F904E6.2060605@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 02/10/2014 11:57 AM, Marc Kleine-Budde wrote:
> On 02/10/2014 05:52 PM, Luc Richer wrote:
>> I am trying to interface with vehicle engine using Intel EG20T chipset.
>>
>> This board does have a pinout for CANbus interface, and I believe I have
>> determined the correct module for the interface is pch_can
>> http://cateee.net/lkddb/web-lkddb/PCH_CAN.html
>> Someone told me I may need the i2c module for this chipset as well, so I
>> have loaded it also (i2c_eg20t)
>>
>> I have loaded the modules for the can interface (can, can-dev, can-raw,
>> can-bcm) along with i2c_eg20t and pch_can.
>>
>> dmesg | grep can reveals
>> can: controller area network core (rev 20120528 abi 9)
>> can: raw protocol (rev 20120528)
>> can: broadcast manager protocol (rev 20120528 t)
> Please send the output of:
>
>      lspci
>      ifconfig -a
>
> Marc
>
I have made some advancement and now have the interface detected but 
can't seem to bring it up.

$ lspci
00:00.0 Host bridge: Intel Corporation Atom Processor E6xx PCI Host 
Bridge #1 (rev 05)
00:01.0 Host bridge: Intel Corporation Atom Processor E6xx Configuration 
Unit (rev 02)
00:02.0 VGA compatible controller: Intel Corporation Atom Processor E6xx 
Integrated Graphics Controller (rev 05)
00:03.0 Multimedia video controller: Intel Corporation Atom Processor 
E6xx Integrated Graphics Controller (rev 02)
00:17.0 PCI bridge: Intel Corporation Atom Processor E6xx PCI Express 
Port 1 (rev 02)
00:18.0 PCI bridge: Intel Corporation Atom Processor E6xx PCI Express 
Port 2 (rev 02)
00:19.0 PCI bridge: Intel Corporation Atom Processor E6xx PCI Express 
Port 3 (rev 02)
00:1a.0 PCI bridge: Intel Corporation Atom Processor E6xx PCI Express 
Port 4 (rev 02)
00:1b.0 Audio device: Intel Corporation System Controller Hub (SCH 
Poulsbo) HD Audio Controller (rev 02)
00:1f.0 ISA bridge: Intel Corporation Atom Processor E6xx LPC Bridge 
(rev 02)
01:00.0 PCI bridge: Intel Corporation Platform Controller Hub EG20T PCI 
Express Port (rev 01)
02:00.0 Unassigned class [ff00]: Intel Corporation Platform Controller 
Hub EG20T Packet Hub (rev 01)
02:00.1 Ethernet controller: Intel Corporation Platform Controller Hub 
EG20T Gigabit Ethernet Controller (rev 02)
02:00.2 Unassigned class [ff00]: Intel Corporation Platform Controller 
Hub EG20T General Purpose IO Controller (rev 01)
02:02.0 USB controller: Intel Corporation Platform Controller Hub EG20T 
USB OHCI Controller #4 (rev 02)
02:02.1 USB controller: Intel Corporation Platform Controller Hub EG20T 
USB OHCI Controller #5 (rev 02)
02:02.2 USB controller: Intel Corporation Platform Controller Hub EG20T 
USB OHCI Controller #6 (rev 02)
02:02.3 USB controller: Intel Corporation Platform Controller Hub EG20T 
USB2 EHCI Controller #2 (rev 02)
02:02.4 USB controller: Intel Corporation Platform Controller Hub EG20T 
USB Client Controller (rev 02)
02:04.0 SD Host controller: Intel Corporation Platform Controller Hub 
EG20T SDIO Controller #1 (rev 01)
02:04.1 SD Host controller: Intel Corporation Platform Controller Hub 
EG20T SDIO Controller #2 (rev 01)
02:06.0 SATA controller: Intel Corporation Platform Controller Hub EG20T 
SATA AHCI Controller (rev 02)
02:08.0 USB controller: Intel Corporation Platform Controller Hub EG20T 
USB OHCI Controller #1 (rev 02)
02:08.1 USB controller: Intel Corporation Platform Controller Hub EG20T 
USB OHCI Controller #2 (rev 02)
02:08.2 USB controller: Intel Corporation Platform Controller Hub EG20T 
USB OHCI Controller #3 (rev 02)
02:08.3 USB controller: Intel Corporation Platform Controller Hub EG20T 
USB2 EHCI Controller #1 (rev 02)
02:0a.0 Unassigned class [ff00]: Intel Corporation Platform Controller 
Hub EG20T DMA Controller #1
02:0a.1 Serial controller: Intel Corporation Platform Controller Hub 
EG20T UART Controller 0 (rev 01)
02:0a.2 Serial controller: Intel Corporation Platform Controller Hub 
EG20T UART Controller 1
02:0a.3 Serial controller: Intel Corporation Platform Controller Hub 
EG20T UART Controller 2
02:0a.4 Serial controller: Intel Corporation Platform Controller Hub 
EG20T UART Controller 3
02:0c.0 Unassigned class [ff00]: Intel Corporation Platform Controller 
Hub EG20T DMA Controller #2
02:0c.1 Serial bus controller [0c80]: Intel Corporation Platform 
Controller Hub EG20T Serial Peripheral Interface Bus
02:0c.2 Serial bus controller [0c80]: Intel Corporation Platform 
Controller Hub EG20T I2C Controller
02:0c.3 CANBUS: Intel Corporation Platform Controller Hub EG20T 
Controller Area Network (CAN) Controller
02:0c.4 Unassigned class [ff00]: Intel Corporation Platform Controller 
Hub EG20T IEEE 1588 Hardware Assist (rev 01)
03:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network 
Connection

$ ifconfig -a
can0: flags=128<NOARP>  mtu 16
         unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00 
txqueuelen 10  (UNSPEC)
         RX packets 0  bytes 0 (0.0 B)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 0  bytes 0 (0.0 B)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
         device interrupt 18

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
         inet 127.0.0.1  netmask 255.0.0.0
         inet6 ::1  prefixlen 128  scopeid 0x10<host>
         loop  txqueuelen 0  (Local Loopback)
         RX packets 10  bytes 680 (680.0 B)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 10  bytes 680 (680.0 B)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

p2p1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         inet 192.168.0.188  netmask 255.255.255.0  broadcast 0.0.0.0
         inet6 fe80::290:fbff:fe47:a609  prefixlen 64  scopeid 0x20<link>
         ether 00:90:fb:47:a6:09  txqueuelen 1000  (Ethernet)
         RX packets 12220  bytes 11590749 (11.0 MiB)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 4608  bytes 384987 (375.9 KiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
         device interrupt 17  memory 0xd0300000-d0320000



