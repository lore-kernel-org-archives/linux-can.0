From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH] CAN MAINTAINERS
Date: Fri, 02 Dec 2011 13:34:32 +0100
Message-ID: <4ED8C5D8.6000505@grandegger.com>
References: <48E9EDF6.4000009@pengutronix.de>	<4ED6B460.2010508@pengutronix.de>	<4ED7351E.2010907@grandegger.com>	<4ED745F6.8030302@pengutronix.de> <4ED7494F.6080603@grandegger.com>	<4ED74AC7.40605@pengutronix.de> <4ED75BD0.6070802@hartkopp.net> <4ED75EED.6010009@pengutronix.de> <4ED89050.3040201@hartkopp.net> <4ED8C2EB.1070507@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:41788 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab1LBMel (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2011 07:34:41 -0500
In-Reply-To: <4ED8C2EB.1070507@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, socketcan-core@lists.berlios.de, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Urs Thuermann <urs@isnogud.escape.de>

Hi Marc,

On 12/02/2011 01:22 PM, Marc Kleine-Budde wrote:
> On 12/02/2011 09:46 AM, Oliver Hartkopp wrote:
>> Hey Marc,
>>
>> i'm not as good as you using git. Indeed i'm a git newbie and do not have the
>> time right now to get in that deep that i dare to post correct pull requests
>> to netdev.
>>
>> Following the hints from Dave i checked the MAINTAINERS file how the wireless
>> guys handle their subsystem in detail. Regarding John Linville, who's
>> collecting all the stuff from several people to send finally push requests to
>> Dave i would suggest that you become our 'John Linville for CAN'.
> 
> Wolfgang and me talked about this (via PM), too. We do the job together,
> but I send the pull requests to Dave.

Thanks!

>> You speak git fluently and you know the project very good - so my suggestion
>> to clean up the MAINTAINTERS file is this:
> 
> The cleanups look got, however, do we need the linux-can tree. Do the
> wireless people have two trees?

I would drop it for the time being.

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 717d9e9..af8a0a9 100644
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
> 
> this should focus the discussion on linux-can

Well, but I think the patches still need to be presented on the netdev
ml? We should clarify that.

>> -W:	http://developer.berlios.de/projects/socketcan/
>> +W:	http://gitorious.org/linux-can
> 
> the can utils are now migrated (im my repo still)
> 
>>  S:	Maintained
>>  F:	net/can/
>>  F:	include/linux/can.h
>> @@ -1723,8 +1720,7 @@ F:	include/linux/can/gw.h
>>  CAN NETWORK DRIVERS
>>  M:	Wolfgang Grandegger <wg@grandegger.com>
>>  L:	linux-can@vger.kernel.org
>> -L:	netdev@vger.kernel.org
>> -W:	http://developer.berlios.de/projects/socketcan/
>> +W:	http://gitorious.org/linux-can
>>  S:	Maintained
>>  F:	drivers/net/can/
>>  F:	include/linux/can/dev.h
>> @@ -4587,6 +4583,17 @@ F:	include/linux/wireless.h
>>  F:	include/net/iw_handler.h
>>  F:	drivers/net/wireless/
>>
>> +NETWORKING [CAN]
>> +M:	Marc Kleine-Budde <mkl@pengutronix.de>
>> +L:	linux-can@vger.kernel.org
>> +W:	http://gitorious.org/linux-can
>> +T:	git://gitorious.org/linux-can/linux-can.git
> 
> do we need this tree?

I don't think so. You should be added to the CAN NETWORK DRIVERS entry
above.

Wolfgang.

