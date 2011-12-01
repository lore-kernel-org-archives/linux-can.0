From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: git-tree, NOW!
Date: Thu, 01 Dec 2011 11:49:52 +0100
Message-ID: <4ED75BD0.6070802@hartkopp.net>
References: <48E9EDF6.4000009@pengutronix.de> <4ED6B460.2010508@pengutronix.de>	<4ED7351E.2010907@grandegger.com> <4ED745F6.8030302@pengutronix.de> <4ED7494F.6080603@grandegger.com> <4ED74AC7.40605@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:40121 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab1LAKuK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 Dec 2011 05:50:10 -0500
In-Reply-To: <4ED74AC7.40605@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, socketcan-core@lists.berlios.de, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 01.12.2011 10:37, Marc Kleine-Budde wrote:

> On 12/01/2011 10:30 AM, Wolfgang Grandegger wrote:
>> On 12/01/2011 10:16 AM, Marc Kleine-Budde wrote:
> [...]
> 
>> Yes. So far we just tried to signal "patch is now ready" by adding our
>> "acked-by"... which does not work for a series of patches, espcially if
>> it touches other sub-systems as well (powerpc, devicetree).
> 
> Yes - but David sometimes merges patches if they are not reviewed. Like
> the pch-can driver, where I missed to reply to net-dev.


IMO if someone begins to post a new CAN driver on netdev we should pull him to
linux-can for further discussion & review. Indeed the PCH driver mainlining
was painful and IIRC it could still be merged to an other driver.

>>> I like Oliver's remark to first keep the discussion on the linux-can
>>> mailinglist and post the "final" series on netdev.
>>
>> Yes, don't ask me why I did not do that first, especially because some
>> tested-by's would have be useful. I also learned that some more serious
>> compile tests have to be done for different archs (x86, powerpc, arm, ...).
> 
>>>> That's also what Dave asks for. Apart from the tree he asks for someone
>>>> who acts as the one and only interface to him.
>>>
>>> Yes, technically that could/should be the git tree, in persona Wolfgang
>>> or/and (as Dave asked for one person) Oliver.
>>
>> Oliver?
> 
> +1
> 


Well - i'm pretty happy that we splitted up the responsibilities some time ago
and i'm currently only maintaining net/can. I'm working on this basically in
my spare time and putting my eyes on all driver details too exceeds the WAF ;-)

Regarding net/can there's not much traffic & change. So it would be ok for me
to stay on the current process on netdev-ML.

>>>>> I've setup a git repo on gitorious:
>>>>>
>>>>> https://gitorious.org/linux-can/linux-can
>>>>>
>>>>> It's based on net-next, and currently David's net-next/master is pushing
>>>>> there. It probably takes some time, the box pushing has just 4 mbit/s
>>>>> upstream.
>>>>>
>>>>> Comments?
>>>>
>>>> Apart from net-next, we may also need the net tree (as branch?).
>>>
>>> During merge windows David merges into his net-next tree, anyway I can
>>> setup linux-can and linux-can-next, based on the linux-net and
>>> linux-net-next trees.
>>
>> Do we need two trees? I thinks you can save a lot of bandwith (and disk
>> space) by using just one tree and two branches.


As the net tree only get's fixes i wonder why we should clone that tree?
Working directly on Dave's net-tree for fixes looks straight forward to me.

But the idea for a linux-can-next is great.

This would settle the process that we discuss new drivers & changes on
linux-can ML and finally commit the stuff in linux-can-next, where one of us
can send a pull request to Dave.

So everything beyond fixes would go this way then.

Regards,
Oliver
