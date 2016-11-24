From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: wrong CAN frame order in network layer due to SMP?
Date: Thu, 24 Nov 2016 16:49:13 +0100
Message-ID: <1864402.pXgGBBp51L@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:45001 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966250AbcKXPtZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Nov 2016 10:49:25 -0500
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
        by webbox1416.server-home.net (Postfix) with ESMTPA id 1D94427A711
        for <linux-can@vger.kernel.org>; Thu, 24 Nov 2016 16:49:18 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Daniel =?ISO-8859-1?Q?Kr=FCger?= <daniel.krueger@systec-electronic.com>

Hi,

I experienced a rather interesting problem while doing a CAN burst test.
This sends a bunch of CAN frames while each frame has a counter in it and the 
receiver checks if the counter are in correct order.
Now I got the error about wrong order:
> Error on MSG ID 0x251. Got counter 141606 and expected 141605
> Error on MSG ID 0x251. Got counter 141605 and expected 141607
> Error on MSG ID 0x251. Got counter 141607 and expected 141606

Here is the corresponding part from "candump -t d -a -x any -l"
> (1479993291.766686) can0 251#00022926
> (1479993291.766574) can0 251#00022925
> (1479993291.766816) can0 251#00022927

And in fact they are ordered wrongly. But the timestamps are correct, e.g. if 
you reorder the frame by timestamp the order of counters is ok. This also 
shows that the order is wrong on both sockets in the same way!

The used driver is systec_can (downloadable at [1] if you like).
But the driver is not to blame: In the URB complete callback a SKB is created 
and passed to network stack by netif_rx.
The timestamp is set by net_timestamp_check() directly at the beginning of 
netif_rx_internal() so at this point the frames are still in order.
In enqueue_to_backlog the skb are enqueued in some per_cpu softnet_data. I 
don't know the details.
Now per_cpu gave me a hint the problem might be caused by SMP. So I put 7 of 
my 8 cores offline:
> for i in $(seq 1 7); do echo 0 > /sys/bus/cpu/devices/cpu${i}/online; done
Repeating the test run resulted in no order problems. My guess is that the USB 
interrupt is done on different cores and that gathering the SKBs to be put in 
the sockets is somewhat racy.
This is supported by the fact after puttng the core online again:
> for i in $(seq 1 7); do echo 1 > /sys/bus/cpu/devices/cpu${i}/online; done
there are still no order problems. But this again is caused by the fact 
(probably a bug in ACPI tables of my local machine) that any CPU put back 
online serves no IO-APIC or MSI IRQs. This can easily be checked by calling:
> watch -d -n 1 cat /proc/interrupts
See that interrupts are handled on different CPUs. Put some CPUs (or all but 
one) offline and online again. The ones which went offline dont serve any IO-
APIC or MSI IRQs (so including the one for ehci_hcd).
Back to my CAN problem: Only a single core handles USB IRQs and there is 
apparently no softnet_data race.
The test about wrong CAN frame ordering was done on kernel 4.8.9-gentoo but I 
was also able to reproduce this problem on 3.14.58-gentoo-r1. 3.12.52-gentoo-
r1 apparently does not suffer from that problem, at least 3 tries were without 
errors. In buggy kernels this problems occured next to every time.

Any idea what got wrong in the network code about gathering the SKBs 
which might result in wrong order?

Best regards,
Alexander

[1] http://www.systec-electronic.com/en/products/industrial-communication/interfaces-and-gateways/can-usb-adapter-usb-canmodul1
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010
