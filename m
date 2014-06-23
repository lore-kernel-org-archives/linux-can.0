From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Gitorious] Activity: prabhakar requested a merge of prab...
Date: Mon, 23 Jun 2014 18:30:07 +0200
Message-ID: <53A8560F.4060607@hartkopp.net>
References: <53a829dc98811_78d23ff48250bea851769@ratt.gitorious.c.bitbit.net.mail> <53A851DC.2060801@hartkopp.net> <53A85445.8070400@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:8503 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756019AbaFWQaL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Jun 2014 12:30:11 -0400
In-Reply-To: <53A85445.8070400@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, prabhakar.csengg@gmail.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 23.06.2014 18:22, Marc Kleine-Budde wrote:
> On 06/23/2014 06:12 PM, Oliver Hartkopp wrote:
>> Hi Prabhakar,
>>
>> thanks for your patch.
>>
>> Can you please send it with git send-email to the mailing list for a review?
>>
>> Additionally:
>>
>> Does this patch introduce any backward compatibility restrictions (e.g. you
>> need at least the includes from 2.6.14+ to build candump ...).
> 
> When was CAN support added to the linux kernel? :)

I know that you would detect this joke ;-)
Btw. I backported SocketCAN to 2.6.13 - so my question is not totally
brain-damaged when talking about the can-utils which are not sticking to a
specific kernel version.

> 
>> You only provide to configure a value for SCHED_RR.
>> Does it make sense to provide other scheduling policies too?
> 
> I would use chrt to start the tool, if I need non standard scheduling
> policies.

But then you would like to specifiy the scheduling policy??

Regards,
Oliver

