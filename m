From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [BULK]Re: [PATCH] can: fix loss of frames due to wrong assumption
 in raw_rcv
Date: Sun, 05 Jul 2015 20:21:22 +0200
Message-ID: <559975A2.9020300@hartkopp.net>
References: <5585A104.1090201@gmx.at> <5585EC4D.40103@hartkopp.net> <5587D9DA.6000102@gmx.at> <5587E26A.1070000@hartkopp.net> <5588E6FB.5040903@optusnet.com.au> <55891263.3050704@hartkopp.net> <558A1244.3010908@optusnet.com.au> <558B0B6F.6010304@hartkopp.net> <558BBC92.6040906@peak-system.com> <840510251.4781629.1435224977567.JavaMail.open-xchange@patina.store> <55916EBC.2010807@hartkopp.net> <55980FCE.4030304@hartkopp.net> <559885DC.8040208@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:22893 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbGESVk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 5 Jul 2015 14:21:40 -0400
In-Reply-To: <559885DC.8040208@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>, Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Manfred Schlaegl <manfred.schlaegl@gmx.at>

On 05.07.2015 03:18, Tom Evans wrote:
> On 5/07/2015 2:54 AM, Oliver Hartkopp wrote:
>> Hi Stephane,
>> ...
>> While testing the patches
>> ...
>> I discovered an increase of out-of-order CAN frame receptions.
>> My setup is a core i7 with a PCAN USB and a PCAN USB pro connected to my
>> full busload CAN source (1MBit/s, ~8008 frames/s).
> 
> Out of order reception is guaranteed with some CAN hardware and driver 
> software, such as the MCP2515 controller and Linux. The chip doesn't implement 
> a FIFO, but has two receive buffers which can give message swaps quite easily. 
> This can be fixed in the driver, but nobody has. Details here:
> 
> http://www.microchip.com/forums/m620741.aspx
> 

Ugh. When reading "Out of order reception is guaranteed" I assumed a typo %-(
I don't have any MCP2515 hardware here. Any volunteers out there to fix that?

> The PCAN-USB uses an SJA1000 which doesn't have that problem. It has a 64 byte 
> FIFO. What is inside the PCAN-USB Pro isn't documented on their web page, but 
> it may be faster or have less transaction overhead or latency or something. 

IIRC it's some NXP LPC 17xx CPU with two CAN interfaces. Yes and it should be
faster than the SJA1000/C161 combo inside the PCAN-USB.

> The PCAN-USB Pro is "no longer manufactured", the replacement "PCAN-USB Pro 
> FD" has an FPGA controller.

I did my first tests with the PCAN-USB Pro FD - but to check the effect in
kernel versions < v4.0 I swapped over to the standard USB Pro due to the
missing FD support in older kernels.

>  > It's more with the PCAN USB and very few with PCAN USB pro.
> 
> I'd guess the Pro has less overhead and can get messages over USB faster than 
> the other one.
> 
>  > I'm a bit confused as this effect seems to increase with Linux kernel
>  > version numbers.
> 
> As for the later kernels being worse, that looks like a simple case of 
> "bloat", with them taking longer to get around to servicing the interrupts and 
> reading the messages. Earlier ones are probably reading CAN messages one at a 
> time, with each one getting through the stack before the next one arrives. 
> Later kernels are probably reading them in bursts. Slower controllers 
> (PCAN-USB) expose this sooner.
> 
> Can you drop back to a single core to see if this is a multicore problem? It 
> will either fix it or make it worse if it is a loading/delay problem.

Good idea!

I took my old 2005 Samsung X20 with 1.73GHz Pentium M and Xubuntu 14.04 ...

Both the stock Xubuntu 3.13 and the 4.1.1 did not have the out-of-order
issues. There were 'only' two sporadic drops with the PCAN-USB in more than
three hours of testing:

 drop detected: expected 224 received 18   (50 frames lost)
 drop detected: expected 251 received 252  (1 frame lost)

The drops emerged only on the PCAN USB interface in this case.

> Reordering packets should be considered a serious bug as some CAN protocols 
> can't handle this at all.

Yes definitely, e.g. ISO15765-2 will not work with out-of-order frames.

Going back to the latest 4.2-merge kernel with all the CAN fixes and the core
i7 SMP setup, I tried to assign the interrupt from the USB host controller to
a specific CPU using the documentation in

	https://www.kernel.org/doc/Documentation/IRQ-affinity.txt

My USB controller is on IRQ 28:

# cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
  0:         23          0          0          0  IR-IO-APIC   2-edge      timer
(..)
 28:      10114      53480     566927    1634485  IR-PCI-MSI 327680-edge      xhci_hcd
(..)

With

# echo 1 > /proc/irq/28/smp_affinity

I assigned the IRQ 28 to CPU0 and it now looks like this:

# cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
  0:         23          0          0          0  IR-IO-APIC   2-edge      timer
(..)
 28:    9072996      53480     766233    2125901  IR-PCI-MSI 327680-edge      xhci_hcd
(..)

and all the out-of-order receptions were totally gone! \o/

When nailing the CAN controller/driver interrupt to a specific CPU fixes the
out-of-order reception, we need to check whether we can do this by default.

New embedded systems like the imx6-quad will run into this problem otherwise.

Asking google about it lead to

http://stackoverflow.com/questions/11858487/change-smp-affinity-from-linux-device-driver

and finally to irq_set_affinity()

http://lxr.free-electrons.com/source/kernel/irq/manage.c#L182

which can be called by drivers from inside the kernel context.

Do you think this could be a valuable idea to follow?

Regards,
Oliver
