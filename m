From: Gabriel Manriquez <gmanriquez@wegmannusa.com>
Subject: socketCan build fails
Date: Thu, 23 Feb 2012 10:02:14 -0500
Message-ID: <4F4654F6.8010201@wegmannusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrtr16.ntelos.net ([216.12.0.116]:40706 "EHLO
	mailrtr16.ntelos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957Ab2BWPMy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Feb 2012 10:12:54 -0500
Received: from [192.168.100.134] (226-229-46-71.biz.bhn.net [71.46.229.226] (may be forged))
	(authenticated bits=0)
	by mailrtr16.ntelos.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id q1NF2BPL016142
	for <linux-can@vger.kernel.org>; Thu, 23 Feb 2012 10:02:12 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I'm trying to install the socketcan package for the first time.  I just 
checked out the package today.
I'm following the instructions in the README file but when I issue the 
command:

make CC=gcc-4.3

I get errors.  See output below:

host:~/socketCan/kernel/2.6# make CC=gcc-4.3
make -C /lib/modules/2.6.35.11/build M=/root/socketCan/kernel/2.6 
modules TOPDIR=/root/socketCan/kernel/2.6
make[1]: Entering directory `/usr/src/linux-2.6.35.11'
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/vcan.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/slcan.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/dev.o
   LD [M]  /root/socketCan/kernel/2.6/drivers/net/can/can-dev.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/esd_pci331.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/mcp251x.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/cc770/cc770.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/cc770/cc770_isa.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/sja1000.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/sja1000_isa.o
   CC [M]  
/root/socketCan/kernel/2.6/drivers/net/can/sja1000/sja1000_platform.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/ems_pci.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/ems_104m.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/esd_pci.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/ixxat_pci.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/plx_pci.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/peak_pci.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/pipcan.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/kvaser_pci.o
   CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.o
/root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c: In function 
`ems_usb_write_bulk_callback':
/root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c:525: error: 
implicit declaration of function `usb_buffer_free'
/root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c: In function 
`ems_usb_start':
/root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c:623: error: 
implicit declaration of function `usb_buffer_alloc'
/root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c:624: warning: 
assignment makes pointer from integer without a cast
/root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c: In function 
`ems_usb_start_xmit':
/root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c:790: warning: 
assignment makes pointer from integer without a cast
make[4]: *** [/root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.o] 
Error 1
make[3]: *** [/root/socketCan/kernel/2.6/drivers/net/can/usb] Error 2
make[2]: *** [/root/socketCan/kernel/2.6/drivers/net/can] Error 2
make[1]: *** [_module_/root/socketCan/kernel/2.6] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.35.11'
make: *** [modules] Error 2


Any ideas on what could be causing this??
I'm running on Linux (Lenny) kernel version 2.6

Thanks in advance.

-Gabriel
