From: Gabriel Manriquez <gmanriquez@wegmannusa.com>
Subject: Re: socketCan build fails
Date: Thu, 23 Feb 2012 12:33:00 -0500
Message-ID: <4F46784C.7070104@wegmannusa.com>
References: <4F4654F6.8010201@wegmannusa.com> <4F4675B7.4040605@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrtr14.ntelos.net ([216.12.0.114]:35292 "EHLO
	mailrtr14.ntelos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab2BWRdA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Feb 2012 12:33:00 -0500
In-Reply-To: <4F4675B7.4040605@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

I'm running kernel version 2.6.35.11.

I was just following the README file which says to compile 
kernel/<version> ... so since you're saying that I don't need to then 
can I just go ahead and compile the utilities and test programs?
I'm trying to use socketcan in conjuction with can driver : 
peak-linux-driver-7.4 which I already installed.
At this point I just need to test communication to and from my CAN 
device via usb and I thought I needed the socketcan utiliites/test 
programs to do that.
The peak-linux-driver-7.4 driver comes with receive and transmit test 
utilities but they're not suitable for my type of driver install  "NETDEV"
I hope what I'm saying makes sense.  Otherwise please ask.


Thanks,

-Gabriel



On 2/23/2012 12:21 PM, Oliver Hartkopp wrote:
> On 23.02.2012 16:02, Gabriel Manriquez wrote:
>
>> Hello,
>>
>> I'm trying to install the socketcan package for the first time.  I just
>> checked out the package today.
>> I'm following the instructions in the README file but when I issue the command:
>>
>> make CC=gcc-4.3
>>
>> I get errors.  See output below:
>>
>> host:~/socketCan/kernel/2.6# make CC=gcc-4.3
>> make -C /lib/modules/2.6.35.11/build M=/root/socketCan/kernel/2.6 modules
>> TOPDIR=/root/socketCan/kernel/2.6
>> make[1]: Entering directory `/usr/src/linux-2.6.35.11'
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/vcan.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/slcan.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/dev.o
>>    LD [M]  /root/socketCan/kernel/2.6/drivers/net/can/can-dev.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/esd_pci331.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/mcp251x.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/cc770/cc770.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/cc770/cc770_isa.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/sja1000.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/sja1000_isa.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/sja1000_platform.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/ems_pci.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/ems_104m.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/esd_pci.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/ixxat_pci.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/plx_pci.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/peak_pci.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/pipcan.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/sja1000/kvaser_pci.o
>>    CC [M]  /root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.o
>> /root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c: In function
>> `ems_usb_write_bulk_callback':
>> /root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c:525: error: implicit
>> declaration of function `usb_buffer_free'
>> /root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c: In function
>> `ems_usb_start':
>> /root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c:623: error: implicit
>> declaration of function `usb_buffer_alloc'
>> /root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c:624: warning:
>> assignment makes pointer from integer without a cast
>> /root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c: In function
>> `ems_usb_start_xmit':
>> /root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.c:790: warning:
>> assignment makes pointer from integer without a cast
>> make[4]: *** [/root/socketCan/kernel/2.6/drivers/net/can/usb/ems_usb.o] Error 1
>> make[3]: *** [/root/socketCan/kernel/2.6/drivers/net/can/usb] Error 2
>> make[2]: *** [/root/socketCan/kernel/2.6/drivers/net/can] Error 2
>> make[1]: *** [_module_/root/socketCan/kernel/2.6] Error 2
>> make[1]: Leaving directory `/usr/src/linux-2.6.35.11'
>> make: *** [modules] Error 2
>>
>>
>> Any ideas on what could be causing this??
>
> Yes.
>
>> I'm running on Linux (Lenny) kernel version 2.6
>
> I assume that's a 2.6.32 then right?
>
> The content of the kernel/2.6 directory is mainly needed for older Kernels
> that do not have SocketCAN support (which was introduced in 2.6.25).
>
> Therefore not all drivers are maintained (e.g. the EMS USB driver is already
> in the mainline Kernel).
>
> Why do you need to compile these kernel/2.6 path?
>
> SocketCAN is already included in your Debian Lenny kernel.
>
> Do you need a specific CAN driver?
>
> Regards,
> Oliver
