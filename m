From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Query on possible bug in the can_create_echo_skb() API
Date: Wed, 28 Aug 2019 14:15:51 +0200
Message-ID: <3a8c557f-adb5-144d-00f1-1b1c608129dc@pengutronix.de>
References: <BYAPR02MB5464DC9DA2D38AF1100A5A8FAFAA0@BYAPR02MB5464.namprd02.prod.outlook.com>
 <6bd3a657-dd8a-03a5-1e7c-bac532008f6e@pengutronix.de>
 <BYAPR02MB546403642B2233DDD5C456C4AFA30@BYAPR02MB5464.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QzR5jW2iDxMph4DR1wPP7iACWG1J582gw"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <BYAPR02MB546403642B2233DDD5C456C4AFA30@BYAPR02MB5464.namprd02.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Srinivas Neeli <sneeli@xilinx.com>, "wg@grandegger.com" <wg@grandegger.com>
Cc: Srinivas Goud <sgoud@xilinx.com>, Naga Sureshkumar Relli <nagasure@xilinx.com>, Appana Durga Kedareswara Rao <appanad@xilinx.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QzR5jW2iDxMph4DR1wPP7iACWG1J582gw
Content-Type: multipart/mixed; boundary="RY22PpBUTD32uM4bOZ1jQik2RlJaeGTmM";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Srinivas Neeli <sneeli@xilinx.com>, "wg@grandegger.com"
 <wg@grandegger.com>
Cc: Srinivas Goud <sgoud@xilinx.com>,
 Naga Sureshkumar Relli <nagasure@xilinx.com>,
 Appana Durga Kedareswara Rao <appanad@xilinx.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <3a8c557f-adb5-144d-00f1-1b1c608129dc@pengutronix.de>
Subject: Re: Query on possible bug in the can_create_echo_skb() API
References: <BYAPR02MB5464DC9DA2D38AF1100A5A8FAFAA0@BYAPR02MB5464.namprd02.prod.outlook.com>
 <6bd3a657-dd8a-03a5-1e7c-bac532008f6e@pengutronix.de>
 <BYAPR02MB546403642B2233DDD5C456C4AFA30@BYAPR02MB5464.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB546403642B2233DDD5C456C4AFA30@BYAPR02MB5464.namprd02.prod.outlook.com>

--RY22PpBUTD32uM4bOZ1jQik2RlJaeGTmM
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/28/19 1:02 PM, Srinivas Neeli wrote:
> Case 1:
> can_put_echo_skb(); -> skb =3D can_create_echo_skb(skb); -> return skb;=

>=20
> In can_create_echo_skb() not using the shared_skb, so we are returning =
the old skb.
> Storing the return value in "skb". But it's a pointer, for storing that=
 need double pointer.
> Instead of double-pointer using a single pointer. In this scenario it's=
 ok , we are returning the same SKB.
>=20
> Case 2:
> can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max); -> skb =3D c=
an_create_echo_skb(skb); -> can_skb_set_owner(nskb, skb->sk); - Returning=
 nskb;
>=20
> shared_skb scenario:
> In share-skb case =E2=80=9Ccan_create_echo_skb(skb);=E2=80=9D  returnin=
g "new skb". For storing new skb need a double pointer.
>=20
> Providing an example for overcoming above issue.
> Example:
> can_put_echo_skb(struct sk_buff **skb,struct net_device *dev,unsigned i=
nt idx);

Now I get what you mean.

> If you ok with this change, I will send a patch.

I think the can_put_echo_skb() API needs clarification. The driver is
not allowed to touch the skb any more after can_put_echo_skb(). We
should review the driver for this.

thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--RY22PpBUTD32uM4bOZ1jQik2RlJaeGTmM--

--QzR5jW2iDxMph4DR1wPP7iACWG1J582gw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1mcHcACgkQWsYho5Hk
nSDbCQgAkgVDQuau0Tdv3KonyWFkxvE8+XYywNNobRqUHPZTnqk5slSgz+HGIxz/
ae3FKsVcjvC5CRQ+2LI23eg7yTNlZ7EUHfh5Rn7Og+FviIz/NplxQkfR3vf0SS6Y
fzbUzsdU+3ORgHcVnP2Zxm6pJSkTV8ro6IXia+mefgn3lk/0rXYA/A4Igeot6hFK
MSmdEDb4uXUyF+UeMTj8NKDtCXuuUcazb9I84y4nR03dVXrEqXlRCT4A6ofXnLzi
l34pEQLRvE1Uu07b8194IDKOX8HtE7HckSMWtJkO1DUkhMmXWcDUd+GBjTH1Idrh
s3bV8sq6bEdlE4sSpAciqtGGNVIKiQ==
=bKs1
-----END PGP SIGNATURE-----

--QzR5jW2iDxMph4DR1wPP7iACWG1J582gw--
