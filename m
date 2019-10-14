From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: m_can: add support for handling arbitration error
Date: Mon, 14 Oct 2019 14:31:06 +0200
Message-ID: <00c5c5b7-cc90-ff6c-0c49-77fe0481dac1@pengutronix.de>
References: <CGME20191014113437epcas5p2143d7e85d5a50dad79a4a60a9d666fe4@epcas5p2.samsung.com>
 <1571052844-22633-1-git-send-email-pankj.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AZDapMu3XUZs18i7kWADys9tvYVFwtV1H"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571052844-22633-1-git-send-email-pankj.sharma@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AZDapMu3XUZs18i7kWADys9tvYVFwtV1H
Content-Type: multipart/mixed; boundary="AXrGQ0y8FFCDvOvAN9gfJyQRz57GcXh13";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, eugen.hristev@microchip.com,
 ludovic.desroches@microchip.com, pankaj.dubey@samsung.com,
 rcsekar@samsung.com, Sriram Dash <sriram.dash@samsung.com>
Message-ID: <00c5c5b7-cc90-ff6c-0c49-77fe0481dac1@pengutronix.de>
Subject: Re: [PATCH] can: m_can: add support for handling arbitration error
References: <CGME20191014113437epcas5p2143d7e85d5a50dad79a4a60a9d666fe4@epcas5p2.samsung.com>
 <1571052844-22633-1-git-send-email-pankj.sharma@samsung.com>
In-Reply-To: <1571052844-22633-1-git-send-email-pankj.sharma@samsung.com>

--AXrGQ0y8FFCDvOvAN9gfJyQRz57GcXh13
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/14/19 1:34 PM, Pankaj Sharma wrote:
> The Bosch MCAN hardware (3.1.0 and above) supports interrupt flag to
> detect Protocol error in arbitration phase.
>=20
> Transmit error statistics is currently not updated from the MCAN driver=
=2E
> Protocol error in arbitration phase is a TX error and the network
> statistics should be updated accordingly.
>=20
> The member "tx_error" of "struct net_device_stats" should be incremente=
d
> as arbitration is a transmit protocol error. Also "arbitration_lost" of=

> "struct can_device_stats" should be incremented to report arbitration
> lost.
>=20
> Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
> ---
>  drivers/net/can/m_can/m_can.c | 38 +++++++++++++++++++++++++++++++++++=

>  1 file changed, 38 insertions(+)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> index b95b382eb308..7efafee0eec8 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -778,6 +778,39 @@ static inline bool is_lec_err(u32 psr)
>  	return psr && (psr !=3D LEC_UNUSED);
>  }
> =20
> +static inline bool is_protocol_err(u32 irqstatus)

please add the comon m_can_ prefix

> +{
> +	if (irqstatus & IR_ERR_LEC_31X)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static int m_can_handle_protocol_error(struct net_device *dev, u32 irq=
status)
> +{
> +	struct net_device_stats *stats =3D &dev->stats;
> +	struct m_can_priv *priv =3D netdev_priv(dev);
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	/* propagate the error condition to the CAN stack */
> +	skb =3D alloc_can_err_skb(dev, &cf);
> +	if (unlikely(!skb))
> +		return 0;

please handle the stats, even if the allocation of the skb fails.

> +
> +	if (priv->version >=3D 31 && (irqstatus & IR_PEA)) {
> +		netdev_dbg(dev, "Protocol error in Arbitration fail\n");
> +		stats->tx_errors++;
> +		priv->can.can_stats.arbitration_lost++;
> +		cf->can_id |=3D CAN_ERR_LOSTARB;
> +		cf->data[0] |=3D CAN_ERR_LOSTARB_UNSPEC;
> +	}
> +
> +	netif_receive_skb(skb);
> +
> +	return 1;
> +}
> +
>  static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstat=
us,
>  				   u32 psr)
>  {
> @@ -792,6 +825,11 @@ static int m_can_handle_bus_errors(struct net_devi=
ce *dev, u32 irqstatus,
>  	    is_lec_err(psr))
>  		work_done +=3D m_can_handle_lec_err(dev, psr & LEC_UNUSED);
> =20
> +	/* handle protocol errors in arbitration phase */
> +	if ((priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
> +	    is_protocol_err(irqstatus))
> +		work_done +=3D m_can_handle_protocol_error(dev, irqstatus);
> +
>  	/* other unproccessed error interrupts */
>  	m_can_handle_other_err(dev, irqstatus);
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AXrGQ0y8FFCDvOvAN9gfJyQRz57GcXh13--

--AZDapMu3XUZs18i7kWADys9tvYVFwtV1H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2kaooACgkQWsYho5Hk
nSBkdgf/YlCE6WuqAGgdMPE2FKZ3v/Imnkp1ZqqB6lB8rBcBf+5VW1lihEAArwTD
3XgmOp4AgjCtD2n0/yyDSIAoGcrP9c9rwjLCGhgG/auSjmRq1BZXOKEMybTNlAyt
iVo+/KLU7oRFyu61IMW9d+M8U7P7r9tEynm+je8t+cUJ25msu3c+SVTCPb6EgV0M
+nYXODX8R9ZVNImLGhhkNg9VQfrqzSlE0J8yCtv8UGPGHp1cjL+BXRpFiBHyrVC3
KF03IRhIwBBErZzoMus9/cCHfh6CPrD8FCGgAsCY2eGzgCn/FWkhjK0km9z2IFCs
dK/y4PeRR3jM5Pzv5sMzajuyOdCQ0Q==
=4ND9
-----END PGP SIGNATURE-----

--AZDapMu3XUZs18i7kWADys9tvYVFwtV1H--
