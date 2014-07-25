From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/5] net: can: flexcan: disable error interrupts in non
 ERR-Active state
Date: Sat, 26 Jul 2014 00:17:00 +0200
Message-ID: <53D2D75C.2040607@pengutronix.de>
References: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de> <1406312202-2542-2-git-send-email-matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VLX3fOR1hkSsPVlHa05DmOB1pX5GXp4pX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60949 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbaGYWRJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 18:17:09 -0400
In-Reply-To: <1406312202-2542-2-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>, wg@grandegger.com, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VLX3fOR1hkSsPVlHa05DmOB1pX5GXp4pX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2014 08:16 PM, Matthias Klein wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> On imx53 I receive continuously STF_ERR error interrupts after sending =
a
> CAN frame on an open BUS.
> This patch disables error interrupts once we leave the ERR-Active state=

> since I doubt further error interrupts are of any interest especially i=
f
> they render the system unresponsible.

For some use cases and users this is important. However I think we all
don't want to have an unresponsive system. Have a look the "can:
berr_limit support" series [1], which introduces a configurable time-out
before the error interrupts are re-enabled.

[1] http://comments.gmane.org/gmane.linux.can/4070

The series needs some polishing and there are some open questions to
address.

Marc

> According to the manual in this case the system remains in passive stat=
e
> and RX-err counter is >127 and won't increment any further and so it
> won't enter BUS-Off state. Once the system receives a CAN message, the
> RX-error counter should by set to 119 =E2=80=A6 127 which brings the CA=
N module
> back to ERR-active state which then should activate error reporting
> again.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
> ---
>  drivers/net/can/flexcan.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index f677b49..2b98da2 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -628,7 +628,17 @@ static int flexcan_poll(struct napi_struct *napi, =
int quota)
>  		napi_complete(napi);
>  		/* enable IRQs */
>  		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
> -		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
> +		/*
> +		 * On an open CAN-bus the iMX51 keeps reporting the STF_ERR
> +		 * event after an attempt to send a CAN message. This will
> +		 * disable further error reports (or that one that keeps
> +		 * nagging) once we leave the ERR-Active state.
> +		 */
> +		if (reg_esr & FLEXCAN_ESR_FLT_CONF_MASK)
> +			flexcan_write(priv->reg_ctrl_default &
> +					~FLEXCAN_CTRL_ERR_MSK, &regs->ctrl);
> +		else
> +			flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
>  	}
> =20
>  	return work_done;
> @@ -656,8 +666,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  	 * - bus error IRQ and bus error reporting is activated
>  	 */
>  	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
> -	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> -	    flexcan_has_and_handle_berr(priv, reg_esr)) {
> +	    (reg_esr & FLEXCAN_ESR_ERR_ALL)) {
> +
>  		/*
>  		 * The error bits are cleared on read,
>  		 * save them for later use.
>=20

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VLX3fOR1hkSsPVlHa05DmOB1pX5GXp4pX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPS11wACgkQjTAFq1RaXHPdyACgk8r/cx61PPgL0QJArS+QNpeh
LHkAn3MocAroepAprMRDhqv7o7ZVOvu8
=dgXg
-----END PGP SIGNATURE-----

--VLX3fOR1hkSsPVlHa05DmOB1pX5GXp4pX--
