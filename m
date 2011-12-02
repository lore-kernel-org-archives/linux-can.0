From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] CAN MAINTAINERS
Date: Fri, 02 Dec 2011 14:15:04 +0100
Message-ID: <4ED8CF58.3010109@hartkopp.net>
References: <48E9EDF6.4000009@pengutronix.de>	<4ED6B460.2010508@pengutronix.de>	<4ED7351E.2010907@grandegger.com>	<4ED745F6.8030302@pengutronix.de>	<4ED7494F.6080603@grandegger.com>	<4ED74AC7.40605@pengutronix.de>	<4ED75BD0.6070802@hartkopp.net> <4ED75EED.6010009@pengutronix.de>	<4ED89050.3040201@hartkopp.net> <4ED8C2EB.1070507@pengutronix.de> <4ED8C5D8.6000505@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:28880 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311Ab1LBNPM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2011 08:15:12 -0500
In-Reply-To: <4ED8C5D8.6000505@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: socketcan-core@lists.berlios.de, Urs Thuermann <urs@isnogud.escape.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 02.12.2011 13:34, Wolfgang Grandegger wrote:

> Hi Marc,
> 
> On 12/02/2011 01:22 PM, Marc Kleine-Budde wrote:
>> On 12/02/2011 09:46 AM, Oliver Hartkopp wrote:
>>> Hey Marc,
>>>
>>> i'm not as good as you using git. Indeed i'm a git newbie and do not have the
>>> time right now to get in that deep that i dare to post correct pull requests
>>> to netdev.
>>>
>>> Following the hints from Dave i checked the MAINTAINERS file how the wireless
>>> guys handle their subsystem in detail. Regarding John Linville, who's
>>> collecting all the stuff from several people to send finally push requests to
>>> Dave i would suggest that you become our 'John Linville for CAN'.
>>
>> Wolfgang and me talked about this (via PM), too. We do the job together,
>> but I send the pull requests to Dave.
> 
> Thanks!


Many thanks!

> 
>>> You speak git fluently and you know the project very good - so my suggestion
>>> to clean up the MAINTAINTERS file is this:
>>
>> The cleanups look got, however, do we need the linux-can tree. Do the
>> wireless people have two trees?
> 
> I would drop it for the time being.


Ok. So we stick to use Daves net-tree for fixes and send patches for the
net-tree the old way, right?


> 
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 717d9e9..af8a0a9 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1707,11 +1707,8 @@ F:	arch/x86/include/asm/tce.h
>>>
>>>  CAN NETWORK LAYER
>>>  M:	Oliver Hartkopp <socketcan@hartkopp.net>
>>> -M:	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
>>> -M:	Urs Thuermann <urs.thuermann@volkswagen.de>
>>>  L:	linux-can@vger.kernel.org
>>> -L:	netdev@vger.kernel.org
>>
>> this should focus the discussion on linux-can
> 
> Well, but I think the patches still need to be presented on the netdev
> ml? We should clarify that.


I already thought about that too.

I think for CAN drivers there's no need for extra discussions on netdev.
But for net/can changes i would always post the patches on linux-can and
netdev to get the networking guys like Eric and Patrick into the loop for a
review.

Btw. we should ask if Dave would like the stuff from our linux-can-next only
as pull request or additionally in full source code.

Just to make it sure: When there are new ideas in net/can i would only post
RFCs on netdev & linux-can. And once there is no new feedback - what would be
the correct way:

- send it on netdev and then acked-by Marc
- send it on linux-can, push it into linux-can-next, and send a pull request?

???

>

>>> -W:	http://developer.berlios.de/projects/socketcan/
>>> +W:	http://gitorious.org/linux-can
>>
>> the can utils are now migrated (im my repo still)


fine.

>>
>>>  S:	Maintained
>>>  F:	net/can/
>>>  F:	include/linux/can.h
>>> @@ -1723,8 +1720,7 @@ F:	include/linux/can/gw.h
>>>  CAN NETWORK DRIVERS
>>>  M:	Wolfgang Grandegger <wg@grandegger.com>
>>>  L:	linux-can@vger.kernel.org
>>> -L:	netdev@vger.kernel.org
>>> -W:	http://developer.berlios.de/projects/socketcan/
>>> +W:	http://gitorious.org/linux-can
>>>  S:	Maintained
>>>  F:	drivers/net/can/
>>>  F:	include/linux/can/dev.h
>>> @@ -4587,6 +4583,17 @@ F:	include/linux/wireless.h
>>>  F:	include/net/iw_handler.h
>>>  F:	drivers/net/wireless/
>>>
>>> +NETWORKING [CAN]
>>> +M:	Marc Kleine-Budde <mkl@pengutronix.de>
>>> +L:	linux-can@vger.kernel.org
>>> +W:	http://gitorious.org/linux-can
>>> +T:	git://gitorious.org/linux-can/linux-can.git
>>
>> do we need this tree?
> 
> I don't think so. You should be added to the CAN NETWORK DRIVERS entry
> above.


Here is an update:

diff --git a/MAINTAINERS b/MAINTAINERS
index 717d9e9..7417c92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1707,11 +1707,8 @@ F:	arch/x86/include/asm/tce.h

 CAN NETWORK LAYER
 M:	Oliver Hartkopp <socketcan@hartkopp.net>
-M:	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
-M:	Urs Thuermann <urs.thuermann@volkswagen.de>
 L:	linux-can@vger.kernel.org
-L:	netdev@vger.kernel.org
-W:	http://developer.berlios.de/projects/socketcan/
+W:	http://gitorious.org/linux-can
 S:	Maintained
 F:	net/can/
 F:	include/linux/can.h
@@ -1722,9 +1719,9 @@ F:	include/linux/can/gw.h

 CAN NETWORK DRIVERS
 M:	Wolfgang Grandegger <wg@grandegger.com>
+M:	Marc Kleine-Budde <mkl@pengutronix.de>
 L:	linux-can@vger.kernel.org
-L:	netdev@vger.kernel.org
-W:	http://developer.berlios.de/projects/socketcan/
+W:	http://gitorious.org/linux-can
 S:	Maintained
 F:	drivers/net/can/
 F:	include/linux/can/dev.h
@@ -4587,6 +4584,16 @@ F:	include/linux/wireless.h
 F:	include/net/iw_handler.h
 F:	drivers/net/wireless/

+NETWORKING [CAN]
+M:	Marc Kleine-Budde <mkl@pengutronix.de>
+L:	linux-can@vger.kernel.org
+W:	http://gitorious.org/linux-can
+T:	git://gitorious.org/linux-can/linux-can-next.git
+S:	Maintained
+F:	net/can/
+F:	drivers/net/can/
+F:	include/linux/can*
+
 NETWORKING DRIVERS
 L:	netdev@vger.kernel.org
 W:	http://www.linuxfoundation.org/en/Net


Regards,
Oliver
