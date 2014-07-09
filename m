From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: Socketcan correct way to bootup...
Date: Wed, 9 Jul 2014 14:44:57 +0200
Message-ID: <CAGm1_ku46OgLXoMPZqKMSQ06=vQV5MjbbvEKkBagJ1_C9g7BUg@mail.gmail.com>
References: <53BD1BE1.8050403@eurekelettronica.it> <53BD248F.5030608@pengutronix.de>
 <CAGm1_kuBTJEsTjrYCtop6vcdB+pyNe64bjVgMbz6F0bXsGsHeg@mail.gmail.com> <53BD3766.6090202@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:56588 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbaGIMpS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Jul 2014 08:45:18 -0400
Received: by mail-pa0-f47.google.com with SMTP id kq14so9121718pab.20
        for <linux-can@vger.kernel.org>; Wed, 09 Jul 2014 05:45:17 -0700 (PDT)
In-Reply-To: <53BD3766.6090202@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: gianluca <gianlucarenzi@eurekelettronica.it>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Wed, Jul 9, 2014 at 2:36 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 07/09/2014 02:29 PM, Yegor Yefremov wrote:
>>> BTW: you probably want to integrate your application into the automatic
>>> startup via an init script or in new designs with systemd...and _not_
>>> start it by hand.
>>
>> You can also use libsocketcan or libnl to configure CAN interface
>> directly from your application.
>
> Good point.
>
> here's libsocketcan's API:
>
> http://git.pengutronix.de/?p=tools/libsocketcan.git;a=blob;f=include/libsocketcan.h;h=dc52053b824d1a8976126b043de4ee5d843c1401;hb=0c91940da1c16e01e8220e9fa18c703852ba6d1b
>
> http://www.pengutronix.de/software/libsocketcan/download/

If you're using Buildroot (http://buildroot.uclibc.org/) or OpenWrt
(https://openwrt.org/) you'll find libsocketcan already being
integrated into their repositories. I don't know about OpenEmbedded
universe.

Yegor
