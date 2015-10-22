From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: c_can: wrong frame order reception
Date: Thu, 22 Oct 2015 07:05:35 +0200
Message-ID: <56286E9F.7040909@hartkopp.net>
References: <2323199.vffRdFDsB5@ws-stein> <7234338.9RqiOdiLOY@ws-stein> <533B067A.3030609@hartkopp.net> <1451869.V7QBi99RiY@ws-stein> <cdaa71c3255e192a2dea2e4f3f26e49a@grandegger.com> <loom.20151021T111146-165@post.gmane.org> <5627A245.50401@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:30338 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbJVFFn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Oct 2015 01:05:43 -0400
In-Reply-To: <5627A245.50401@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, wouter van herpen <wouter.van.herpen@prodrive-technologies.com>, linux-can@vger.kernel.org

Hi Wouter,

On 21.10.2015 16:33, Marc Kleine-Budde wrote:
> On 10/21/2015 11:19 AM, wouter van herpen wrote:
>> I am currently working on the Intel atom platform with EG20T.
>>
>> Using the c_can driver from the main line 4.1.10 kernel sources, I still see
>> frames received in a swapped order.
>>
>> It looks like all the patches mentioned in the list above are already
>> applied in this main line c_can driver.
>>
>> Is the frame order swapping still a known issue? Are there any additional
>> patches regarding this issue that I'm not aware off?
>
> Maybe Oliver can help. What's needed on a v4.1.10 SMP system to fix the
> RX order?
>

you can try to use the SMP-affinity to pin the innterrupt to a specific CPU:

	https://www.kernel.org/doc/Documentation/IRQ-affinity.txt

But we're currently also checking the usability of receive packet steering 
(RPS) on SMP systems. Please check

	http://marc.info/?l=linux-can&m=144251788500555&w=2

whether just using

	echo f > /sys/class/net/can0/queues/rx-0/rps_cpus

helps in you case or whether you need to set the skb hash which is suggested 
there too.

Best regards,
Oliver
