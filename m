From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/6] phy: Add max_bitrate attribute &
 phy_get_max_bitrate()
Date: Mon, 5 Nov 2018 10:37:56 +0100
Message-ID: <0c0885c4-f5ae-a29c-7176-f67fe546cfd8@pengutronix.de>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
 <20181102192616.28291-2-faiz_abbas@ti.com>
 <5e1a0b67-510a-5512-d477-0b363e4733fe@pengutronix.de>
 <d75c9e3c-e12b-e0b8-832c-ad117dcbe990@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6AARXZWAuJ8EhVUM6hntMrHvTaIVOZrPu"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d75c9e3c-e12b-e0b8-832c-ad117dcbe990@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6AARXZWAuJ8EhVUM6hntMrHvTaIVOZrPu
Content-Type: multipart/mixed; boundary="a6ssr4tU7M1AjNaXKpOf9FyUhJjakeWFP";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com
Message-ID: <0c0885c4-f5ae-a29c-7176-f67fe546cfd8@pengutronix.de>
Subject: Re: [PATCH 1/6] phy: Add max_bitrate attribute &
 phy_get_max_bitrate()
References: <20181102192616.28291-1-faiz_abbas@ti.com>
 <20181102192616.28291-2-faiz_abbas@ti.com>
 <5e1a0b67-510a-5512-d477-0b363e4733fe@pengutronix.de>
 <d75c9e3c-e12b-e0b8-832c-ad117dcbe990@ti.com>
In-Reply-To: <d75c9e3c-e12b-e0b8-832c-ad117dcbe990@ti.com>

--a6ssr4tU7M1AjNaXKpOf9FyUhJjakeWFP
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/05/2018 07:27 AM, Faiz Abbas wrote:
> I remove the transceiver child node binding documentation in patch 5/6.=

>=20
> The existing implementation is pretty limiting as it just has a child
> node with no associated device. What if a transceiver requires its own
> configurations before it can start sending/receiving messages (for
> example, my usecase requires it to pull the standby line low)?
>=20
> I think that can be solved by implementing the transceiver as a phy and=

> exposing a generic get_max_bitrate API. That way, the transceiver devic=
e
> can do all its startup configuration in the phy probe function.
>=20
> In any case, do suggest if you have a better idea on how to implement
> pull gpio low requirement.

As long as we don't have any proper transceiver/phy driver, that does
more than swtich on/off a GPIO, please add a "xceiver" regulator to your
driver. Look for:

> devm_regulator_get(&pdev->dev, "xceiver");

in the flexcan driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--a6ssr4tU7M1AjNaXKpOf9FyUhJjakeWFP--

--6AARXZWAuJ8EhVUM6hntMrHvTaIVOZrPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlvgD3QACgkQk9IU1zQo
ZfFSzwf+ORdSazr3ZdB5Ij/Ju2/oA2lKRHQoR/eKydjg7k/xtO4pHcV/91BB3OAf
iJLYQ06kq5uO98L9qnzcArdEi6xG7JEH4sSQwBMdIksMEw29nsXhPgmB/oXoLQr9
/x/U8gbQSjw6MmY0EOLD1qG7lVM6vFPTbo12VpcPQ3rkvoi4PGxG9Ef92lMe+GvX
VT3vEWXHgub0B6kirdKVuJzta+p8HmK9qPz8FRBfttq7umIr99jFDiQvf1FoixAP
okGrmB+0IiousOMtPKAhI4O/YRizXaeWgJzp5ZAqM7R2/2THLRFy3qyt3CLPdGag
jPtqKS8D2rvQ4NUCzcm7idxIjKThnQ==
=tWLD
-----END PGP SIGNATURE-----

--6AARXZWAuJ8EhVUM6hntMrHvTaIVOZrPu--
