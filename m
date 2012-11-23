From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Fri, 23 Nov 2012 15:47:45 +0100
Message-ID: <50AF8C91.3020307@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p  ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305@grandegger.com> <loom.20121121T184014-391
 @post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-106@post.gmane.org> <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060809@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:41932 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab2KWOrs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 23 Nov 2012 09:47:48 -0500
In-Reply-To: <50AF8C01.6060809@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

On 11/23/2012 03:45 PM, Wolfgang Grandegger wrote:
> On 11/23/2012 03:27 PM, Michael Pellegrini wrote:
>> Michael Pellegrini <mikep86 <at> gmail.com> writes:
>>
>>> My application has been running strong for about 45 minutes and counting with
>>> this driver.  I will leave the system running over Thanksgiving as a long-term
>>> test.
>>
>> The driver has unfortunately failed the long-term test.  When I checked the
>> PCH-System this morning, it had hit the transmission problem again.  Dmesg 
>> output is:
>>
>> [234700.232657] c_can_isr: irqstatus=0x6
>> [234700.232712] c_can_isr: irqstatus=0x6
>> [234700.232765] c_can_isr: irqstatus=0x6
>> [234700.232818] c_can_isr: irqstatus=0x6
>> [234700.232873] c_can_isr: irqstatus=0x6
>> [234700.232928] c_can_isr: irqstatus=0x6
>> [234700.232985] c_can_isr: irqstatus=0x6
>> [234700.233041] c_can_isr: irqstatus=0x6
>> [234700.233096] c_can_isr: irqstatus=0x6
>> [234700.233151] c_can_isr: irqstatus=0x6
>> [234700.233203] c_can_isr: irqstatus=0x6
>> [234700.233257] c_can_isr: irqstatus=0x6
>> [234700.233312] c_can_isr: irqstatus=0x6
>> [234700.233369] c_can_isr: irqstatus=0x6
>> [234700.233424] c_can_isr: irqstatus=0x6
>> [234700.233478] c_can_isr: irqstatus=0x6
> 
> Did you see any other related kernel messages? For real testing you
> should remove the debug message above. I will try to add a more
> sophisticated trigger.
> 
>> "ip -d -s link show can0" output is:
>>
>> 8: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
>>     link/can
>>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>>     bitrate 250000 sample-point 0.875
>>     tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
>>     c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
>>     clock 50000000
>>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>>     0          0          0          0          0          0
>>     RX: bytes  packets  errors  dropped overrun mcast
>>     102603     43967    0       0       0       0
>>     TX: bytes  packets  errors  dropped carrier collsns
>>     4487315    1082899  0       0       0       0
>>
>> I tried sending a message with "cansend can0 123#abcdef" and got the error 
>> message "write: No buffer space available".
> 
> Yes, that's the old problem.
> 
>> Additionally, data reception is broken.  I can confirm via the CAN Monitor
>> system that the External Node system is sending messages which the PCH-System
>> should be receiving.  However, the RX count is not increasing and 
>> "candump any,0:0,#FFFFFFFF" does not show any messages being transmitted or
>> received on the interface.
> 
> That's likely because the interrupt from the repeated message is not
> handled. We seem to have another race. Maybe device access needs to be
> protected as well.
> 
> Hope to find more time to look into this problem over the weekend.

When the module is loaded the driver prints out some values. Could you
please show the output?

Another question? At what rate do you send messages?

Thanks,

Wolfgang.

