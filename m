From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils v2 1/3] headers: use include/linux only for
 Linux kernel headers
Date: Mon, 13 Jan 2014 07:23:55 +0100
Message-ID: <52D3867B.6090108@hartkopp.net>
References: <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389561879-16729-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389561879-16729-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:27717 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbaAMGX5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 01:23:57 -0500
In-Reply-To: <1389561879-16729-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>

Hello Uwe,

On 12.01.2014 22:24, Uwe Kleine-K=F6nig wrote:

>  - use __kernel_sa_family_t instead of sa_family_t which requires
>    <linux/socket.h from Linux 3.1 or later. Unfortunately this makes
>    can-utils FTBFS on e.g. Debian squeeze. If this is an issue this
>    could be fixed by adding something like:

This was exactly the idea to have a separate set of include files to ma=
ke sure
the 'newest and greatest' tools can be build even on 2.6.24 environment=
s where
there was no SocketCAN in mainline Linux.

And e.g. this

>  #include <linux/can.h>
> -#include <linux/can/isotp.h>
> +#include "isotp.h"
>  #include <linux/if_tun.h>

should be avoided too.

Please only fix the copyright information in this patch.

The wrong 3.1 -> 3.2 comparison should be fixed in a separate patch too=
=2E

But reorder the includes in a way you suggest needs at least some more
discussion (see requirements above).

Regards,
Oliver
