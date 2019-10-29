From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: m_can: add support for handling arbitration error
Date: Tue, 29 Oct 2019 15:23:23 +0100
Message-ID: <89d7b65f-e8cf-9241-5642-ab3446b464a5@pengutronix.de>
References: <CGME20191021121350epcas5p3313e54a3bc5c8600c52a6db299893f78@epcas5p3.samsung.com>
 <1571660016-29726-1-git-send-email-pankj.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zKAH9Bt7ESKpPezSdIMhMv91NesmJDxix"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571660016-29726-1-git-send-email-pankj.sharma@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, jhofstee@victronenergy.com, simon.horman@netronome.com, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zKAH9Bt7ESKpPezSdIMhMv91NesmJDxix
Content-Type: multipart/mixed; boundary="ySD0BfKPg5SRKL4VN8Tlf1EQpvjsLNXPJ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, davem@davemloft.net, eugen.hristev@microchip.com,
 ludovic.desroches@microchip.com, pankaj.dubey@samsung.com,
 rcsekar@samsung.com, jhofstee@victronenergy.com, simon.horman@netronome.com,
 Sriram Dash <sriram.dash@samsung.com>
Message-ID: <89d7b65f-e8cf-9241-5642-ab3446b464a5@pengutronix.de>
Subject: Re: [PATCH v2] can: m_can: add support for handling arbitration error
References: <CGME20191021121350epcas5p3313e54a3bc5c8600c52a6db299893f78@epcas5p3.samsung.com>
 <1571660016-29726-1-git-send-email-pankj.sharma@samsung.com>
In-Reply-To: <1571660016-29726-1-git-send-email-pankj.sharma@samsung.com>

--ySD0BfKPg5SRKL4VN8Tlf1EQpvjsLNXPJ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/21/19 2:13 PM, Pankaj Sharma wrote:
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
>=20
> changes in v2:
> - common m_can_ prefix for is_protocol_err function
> - handling stats even if the allocation of the skb fails
> - resolving build errors on net-next branch
>=20
>  drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++=

>  1 file changed, 37 insertions(+)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> index 75e7490c4299..a736297a875f 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -778,6 +778,38 @@ static inline bool is_lec_err(u32 psr)
>  	return psr && (psr !=3D LEC_UNUSED);
>  }
> =20
> +static inline bool m_can_is_protocol_err(u32 irqstatus)
> +{
> +	return irqstatus & IR_ERR_LEC_31X;
> +}
> +
> +static int m_can_handle_protocol_error(struct net_device *dev, u32 irq=
status)
> +{
> +	struct net_device_stats *stats =3D &dev->stats;
> +	struct m_can_classdev *cdev =3D netdev_priv(dev);
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	/* propagate the error condition to the CAN stack */
> +	skb =3D alloc_can_err_skb(dev, &cf);
> +	if (unlikely(!skb)) {
> +		netdev_dbg(dev, "allocation of skb failed\n");
> +		stats->tx_errors++;
> +		return 0;
> +	}
> +	if (cdev->version >=3D 31 && (irqstatus & IR_PEA)) {
> +		netdev_dbg(dev, "Protocol error in Arbitration fail\n");
> +		stats->tx_errors++;
> +		cdev->can.can_stats.arbitration_lost++;

If the skb allocation fails, you miss the stats here.

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
> @@ -792,6 +824,11 @@ static int m_can_handle_bus_errors(struct net_devi=
ce *dev, u32 irqstatus,
>  	    is_lec_err(psr))
>  		work_done +=3D m_can_handle_lec_err(dev, psr & LEC_UNUSED);
> =20
> +	/* handle protocol errors in arbitration phase */
> +	if ((cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
> +	    m_can_is_protocol_err(irqstatus))
> +		work_done +=3D m_can_handle_protocol_error(dev, irqstatus);
> +
>  	/* other unproccessed error interrupts */
>  	m_can_handle_other_err(dev, irqstatus);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ySD0BfKPg5SRKL4VN8Tlf1EQpvjsLNXPJ--

--zKAH9Bt7ESKpPezSdIMhMv91NesmJDxix
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl24S1sACgkQWsYho5Hk
nSBxaQf/QbKoRpvQL7F9q6IM1QBB2RhscfBtL7nFuhRb53zfiBuFvxBX479ff+Go
c7svlK0T/Rb+7GJtLLJUqbasa6uKlz3fUmcTRWGqlLx65mB0Ki9GfxMbx0AMwZl3
toxUCBLbu689XAnKyj6QksTv8Nn8kF15huy2xUQUWF6DvIBpXZQP/1mJz/NBwfu/
D+B4lJivf2V3hyiJfDt3kwUy/meUFl6eO7uV6Zlf/9/vZPyRYLD8aAiCf32NgvyC
HG5a4GyLWOzqYcKjMj19Lw98JA5RijrdfQltwRi2EX+/U0wbnBzRKWciAcKSYoJ8
Sc1ZoLo9eJ/KhnH4rv5tvTtu87f4hQ==
=YTQ/
-----END PGP SIGNATURE-----

--zKAH9Bt7ESKpPezSdIMhMv91NesmJDxix--
