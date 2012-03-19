From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: SocketCAN support in Android
Date: Mon, 19 Mar 2012 17:10:03 +0100
Message-ID: <4F675A5B.3060500@hartkopp.net>
References: <4F4B4C47.4060601@visionsystems.de> <4F6743A5.8050505@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:56088 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030956Ab2CSQKG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Mar 2012 12:10:06 -0400
In-Reply-To: <4F6743A5.8050505@visionsystems.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegor_sub1@visionsystems.de
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>

Hello Yegor,

On 19.03.2012 15:33, Yegor Yefremov wrote:

> Am 27.02.2012 10:26, schrieb Yegor Yefremov:
>> I'm working with TI's am3517. The next generation 33xx is also on the way. Considering lot's of requests about SpcketCAN support in Android on various mailing lists and forums I wanted to summarize how I see this situation:
>>
>> 1. ip from iproute2. Android version prior 4.0 provided only tc utility from iproute2 and due to header issues in NDK there were no easy way to get ip compiled. Ice Cream Sandwich introduced ip support, but ip/iplink_can.c symbols are missing in final ip binary, so it is not usable now. I tried to figure out what's wrong, but failed, so any help would be appreciated.
> 
> This issue is theoretically fixed (https://android-review.googlesource.com/#/c/34240/)


Good job!


>> 2. NDK: can.h is still not a part of NDK's headers, so for now can.h must be supplied to compile can-utils and user software. As one can see from this post: https://groups.google.com/d/topic/android-ndk/K1w5IqGSKCA/discussion NDK dev's don't seem to accept CAN as standard kernel protocol. Lobby work needed ;-)
> 
> what headers are necessary/usable for userspace? linux/can.h, linux/can/raw.h - what else? 
> 
> I've added all of then to NDK, patches some other headers and could cross-compile candump. Now it is working. As soon as I'm finished I would like Android.mk file to be included in can-utils. I hope it will be O.K.


candump only needs linux/can.h and linux/can/raw.h
cansniffer also needs linux/can/bcm.h

So adding all includes (as it is also done by the iproute2 package too) is a
good idea.

Additionally to

linux/can.h

there is the userspace relevant stuff from

http://lxr.linux.no/#linux+v3.3/include/linux/can/Kbuild

needed:

linux/can/raw.h
linux/can/bcm.h
linux/can/gw.h
linux/can/error.h
linux/can/netlink.h

>  
>> 3. As soon as there is solution for both issues, Java wrapper will be needed to enable App development
> 
> Still open.
> 


What kind of java wrapper do you think of?

Do you know Kayak? http://2codeornot2code.org/?p=1033

Kayak is using a socketcand which offers a network transparent interface via
IP to omit a JNI for SocketCAN which would also be an approach indeed.

Regards,
Oliver
