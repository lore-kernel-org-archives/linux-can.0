From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix bus-off error state handling.
Date: Fri, 20 Mar 2015 10:11:59 +0100
Message-ID: <550BE45F.8040100@pengutronix.de>
References: <40e1c77d-546d-48b6-b4bd-fe76f7692e90@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LklksKKo9NXuFhrrifBnCFAHWwaCqxxXw"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59406 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbbCTJMa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Mar 2015 05:12:30 -0400
In-Reply-To: <40e1c77d-546d-48b6-b4bd-fe76f7692e90@GRBSR0089.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LklksKKo9NXuFhrrifBnCFAHWwaCqxxXw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/17/2015 02:03 PM, Andri Yngvason wrote:
> Making sure that the bus-off state gets passed to can_change_state().
>=20
> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>

Applied to can with a minor change.

> ---
>  drivers/net/can/flexcan.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 80c46ad..ee944ae 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -592,13 +592,12 @@ static int flexcan_poll_state(struct net_device *=
dev, u32 reg_esr)
>  		rx_state =3D unlikely(reg_esr & FLEXCAN_ESR_RX_WRN) ?
>  			   CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
>  		new_state =3D max(tx_state, rx_state);
> -	} else if (unlikely(flt =3D=3D FLEXCAN_ESR_FLT_CONF_PASSIVE)) {
> +	} else {
>  		__flexcan_get_berr_counter(dev, &bec);
> -		new_state =3D CAN_STATE_ERROR_PASSIVE;
> +		new_state =3D flt =3D=3D FLEXCAN_ESR_FLT_CONF_PASSIVE ?
> +			    CAN_STATE_ERROR_PASSIVE : CAN_STATE_BUS_OFF;

converted this into a if...else

>  		rx_state =3D bec.rxerr >=3D bec.txerr ? new_state : 0;
>  		tx_state =3D bec.rxerr <=3D bec.txerr ? new_state : 0;
> -	} else {
> -		new_state =3D CAN_STATE_BUS_OFF;
>  	}
> =20
>  	/* state hasn't changed */
>=20

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--LklksKKo9NXuFhrrifBnCFAHWwaCqxxXw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVC+RfAAoJECte4hHFiupUspoQAIZs7Nq4D4xugfQbRc65J6Re
t1XoTR+XCpa+hAjm7qYxcWNLCqO+MDspcbbyWMvtCZ2xX7u+63hgHpwYK2WgkbDh
JYduRyWNrbqBh4yKXgsTc3xf4vYJIhQZFUGTX3Mmz6/bKKkcMLv0gPzZwVfzy1Hp
uvkiXHjM8PVaUtkFmJhaz0EU2sRuJbXGlxGcQ6MduS0+x5wwP9+QUHXiwb7vB0lj
CPt+c8BFqaAiOxyIw+rPLcu0e4peM/pbBFyHeLEBbnwVwIVFMwc6BmFlmG14K3KL
xCMREnQlfSBufFghisJltyZgSRhaY0ePopWSSufv52wdVSduNMNQWw4H/fGzRdGP
8zcaLYXXB0MKklTTAxc02HFapKltZ4gkfIEByKeihvlGcUYalVi1sGMFbgUNo4oW
bhtLUrcvd7AVBV80aW5UAPWPyM8ggOnQ+4LWb4urRP+BqaZzvZOsYJVKLRNJmjFT
p0PapK/Zae1KNgi1wY+iS9AzaJ/GQuuHcyVGGzVaiWSjoVBCAOFe1k0lcoYYQGJv
RKyw/abuJWPeMTeNbfJyIfErKe9E87Dwav3WQ+a1dxyP9/Mvh2funhlsy+J3v4ms
xwZNWhKDUMLnJ71zVmxhNR7LOldpLMGwGtvQSPEPTlfIQ0wzbxsvnfUDMzKYh7k8
8BoUsjK839fMLMNCWAJU
=TN2n
-----END PGP SIGNATURE-----

--LklksKKo9NXuFhrrifBnCFAHWwaCqxxXw--
