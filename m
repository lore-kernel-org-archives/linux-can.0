From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Wed, 11 Apr 2012 21:36:05 +0200
Message-ID: <CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
	<4F852161.90706@hartkopp.net>
	<CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com>
	<4F85D553.2010303@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49402 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760932Ab2DKTgH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 15:36:07 -0400
Received: by wibhj6 with SMTP id hj6so4750590wib.1
        for <linux-can@vger.kernel.org>; Wed, 11 Apr 2012 12:36:06 -0700 (PDT)
In-Reply-To: <4F85D553.2010303@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Wed, Apr 11, 2012 at 9:02 PM, Oliver Hartkopp <socketcan@hartkopp.ne=
t> wrote:
>>> And we should probably add a new CAN netlink command here
>>>
>>> =A0 =A0 =A0 =A0http://lxr.linux.no/#linux+v3.3.1/drivers/net/can/de=
v.c#L577
>>>
>>> to configure the LED timer per interface: 0 -> LEDs off (=3D=3Ddefa=
ult)
>>
>> Nice... I'm taking notes here. :-)
>
>
> Hm - probably this is a bit heavy weighted suggestion from me.
>
> Do you really think the timer value needs to be configurable or is a =
simple
> on/off switch ok too?

I think that if the bus only has a light traffic a longer time would
be more helpful, otherwise any fixed time of some tenths of
milliseconds should just do the job (that's how ledtrig-ide-disk
works). A single module parameter looked like a decent compromise to
me.

I should add a check to skip it entirely if led_off_delay =3D=3D 0 as a
run-time "optimization" if the feature is not used (triggers does not
provide a use-counter). Do you think it should be disabled by default?

> The second question:
>
> Is the LED "blinking" on traffic or is it just "on" for some time whe=
n a CAN
> frame is processed?

It stays on for some time after each frame. Above a certain
packet-rate (1/led_off_delay) LED appear to be constantly on. You can
tell periodic packets from bursts from it but nothing more.

Quick not-so-off-topic - I have a small userspace deamon on my router
which blinks an LED every 100kB of traffic on the WAN interface, which
is nice because you can almost tell the network load just by looking
at it! Much more useful than the standard activity LED. (sometimes I
think I'm taking this too seriously...)

Regards.

--=20
=46abio Baltieri
