From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] can: mpc5xxx_can: fix section type conflict
Date: Thu, 4 Oct 2012 17:20:35 +0200
Message-ID: <20121004152035.GM598@pengutronix.de>
References: <1349361249-30888-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60577 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422809Ab2JDPUi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Oct 2012 11:20:38 -0400
Content-Disposition: inline
In-Reply-To: <1349361249-30888-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Arnd Bergmann <arnd@arndb.de>

Hello,

On Thu, Oct 04, 2012 at 04:34:09PM +0200, Marc Kleine-Budde wrote:
> Since commit:
>     6d99c4c can: mpc5xxx_can: make data used as *of_device_id.data co=
nst
>=20
> both "struct mpc5xxx_can_data mpc5200_can_data" and "mpc5121_can_data=
" are
> marked as "const" but also as "__devinitdata". This leads to the foll=
owing
> compile error:
>=20
> drivers/net/can/mscan/mpc5xxx_can.c:383: error: mpc5200_can_data caus=
es a section type conflict
> drivers/net/can/mscan/mpc5xxx_can.c:383: error: mpc5200_can_data caus=
es a section type conflict
> drivers/net/can/mscan/mpc5xxx_can.c:388: error: mpc5121_can_data caus=
es a section type conflict
> drivers/net/can/mscan/mpc5xxx_can.c:388: error: mpc5121_can_data caus=
es a section type conflict
>=20
> This patch changes the "__devinitdata" to "__devinitconst" and marks =
the
> "struct of_device_id mpc5xxx_can_table" as "const" and "__devinitcons=
t", too.
>=20
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
