From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] CAN MAINTAINERS
Date: Fri, 02 Dec 2011 14:55:38 +0100
Message-ID: <4ED8D8DA.2030105@hartkopp.net>
References: <48E9EDF6.4000009@pengutronix.de>	<4ED6B460.2010508@pengutronix.de>	<4ED7351E.2010907@grandegger.com>	<4ED745F6.8030302@pengutronix.de>	<4ED7494F.6080603@grandegger.com>	<4ED74AC7.40605@pengutronix.de>	<4ED75BD0.6070802@hartkopp.net>	<4ED75EED.6010009@pengutronix.de>	<4ED89050.3040201@hartkopp.net>	<4ED8C2EB.1070507@pengutronix.de> <4ED8C5D8.6000505@grandegger.com>	<4ED8CF58.3010109@hartkopp.net> <4ED8D3FD.60301@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:51826 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596Ab1LBNzw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2011 08:55:52 -0500
In-Reply-To: <4ED8D3FD.60301@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: socketcan-core@lists.berlios.de, Urs Thuermann <urs@isnogud.escape.de>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 02.12.2011 14:34, Wolfgang Grandegger wrote:

>> Ok. So we stick to use Daves net-tree for fixes and send patches for the
>> net-tree the old way, right?
> 
> Don't now what Dave's preference is.


If we present fixes to the net-tree via pull request, we would need a
linux-can.git again to pull from ...

> 
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 717d9e9..af8a0a9 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -1707,11 +1707,8 @@ F:	arch/x86/include/asm/tce.h
>>>>>
>>>>>  CAN NETWORK LAYER
>>>>>  M:	Oliver Hartkopp <socketcan@hartkopp.net>
>>>>> -M:	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
>>>>> -M:	Urs Thuermann <urs.thuermann@volkswagen.de>
>>>>>  L:	linux-can@vger.kernel.org
>>>>> -L:	netdev@vger.kernel.org
>>>>
>>>> this should focus the discussion on linux-can
>>>
>>> Well, but I think the patches still need to be presented on the netdev
>>> ml? We should clarify that.
>>
>>
>> I already thought about that too.
>>
>> I think for CAN drivers there's no need for extra discussions on netdev.
>> But for net/can changes i would always post the patches on linux-can and
>> netdev to get the networking guys like Eric and Patrick into the loop for a
>> review.
>>
>> Btw. we should ask if Dave would like the stuff from our linux-can-next only
>> as pull request or additionally in full source code.
> 
> As the patch goes through Dave's tree, I think the patch *must* be
> posted on the netdev ML.


Looking to the wireless guys:

net Fixes are sent with source.
  http://patchwork.ozlabs.org/patch/128561/

net-next Pull requests are sent without source.
  http://patchwork.ozlabs.org/patch/128071/

But i don't think we would have that much changes, that sending the source
becomes annoying. So you are right: We should send our pull requests with src.

> 
>> Just to make it sure: When there are new ideas in net/can i would only post
>> RFCs on netdev & linux-can. And once there is no new feedback - what would be
>> the correct way:
>>
>> - send it on netdev and then acked-by Marc
> 
> Either you, Marc or myself will pick it up and push it onto the
> linux-can-next tree. We will need to add a "signed-off-by" then!!!


ok.

> I does make sense to have a separate branch for development where we can
> push our changes to and then Marc merges them to the "to-net-next"
> branch.


ok.

> Note also that we need to rebase our patches regularly (re-sync
> with net-next), especially before sending the pull request. But Marc
> knows better...
> 
>> - send it on linux-can, push it into linux-can-next, and send a pull request?
> 
> Well, we still need to define the procedure. We could also use the
> patchwork infrastructure to handle the patches.
> 
> ...
> 
>> Here is an update:
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 717d9e9..7417c92 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1707,11 +1707,8 @@ F:	arch/x86/include/asm/tce.h
>>
>>  CAN NETWORK LAYER
>>  M:	Oliver Hartkopp <socketcan@hartkopp.net>
>> -M:	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
>> -M:	Urs Thuermann <urs.thuermann@volkswagen.de>
>>  L:	linux-can@vger.kernel.org
>> -L:	netdev@vger.kernel.org
>> -W:	http://developer.berlios.de/projects/socketcan/
>> +W:	http://gitorious.org/linux-can
>>  S:	Maintained
>>  F:	net/can/
>>  F:	include/linux/can.h
>> @@ -1722,9 +1719,9 @@ F:	include/linux/can/gw.h
>>
>>  CAN NETWORK DRIVERS
>>  M:	Wolfgang Grandegger <wg@grandegger.com>
>> +M:	Marc Kleine-Budde <mkl@pengutronix.de>
>>  L:	linux-can@vger.kernel.org
>> -L:	netdev@vger.kernel.org
>> -W:	http://developer.berlios.de/projects/socketcan/
>> +W:	http://gitorious.org/linux-can
>>  S:	Maintained
>>  F:	drivers/net/can/
>>  F:	include/linux/can/dev.h
>> @@ -4587,6 +4584,16 @@ F:	include/linux/wireless.h
>>  F:	include/net/iw_handler.h
>>  F:	drivers/net/wireless/
>>
>> +NETWORKING [CAN]
>> +M:	Marc Kleine-Budde <mkl@pengutronix.de>
>> +L:	linux-can@vger.kernel.org
>> +W:	http://gitorious.org/linux-can
>> +T:	git://gitorious.org/linux-can/linux-can-next.git
>> +S:	Maintained
>> +F:	net/can/
>> +F:	drivers/net/can/
>> +F:	include/linux/can*
>> +
> 
> Please drop the entry above and move the "T" line to the CAN NETWORK
> DRIVERS and PROTOCOL entries. can/net changes have also go through the
> git repository.


Ok. To add the "T" lines to the above entries is fine to me.

But the last entry was the idea to document to Dave who's his interfacing
person. IMO that's important for him to know.

Regards,
Oliver
