From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils v4 4/4] isotp.h: add explicit license information
Date: Tue, 14 Jan 2014 16:49:15 +0100
Message-ID: <52D55C7B.4010102@hartkopp.net>
References: <52D45B4C.3070009@hartkopp.net> <1389650236-13542-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389650236-13542-5-git-send-email-u.kleine-koenig@pengutronix.de> <52D4E0CD.2040706@hartkopp.net> <20140114084616.GR29475@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:54615 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbaANPtV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Jan 2014 10:49:21 -0500
In-Reply-To: <20140114084616.GR29475@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

On 14.01.2014 09:46, Uwe Kleine-K=F6nig wrote:

>> Is this the only file in include/socketcan now?
>> I thought you wanted to get rid of this construct and move everythin=
g over to
>> the include/linux directory to finally remove include/socketecan ??
> You said:
> 	Please let it stay in the current place.
>=20
> So did I. :-)

Sigh. You are kidding me.

Please make your choice:

[ ] Please let it stay in the current place with all the other includes
[ ] Do not put it to a different place away from the other includes

We obviously need to work on our communication :-(

As you moved *all* the includes to a new place I was not able to imagin=
e that
you would even think about leaving *only* isotp.h in include/socketcan.

Regards,
Oliver

