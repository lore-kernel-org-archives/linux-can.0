From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v7 09/10] include: gw.h: update comment
Date: Tue, 21 Jan 2014 15:41:08 +0100
Message-ID: <52DE8704.1060606@hartkopp.net>
References: <1390309204-19854-1-git-send-email-mkl@pengutronix.de> <1390309204-19854-10-git-send-email-mkl@pengutronix.de> <20140121132419.GD26766@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:53851 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274AbaAUOlL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 09:41:11 -0500
In-Reply-To: <20140121132419.GD26766@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org



On 21.01.2014 14:24, Uwe Kleine-K=F6nig wrote:
> On Tue, Jan 21, 2014 at 02:00:03PM +0100, Marc Kleine-Budde wrote:
>> This comment was added to the kernel in patch:
>>
>>     391ac12 can: gw: add a per rule limitation of frame hops
> The corresponding can-utils commit is:
>=20
> 	ad7f44095ac3 (cangw: add an option for the per rule limitation of fr=
ame hops)
>=20
> which somehow introduced the difference even though it referenced com=
mit
> 391ac12.
>=20

Ugh.

I obviously did this small change before posting the upstream patch.
Now it get's back to the correct kernel header source.

Tnx.
Oliver

