From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Socketcan correct way to bootup...
Date: Thu, 10 Jul 2014 01:45:04 +0200
Message-ID: <53BDD400.70904@hartkopp.net>
References: <53BD1BE1.8050403@eurekelettronica.it> <53BD248F.5030608@pengutronix.de> <CAGm1_kuBTJEsTjrYCtop6vcdB+pyNe64bjVgMbz6F0bXsGsHeg@mail.gmail.com> <53BD3766.6090202@pengutronix.de> <CAGm1_ku46OgLXoMPZqKMSQ06=vQV5MjbbvEKkBagJ1_C9g7BUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:36677 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923AbaGIXqA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Jul 2014 19:46:00 -0400
In-Reply-To: <CAGm1_ku46OgLXoMPZqKMSQ06=vQV5MjbbvEKkBagJ1_C9g7BUg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, gianluca <gianlucarenzi@eurekelettronica.it>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

For Debian systems I use this script:

https://gitorious.org/linux-can/can-misc/source/etc/can_if

Just copy can_if to /etc/init.d and say

update-rc.d can_if defaults

Btw. Debian changed to systemd. So far this script still run's with
the latest Debian unstable (which used systemd).

Regards,
Oliver


On 09.07.2014 14:44, Yegor Yefremov wrote:
> On Wed, Jul 9, 2014 at 2:36 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> On 07/09/2014 02:29 PM, Yegor Yefremov wrote:
>>>> BTW: you probably want to integrate your application into the automatic
>>>> startup via an init script or in new designs with systemd...and _not_
>>>> start it by hand.
>>>
>>> You can also use libsocketcan or libnl to configure CAN interface
>>> directly from your application.
>>
>> Good point.
>>
>> here's libsocketcan's API:
>>
>> http://git.pengutronix.de/?p=tools/libsocketcan.git;a=blob;f=include/libsocketcan.h;h=dc52053b824d1a8976126b043de4ee5d843c1401;hb=0c91940da1c16e01e8220e9fa18c703852ba6d1b
>>
>> http://www.pengutronix.de/software/libsocketcan/download/
> 
> If you're using Buildroot (http://buildroot.uclibc.org/) or OpenWrt
> (https://openwrt.org/) you'll find libsocketcan already being
> integrated into their repositories. I don't know about OpenEmbedded
> universe.
> 
> Yegor
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
