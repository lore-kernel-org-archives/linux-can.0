From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Thu, 19 Jan 2017 15:02:39 +0100
Message-ID: <0fdfb4b5-eb75-3b20-4ff3-bbe356946748@pengutronix.de>
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <f87c4e7d-4e8a-6d0d-9063-86ce9d7347bb@pengutronix.de>
 <e41b06fc-7ef9-48c0-7f9c-8fdc483f134c@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2VePFVXaxRHjSAq6OVAHGRM5Muall31Xe"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39289 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752769AbdASOTI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2017 09:19:08 -0500
In-Reply-To: <e41b06fc-7ef9-48c0-7f9c-8fdc483f134c@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2VePFVXaxRHjSAq6OVAHGRM5Muall31Xe
Content-Type: multipart/mixed; boundary="Ec6KqaPmEVQKCbjntrkBVaQWturvOcsRd";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <0fdfb4b5-eb75-3b20-4ff3-bbe356946748@pengutronix.de>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <f87c4e7d-4e8a-6d0d-9063-86ce9d7347bb@pengutronix.de>
 <e41b06fc-7ef9-48c0-7f9c-8fdc483f134c@peak-system.com>
In-Reply-To: <e41b06fc-7ef9-48c0-7f9c-8fdc483f134c@peak-system.com>

--Ec6KqaPmEVQKCbjntrkBVaQWturvOcsRd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 02:03 PM, Stephane Grosjean wrote:
> Hello Marc,
>=20
> Building my code onto a 32-bits machine:
>=20
> Le 13/01/2017 =C3=A0 12:38, Marc Kleine-Budde a =C3=A9crit :
>> On 01/11/2017 01:16 PM, Stephane Grosjean wrote:
>>>   - every "#ifdef CONFIG_xxx" has been changed into "IS_ENABLED(CONFI=
G_xxx)"
>>>
>=20
> This change leads to the following code, as you suggested:
>=20
>                  lk->laddr_lo =3D cpu_to_le32(page->lbase);
>=20
>                  if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
>                          lk->laddr_hi =3D cpu_to_le32(page->lbase >> 32=
);
>                  else
>                          lk->laddr_hi =3D 0;
>=20
> *WITH*
>=20
> struct pciefd_page {
>          dma_addr_t lbase;               /* page logical address */
> };
>=20
> *BUT* building this code when CONFIG_ARCH_DMA_ADDR_T_64BIT is not=20
> defined (neither Y nor M), that is, on a 32-bits machine I suppose,=20
> generates the following warning:
>=20
> drivers/net/can/peak_canfd/peak_pciefd_main.c:532:43: warning: right=20
> shift count >=3D width of type [-Wshift-count-overflow]
>      lk->laddr_hi =3D cpu_to_le32(page->lbase >> 32);
>=20
> which is obviously true, since "dma_addr_t" is here a 32-bits width typ=
e.
>=20
> So, in that case, I don't see any other way to fix, than using the (old=
)=20
> #ifdef CONFIG_xxx style, present in v2.

Ok, then make it an ifdef again.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Ec6KqaPmEVQKCbjntrkBVaQWturvOcsRd--

--2VePFVXaxRHjSAq6OVAHGRM5Muall31Xe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAliAxv8ACgkQPTuqJayp
JWrL9Af/QQhq1dSdyOx/N02K9xfuy98k/Fa1Mkp+dfAFTz+9qFwc5srePNGduYL3
5Y648Cnzk574Kua3YvoAw3+OKLRQfnF6DQV5mgXxyenZhnc3u5MUPHd6derxzbya
oimQmfDofFyHZwdCtN7vRTYDpfJu9ewEqrZi+1gU3JmOfksNmxWZF3i/DQRNgHcv
ensPVB8mT3gws2fOEXurR8CJDvagofw0mpkBTgEefzckfq5aifGLj91yWU7LFGKw
SBqlNCkTgpallZn4K5xitid68aAptgCoq++EvuIaM/7i1sunxc9CfrWUn/zyNp8V
+ydWccke9d/yGG5Gr6sconW9DhBsTw==
=RB9M
-----END PGP SIGNATURE-----

--2VePFVXaxRHjSAq6OVAHGRM5Muall31Xe--
