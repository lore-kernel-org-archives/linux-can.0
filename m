From: bruce bushby <bruce.bushby@gmail.com>
Subject: serial can or socket can ?
Date: Tue, 12 Jun 2012 13:55:09 +0100
Message-ID: <CAHvj1qaxr-Zo4oteEhvrMXG00if3CBrPSL8+QYrQyJu=NUfnzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:33277 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab2FLMzK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Jun 2012 08:55:10 -0400
Received: by qadb17 with SMTP id b17so2540768qad.19
        for <linux-can@vger.kernel.org>; Tue, 12 Jun 2012 05:55:09 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi

I wanted to confirm my understanding of "socketcan" in terms "slcan0" and "can0"

I've been playing with a Beaglebone board the a usb-can adaptor from
mictronics.de:
http://www.mictronics.de/projects/usb-can-bus/
Purchased from:
http://shop.greenstage.co.nz/product/usb-can-bus-interface

1. Is my understanding correct that "slcan" will ALWAYS be used when
connecting a USB based CANBUS adapter?

I am able to bringup slcan0 using the following commands:
# slcan_attach -o -s6 /dev/ttyUSB0
attached tty /dev/ttyUSB0 to netdevice slcan0
# slcand ttyUSB0
# ifconfig slcan0 up
# ifconfig slcan0
slcan0    Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

#


2. AM335x has an internal D_CAN, but the Beaglebone is missing any CAN
transceiver...would the lack of the transceiver prevent the kernel
from creating the "can0" device?


# lsmod
Module                  Size  Used by    Not tainted
d_can                   5470  0
can_raw                 3679  0
can_dev                 4414  1 d_can
can                    16648  1 can_raw
slcan                   3437  1
ftdi_sio               24056  1
usbserial              18026  3 ftdi_sio

# ip link set can0 up
ip: SIOCGIFFLAGS: No such device

# ifconfig can0
ifconfig: can0: error fetching interface information: Device not found

# ifconfig -a
eth0      Link encap:Ethernet  HWaddr D4:94:A1:89:BC:FF
          inet addr:192.100.1.13  Bcast:0.0.0.0  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:70 errors:0 dropped:0 overruns:0 frame:0
          TX packets:16 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:21678 (21.1 KiB)  TX bytes:1392 (1.3 KiB)
          Interrupt:40

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:3 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:166 (166.0 B)  TX bytes:166 (166.0 B)

slcan0    Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

#


FYI: This is probably a better board if you want to play with CANBUS:
http://www.ti.com/tool/tmdxice3359


Cheers
Bruce
