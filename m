From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Problem with Eurotech COM1273 Dual Channel CAN PC104 Module.
Date: Tue, 15 Apr 2014 13:55:59 +0200
Message-ID: <534D1E4F.4030405@hartkopp.net>
References: <CA+s8ZrqFBun4bo2rJJFHb0FrV7m7PLybUVM+jjahKsdW8bdnaQ@mail.gmail.com>	<164afc991761b9eeb0eec6902814d00e@grandegger.com>	<534D0F00.7000202@hartkopp.net> <CA+s8ZroY7j8MLpFQh568QdeB24zBwVAVXbi7RzQF+baFi+Mpkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:41426 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbaDOL4B (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Apr 2014 07:56:01 -0400
In-Reply-To: <CA+s8ZroY7j8MLpFQh568QdeB24zBwVAVXbi7RzQF+baFi+Mpkw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: khurram gulzar <khurramgulzar@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Khurram,

the speed is only set with the 'ip' tool now.

And regarding the former iomux handling it should be like this:

modprobe sja1000_isa port=0x200,0x204 irq=10,11 indirect=1,1

See the code for further module parameter details:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/sja1000/sja1000_isa.c

Regards,
Oliver


On 15.04.2014 13:25, khurram gulzar wrote:
> Thanx Oliver, 
> Yes indeed its a v.big time loop. 
> I was previously using sja1000-iomux 
> sja1000_isa i can only load one module can0  at address 0x200 but cant load
> 0x204 bus
> modprobe sja1000_isa port=0x200,0x204 irq=10,11 with speed parameter set by ip
> link set command 
> there is an indirect parameter, I have no idea how it is used could you elaborate 
> my base address is 0x200 and 0x204 with irq 10 and 11 speed 1000,1000 
>  
> 
> 
> On Tue, Apr 15, 2014 at 1:50 PM, Oliver Hartkopp <socketcan@hartkopp.net
> <mailto:socketcan@hartkopp.net>> wrote:
> 
>     Hello Khurram,
> 
>     we're obviously in a time loop :-)
> 
>     See your same request ~5 years ago:
> 
>     http://socket-can.996257.n3.nabble.com/Support-needed-for-Eurotech-COM1273-Dual-Channel-CAN-PC104-Module-td1524.html
> 
>     I assume the sja1000_isa driver will be the right one for this old card.
>     It is part of mainline Linux - so no need to compile old SocketCAN sources
>     from the SVN.
> 
>     Regards,
>     Oliver
> 
>     On 15.04.2014 11:55, Wolfgang Grandegger wrote:
>     > Hi Khurram,
>     >
>     > we have switched to a new mailing list some time ago, which I have
>     > therefore added to the CC.
>     >
>     > On Tue, 15 Apr 2014 11:07:15 +0300, khurram gulzar
>     > <khurramgulzar@gmail.com <mailto:khurramgulzar@gmail.com>> wrote:
>     >> Hi Oliver and Wolfgang,
>     >> Thanks for your support in advance
>     >> I have recently updated the system from Kernel 2.6 to use the new kernel
>     >> 3.2 for linux. I have noticed that the socket-can is integrated in the
>     >> kernel.  I enabled the driver in the kernel from the kernel config.
>     >> The drivers are loaded successfully and both the CAN are transmitting
>     > the
>     >> packets. However its unable to receive any packets on any of the CAN.
>     >> The system configurations are still the same loaded drivers
>     >> -> can.ko-> can-raw.ko-> sja1000-iomux
>     >
>     > There is now module named "sja1000-iomux" in the mainline kernel.
>     > Where did you get it from?
>     >
>     >> The address of can is configured to base=0x200,0x204 and irq=10,11 with
>     >> speed=1000,1000 i.e. 1Mbits/sec
>     >> I have checked the irq in /proc/interrupts. IRQ 10 and 11  are showing
>     >> connected to CAN0 and CAN1.
>     >
>     > Do the IRQ counts increase when you send messages?
>     >
>     >> Can you please tell me what seems to be wrong-  Waiting for your
>     >> reply
>     >
>     > Could you switch to a recent mainline kernel version?
>     >
>     > Wolfgang.
>     >
>     > --
>     > To unsubscribe from this list: send the line "unsubscribe linux-can" in
>     > the body of a message to majordomo@vger.kernel.org <mailto:majordomo@vger.kernel.org>
>     > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>     >
> 
> 
