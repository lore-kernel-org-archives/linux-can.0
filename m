From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] can: flexcan: make flexcan_priv.devtype_data member
 point to const data
Date: Mon, 16 Jul 2012 11:50:48 +0200
Message-ID: <20120716095048.GT592@pengutronix.de>
References: <1342184664-10720-1-git-send-email-mkl@pengutronix.de>
 <1342184664-10720-2-git-send-email-mkl@pengutronix.de>
 <20120716082139.GS592@pengutronix.de>
 <5003D0A8.7000908@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46771 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab2GPJu4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Jul 2012 05:50:56 -0400
Content-Disposition: inline
In-Reply-To: <5003D0A8.7000908@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de

On Mon, Jul 16, 2012 at 10:28:24AM +0200, Marc Kleine-Budde wrote:
> On 07/16/2012 10:21 AM, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Fri, Jul 13, 2012 at 03:04:23PM +0200, Marc Kleine-Budde wrote:
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >> ---
> >>  drivers/net/can/flexcan.c |    4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> >> index 81324a1..1b6f562 100644
> >> --- a/drivers/net/can/flexcan.c
> >> +++ b/drivers/net/can/flexcan.c
> >> @@ -192,7 +192,7 @@ struct flexcan_priv {
> >> =20
> >>  	struct clk *clk;
> >>  	struct flexcan_platform_data *pdata;
> >> -	struct flexcan_devtype_data *devtype_data;
> >> +	const struct flexcan_devtype_data *devtype_data;
> >>  };
> >> =20
> >>  static struct flexcan_devtype_data fsl_p1010_devtype_data =3D {
> >> @@ -960,7 +960,7 @@ static const struct platform_device_id flexcan=
_id_table[] =3D {
> >>  static int __devinit flexcan_probe(struct platform_device *pdev)
> >>  {
> >>  	const struct of_device_id *of_id;
> >> -	struct flexcan_devtype_data *devtype_data;
> >> +	const struct flexcan_devtype_data *devtype_data;
> >>  	struct net_device *dev;
> >>  	struct flexcan_priv *priv;
> >>  	struct resource *mem;
> > Maybe this can be squashed into
> >=20
> > 	30c1e67 (can: flexcan: add hardware controller version support)
> >=20
> > (currently in next) together with making fsl_p1010_devtype_data and
> > fsl_imx6q_devtype_data const?
>=20
> Squashing is not possible, because it's already in David's tree. If I
ok.

> mark fsl_p1010_devtype_data and fsl_imx6q_devtype_data as const, I ge=
t
> these errors:
>=20
> drivers/net/can/flexcan.c:950: warning: initialization discards
> qualifiers from pointer target type
> drivers/net/can/flexcan.c:951: warning: initialization discards
> qualifiers from pointer target type
>=20
> In a tree without you proposed patch.
ah, right. My tree is based on v3.5-rc which doesn't have 30c1e67 yet,
so I make a mental note to add the consts when both patches hit
mainline.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
