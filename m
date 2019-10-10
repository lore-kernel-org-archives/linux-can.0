From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 24/29] can: ti_hecc: add fifo underflow error reporting
Date: Thu, 10 Oct 2019 17:52:15 +0200
Message-ID: <dfdbefb3-48c4-0830-9627-146da062a01a@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
 <20191010121750.27237-25-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PuZm4VCQiooSzQjeQd9ZclikGRIXl4Xzt"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191010121750.27237-25-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>, jhofstee@victronenergy.com, kernel@pengutronix.de, davem@davemloft.net
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PuZm4VCQiooSzQjeQd9ZclikGRIXl4Xzt
Content-Type: multipart/mixed; boundary="xhk6VFvhkEkazo2IJ4w3oJBiKfHLH2mX7";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
 =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
 jhofstee@victronenergy.com, kernel@pengutronix.de, davem@davemloft.net
Message-ID: <dfdbefb3-48c4-0830-9627-146da062a01a@pengutronix.de>
Subject: Re: [PATCH 24/29] can: ti_hecc: add fifo underflow error reporting
References: <20191010121750.27237-1-mkl@pengutronix.de>
 <20191010121750.27237-25-mkl@pengutronix.de>
In-Reply-To: <20191010121750.27237-25-mkl@pengutronix.de>

--xhk6VFvhkEkazo2IJ4w3oJBiKfHLH2mX7
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 10/10/19 2:17 PM, Marc Kleine-Budde wrote:
> From: Jeroen Hofstee <jhofstee@victronenergy.com>
>=20
> When the rx fifo overflows the ti_hecc would silently drop them since
> the overwrite protection is enabled for all mailboxes. So disable it
> for the lowest priority mailbox and increment the rx_fifo_errors when
> receive message lost is set. Drop the message itself in that case,
> since it might be partially updated.

Is that your observation or does the data sheet say anything to this
situation?

>=20
> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/ti_hecc.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
> index 6ea29126c60b..c2d83ada203a 100644
> --- a/drivers/net/can/ti_hecc.c
> +++ b/drivers/net/can/ti_hecc.c
> @@ -82,7 +82,7 @@ MODULE_VERSION(HECC_MODULE_VERSION);
>  #define HECC_CANTA		0x10	/* Transmission acknowledge */
>  #define HECC_CANAA		0x14	/* Abort acknowledge */
>  #define HECC_CANRMP		0x18	/* Receive message pending */
> -#define HECC_CANRML		0x1C	/* Remote message lost */
> +#define HECC_CANRML		0x1C	/* Receive message lost */
>  #define HECC_CANRFP		0x20	/* Remote frame pending */
>  #define HECC_CANGAM		0x24	/* SECC only:Global acceptance mask */
>  #define HECC_CANMC		0x28	/* Master control */
> @@ -385,8 +385,17 @@ static void ti_hecc_start(struct net_device *ndev)=

>  	/* Enable tx interrupts */
>  	hecc_set_bit(priv, HECC_CANMIM, BIT(HECC_MAX_TX_MBOX) - 1);
> =20
> -	/* Prevent message over-write & Enable interrupts */
> -	hecc_write(priv, HECC_CANOPC, HECC_SET_REG);
> +	/* Prevent message over-write to create a rx fifo, but not for
> +	 * the lowest priority mailbox, since that allows detecting
> +	 * overflows instead of the hardware silently dropping the
> +	 * messages. The lowest rx mailbox is one above the tx ones,
> +	 * hence its mbxno is the number of tx mailboxes.
> +	 */
> +	mbxno =3D HECC_MAX_TX_MBOX;
> +	mbx_mask =3D ~BIT(mbxno);
> +	hecc_write(priv, HECC_CANOPC, mbx_mask);
> +
> +	/* Enable interrupts */
>  	if (priv->use_hecc1int) {
>  		hecc_write(priv, HECC_CANMIL, HECC_SET_REG);
>  		hecc_write(priv, HECC_CANGIM, HECC_CANGIM_DEF_MASK |
> @@ -531,6 +540,7 @@ static unsigned int ti_hecc_mailbox_read(struct can=
_rx_offload *offload,
>  {
>  	struct ti_hecc_priv *priv =3D rx_offload_to_priv(offload);
>  	u32 data, mbx_mask;
> +	int lost;
> =20
>  	mbx_mask =3D BIT(mbxno);
>  	data =3D hecc_read_mbx(priv, mbxno, HECC_CANMID);
> @@ -552,9 +562,12 @@ static unsigned int ti_hecc_mailbox_read(struct ca=
n_rx_offload *offload,
>  	}
> =20
>  	*timestamp =3D hecc_read_stamp(priv, mbxno);
> +	lost =3D hecc_read(priv, HECC_CANRML) & mbx_mask;
> +	if (unlikely(lost))
> +		priv->offload.dev->stats.rx_fifo_errors++;

In the flexcan and at91_can driver we're incrementing the following error=
s:
			dev->stats.rx_over_errors++;
			dev->stats.rx_errors++;

You can save the register access if you only check for overflows if
reading from the lowest prio mailbox.

If you're discarding the data if the mailbox is marked as overflow
there's no need to read the data in the first place.

>  	hecc_write(priv, HECC_CANRMP, mbx_mask);
> =20
> -	return 1;
> +	return !lost;
>  }
> =20
>  static int ti_hecc_error(struct net_device *ndev, int int_status,
>=20

I'll send a v2 that addresses these findings.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xhk6VFvhkEkazo2IJ4w3oJBiKfHLH2mX7--

--PuZm4VCQiooSzQjeQd9ZclikGRIXl4Xzt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2fU68ACgkQWsYho5Hk
nSA5SQf9HlJfbDEIUFCh1DSdIQi1gpHDT06ox9newEDnSmivCgtNuiLB7Z2WEWmd
gNqR6EgU8uW2wccchEJvjELgoFq5uJdquT0zCtRwu3jCxPGZhpAhi0vj7ClM9K/f
9Cx0rgstnY59iePQMAIe8A2I5Yur8u3ZDIGGS3NWp4iJop78qpbx80/YIfii7JCl
WR2LmzcD1Jx3pwQMVN6FhdHyf3RjHw+Vfza8pX8VS25ubrUnynVQTh/HbGNlGlK1
BzTP2YlaElDzXFGI+8Tnsw91b+F8j2OmbTel2yKT45o8cTd4k5g8obc1Oh77OBC8
85ZRYf8vwVERCnE59VuyRAym62+h9g==
=bgHo
-----END PGP SIGNATURE-----

--PuZm4VCQiooSzQjeQd9ZclikGRIXl4Xzt--
