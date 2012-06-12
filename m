From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: serial can or socket can ?
Date: Tue, 12 Jun 2012 15:44:11 +0200
Message-ID: <4FD747AB.70406@hartkopp.net>
References: <CAHvj1qaxr-Zo4oteEhvrMXG00if3CBrPSL8+QYrQyJu=NUfnzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:35106 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab2FLNoO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Jun 2012 09:44:14 -0400
In-Reply-To: <CAHvj1qaxr-Zo4oteEhvrMXG00if3CBrPSL8+QYrQyJu=NUfnzg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: bruce bushby <bruce.bushby@gmail.com>
Cc: linux-can@vger.kernel.org

On 12.06.2012 14:55, bruce bushby wrote:

> Hi
> 
> I wanted to confirm my understanding of "socketcan" in terms "slcan0" and "can0"
> 


Ok, let's go ...

> I've been playing with a Beaglebone board the a usb-can adaptor from
> mictronics.de:
> http://www.mictronics.de/projects/usb-can-bus/
> Purchased from:
> http://shop.greenstage.co.nz/product/usb-can-bus-interface
> 
> 1. Is my understanding correct that "slcan" will ALWAYS be used when
> connecting a USB based CANBUS adapter?


No.

The slcan driver provides a CAN network device for CAN interfaces that are
controlled by the ASCII protocol first brought up by LAWICEL (www.can232.com,
www.canusb.com). The slcan driver converts the ASCII frames to struct
can_frame which is used in the Linux CAN subsystem (aka SocketCAN).

You may have a CAN device supporting the SLCAN protocol on RS232, USB-serial
adapters, whatever.

See

http://lxr.linux.no/#linux+v3.4.2/drivers/net/can/Kconfig#L13

and

http://lxr.linux.no/#linux+v3.4.2/drivers/net/can/slcan.c#L99

There are CAN USB drivers in the tree, that do not use the SLCAN protocol:

http://lxr.linux.no/#linux+v3.4.2/drivers/net/can/usb/Kconfig


> 
> I am able to bringup slcan0 using the following commands:


Use this

> # slcan_attach -o -s6 /dev/ttyUSB0
> attached tty /dev/ttyUSB0 to netdevice slcan0


OR this

> # slcand ttyUSB0


!

Running slcand and slcan_attach together doesn't make sense.


> # ifconfig slcan0 up
> # ifconfig slcan0
> slcan0    Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
> 
> #
> 
> 
> 2. AM335x has an internal D_CAN, but the Beaglebone is missing any CAN
> transceiver...would the lack of the transceiver prevent the kernel
> from creating the "can0" device?


No. A missing CAN transceiver is not detected (so far).

I assume you need a platform driver specification for your board to find and
access the CAN controller. If you have it, the CAN controller can be accessed
and initialized => can0 appears.

> 
> 
> # lsmod
> Module                  Size  Used by    Not tainted
> d_can                   5470  0
> can_raw                 3679  0
> can_dev                 4414  1 d_can
> can                    16648  1 can_raw
> slcan                   3437  1
> ftdi_sio               24056  1
> usbserial              18026  3 ftdi_sio
> 
> # ip link set can0 up
> ip: SIOCGIFFLAGS: No such device
> 
> # ifconfig can0
> ifconfig: can0: error fetching interface information: Device not found


As expected: Not platform definition => no hardware access => no device

> 
> # ifconfig -a
> eth0      Link encap:Ethernet  HWaddr D4:94:A1:89:BC:FF
>           inet addr:192.100.1.13  Bcast:0.0.0.0  Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:70 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:16 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:21678 (21.1 KiB)  TX bytes:1392 (1.3 KiB)
>           Interrupt:40
> 
> lo        Link encap:Local Loopback
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           RX packets:3 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:166 (166.0 B)  TX bytes:166 (166.0 B)
> 
> slcan0    Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
> 
> #
> 
> 
> FYI: This is probably a better board if you want to play with CANBUS:
> http://www.ti.com/tool/tmdxice3359
> 
> 
> Cheers
> Bruce


Regards,
Oliver
