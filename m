From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: c_can: wrong frame order reception
Date: Thu, 22 Oct 2015 19:01:45 +0200
Message-ID: <56291679.8060407@hartkopp.net>
References: <2323199.vffRdFDsB5@ws-stein> <7234338.9RqiOdiLOY@ws-stein> <533B067A.3030609@hartkopp.net> <1451869.V7QBi99RiY@ws-stein> <cdaa71c3255e192a2dea2e4f3f26e49a@grandegger.com> <loom.20151021T111146-165@post.gmane.org> <5627A245.50401@pengutronix.de> <56286E9F.7040909@hartkopp.net> <loom.20151022T114518-579@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:27627 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757280AbbJVRBu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Oct 2015 13:01:50 -0400
In-Reply-To: <loom.20151022T114518-579@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wouter van herpen <wouter.van.herpen@prodrive-technologies.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Wouter,



On 10/22/2015 11:50 AM, wouter van herpen wrote:
>> you can try to use the SMP-affinity to pin the innterrupt to a specific CPU:
>>
>> 	https://www.kernel.org/doc/Documentation/IRQ-affinity.txt
>>
>> But we're currently also checking the usability of receive packet steering 
>> (RPS) on SMP systems. Please check
>>
>> 	http://marc.info/?l=linux-can&m=144251788500555&w=2
>>
>> whether just using
>>
>> 	echo f > /sys/class/net/can0/queues/rx-0/rps_cpus
>>
>> helps in you case or whether you need to set the skb hash which is suggested 
>> there too.
>>
>>
> 
> Hi Oliver,
> 
> I have tried SMP affinity, in combination with adjusting
> /sys/class/net/can0/queues/rx-0/rps_cpus. These changes did not solve the
> out of order reception.
> Also adding skb_set_hash(skb, dev->ifindex, PKT_HASH_TYPE_L2); did not make
> a difference.

That's pretty bad!

> 
> Do you have any other suggestions?

No. Indeed setting an interrupt with SMP affinity to a single CPU is already
the 'strongest' tool I know.

Did you also try SMP affinity without changing the RPS settings?

> 
> I have also done some testing with the pch_can driver. I noticed there the
> out of order receptions are less frequent. Using the pch_can driver, OOO
> reception only occurs if we stress the CPU over e.g. UART.
> Using c_can driver, the OOO replies occur more often.

@Marc: Both drivers (c_can/pch_can) use NAPI. Would it make sense to convert
e.g. the c_can driver to non-NAPI for a test?

Regards,
Oliver
