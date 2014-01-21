From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v5 5/5] include: Move includes copied from the Linux
 kernel into include/linux
Date: Tue, 21 Jan 2014 10:59:41 +0100
Message-ID: <CAGm1_kuUdfzHKedRfEi1vX3k7ALUBv4t6gzUzDqwSchpr_3xzg@mail.gmail.com>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de>
 <1389888754-23013-6-git-send-email-mkl@pengutronix.de> <20140116192818.GC25911@pengutronix.de>
 <52D85910.8000200@pengutronix.de> <20140117133709.GD25911@pengutronix.de>
 <52D93885.5040109@pengutronix.de> <20140117203605.GF25911@pengutronix.de>
 <52DA7106.5000300@hartkopp.net> <20140121095337.GR25911@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:65090 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbaAUKAE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 05:00:04 -0500
Received: by mail-bk0-f47.google.com with SMTP id d7so1715434bkh.6
        for <linux-can@vger.kernel.org>; Tue, 21 Jan 2014 02:00:01 -0800 (PST)
In-Reply-To: <20140121095337.GR25911@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Tue, Jan 21, 2014 at 10:53 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Sat, Jan 18, 2014 at 01:18:14PM +0100, Oliver Hartkopp wrote:
>> On 17.01.2014 21:36, Uwe Kleine-K=C3=B6nig wrote:
>>
>> >>
>> >> https://gitorious.org/linux-can/can-modules
>> > Is it a possibility to merge can-modules and can-utils?
>>
>> NO!
> Did I hit another red button? If so I'm sorry, that was not my
> intention.
>
>> > Then there would
>> > only a single instance of isotp.h be needed.
>>
>> NO!
> ?? If can-modules and can-utils were merged both the kernel module an=
d
> the userspace stuff could use the same header. I don't understand you
> "NO!" here.
>
>> [...]
> I don't see a real reason here, but I read between the lines that you
> prefer isotp to go into the kernel directly instead of into can-utils
> first.
> Anyhow, what I care for is to be able to package can-utils for Debian=
=2E
> That's what I can do once the updated headers hit can-utils so IMO we
> can stop arguing even if we don't agree 100%.

@Uwe: do you mean fixing this bug
(http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D568303)? Two devs
are already preparing the package, so the final license clean up would
be great to finish the packaging process.

Yegor
