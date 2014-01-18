From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 5/5] include: Move includes copied from the Linux kernel
 into include/linux
Date: Sat, 18 Jan 2014 13:18:14 +0100
Message-ID: <52DA7106.5000300@hartkopp.net>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de> <1389888754-23013-6-git-send-email-mkl@pengutronix.de> <20140116192818.GC25911@pengutronix.de> <52D85910.8000200@pengutronix.de> <20140117133709.GD25911@pengutronix.de> <52D93885.5040109@pengutronix.de> <20140117203605.GF25911@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:63963 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbaARMSR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 18 Jan 2014 07:18:17 -0500
In-Reply-To: <20140117203605.GF25911@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 17.01.2014 21:36, Uwe Kleine-K=F6nig wrote:

>>
>> https://gitorious.org/linux-can/can-modules
> Is it a possibility to merge can-modules and can-utils?

NO!

> Then there would
> only a single instance of isotp.h be needed.=20

NO!

> IIUC the source of isotp.h
> is in can-modules. If so, adding a license to it should be done in
> can-modules, too.

Uwe,

please take a look at the history of the things you are trying to re-or=
ganize
all the time.

If you look at the original BerliOS SVN

	http://developer.berlios.de/svn/?group_id=3D6475

you'll see that it was exactly like this.

There were utils, test applications and the kernel stuff in one single =
SVN
referring one single include directory which was located in

	trunk/kernel/2.6/include/socketcan

to not interfere with existing or different kernel includes.

This worked pretty fine that time as it also was intended to be able to
backport updated CAN stuff into older kernels like 2.6.18.

Therefore several scripts (see trunk/mkpatch) had been used to create p=
atches
that remove the existing stuff in linux/net/can and update the entire C=
AN
subsystem with a newer version with bugfixes and feature enhancements.

Doing this we were able to include e.g. the can-gw or the developed iso=
tp into
an older OSELAS BSP with 2.6.28.10 kernel.

But that's history.

With the move to gitorious the SVN trunk was splitted into several inde=
pendent
git repos that were just in sub-directories before:

- can-utils
- can-tests
- can-misc
- can-modules
- can-modules-24

To have these separate git repos the includes became part of every sing=
le repo
- which is not very optimal ...

Btw. the iproute2 package has a similar requirements to contain updated=
 kernel
includes.

So today (6 years after PF_CAN mainline) the stuff in can-modules(-24) =
is not
really maintained anymore as supporting 2.4.x and 2.6.2x kernels is not=
 that
relevant now. The only stuff that needs to be brought to mainline isotp=
=2Ec .

So I would just let the hands off can-modules(-24) as the new developme=
nt is
done in recent git repos like https://gitorious.org/linux-can/linux-can=
-next.

The isotp socket API has been established for a while now and is used b=
y
several peoples. As I do not expect any changes to isotp.h it's ok to h=
ost it
together(!) with the other kernel includes we've been discussion before=
=2E

As we only talk about userspace applications now the way using
include/socketcan which was needed for the stuff in trunk/kernel/2.6/ne=
t/can
became obviously obsolete in can-utils and can-tests.

The stuff in can-utils and can-tests are widely used and therefore I
appreciate your work to clean up the includes and update the license
information there. But you can omit any further activities in can-modul=
es.

Regards,
Oliver

ps. @Marc: Your patch "[PATCH v6 5/5] include: Move includes from
include/socketcan to include/linux" moves the *current* files. There ar=
e still
no updates in the license information in can.h, can/raw.h, ... Tnx

