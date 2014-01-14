From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils v4 4/4] isotp.h: add explicit license information
Date: Tue, 14 Jan 2014 08:01:33 +0100
Message-ID: <52D4E0CD.2040706@hartkopp.net>
References: <52D45B4C.3070009@hartkopp.net> <1389650236-13542-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389650236-13542-5-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:31799 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbaANHBf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Jan 2014 02:01:35 -0500
In-Reply-To: <1389650236-13542-5-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Hi Uwe,

On 13.01.2014 22:57, Uwe Kleine-K=F6nig wrote:
> It seems this file was originally part of the Linux kernel as it was =
created
> by commit 77de10356fe0 (include: import kernel header files into tree=
) but I
> couldn't find it in the git history of the kernel.

This comes from the original development process in the BerliOS SVN.
The fact that these files are kernel header files does not necessarily =
mean
they have been imported from the kernel source tree :-)

> Anyhow the copyright
> suggests to use the license used by the other files created by Volksw=
agen.

Indeed.

>=20
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/socketcan/can/isotp.h | 36 +++++++++++++++++++++++++++++++++=
---
>  1 file changed, 33 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/socketcan/can/isotp.h b/include/socketcan/can/is=
otp.h

Is this the only file in include/socketcan now?
I thought you wanted to get rid of this construct and move everything o=
ver to
the include/linux directory to finally remove include/socketecan ??

Regards,
Oliver
