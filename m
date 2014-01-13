From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] slcand: reimplement daemonize routine
Date: Mon, 13 Jan 2014 10:58:25 +0100
Message-ID: <20140113095825.GD29475@pengutronix.de>
References: <1389603245-24023-1-git-send-email-yegorslists@googlemail.com>
 <1389603245-24023-2-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48656 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbaAMJ62 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 04:58:28 -0500
Content-Disposition: inline
In-Reply-To: <1389603245-24023-2-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org, socketcan@hartkopp.net, mkl@pengutronix.de

Hello Yegor,

On Mon, Jan 13, 2014 at 09:54:05AM +0100, yegorslists@googlemail.com wr=
ote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> Replace daemonize() routine with daemone() system call, because of
> conflicting licenses. daemonize() routine was derived from under
> GNU Free Documentation License licensed code. This license is
> incompatible with GPL-2+.
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
Thanks.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Uwe
