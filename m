From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 2/2] can: flexcan: adding platform specific details for
 LS1021A
Date: Thu, 23 Nov 2017 13:33:34 +0100
Message-ID: <ca3f6c50-65b7-4c47-1564-99e4b6518cd9@pengutronix.de>
References: <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-2-git-send-email-pankaj.bansal@nxp.com>
 <f7413c59-978e-fad1-6df0-3226067e64fa@pengutronix.de>
 <AM0PR0402MB3940EB22177698DBA63A5F24F1210@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <9c8816e4-5888-0b10-34c4-0f9fddb4bd53@pengutronix.de>
 <AM0PR0402MB39403E7EFEB9547234E25289F1210@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tJCA2urBXRa2e9MoK1d8sx0lrLae8vvJm"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48507 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752819AbdKWMdp (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Thu, 23 Nov 2017 07:33:45 -0500
In-Reply-To: <AM0PR0402MB39403E7EFEB9547234E25289F1210@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>, Bhupesh Sharma <bhupesh.sharma@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tJCA2urBXRa2e9MoK1d8sx0lrLae8vvJm
Content-Type: multipart/mixed; boundary="qLPdd47bbbK5t1w3s7SLxSwDLPSXqHSjw";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Bansal <pankaj.bansal@nxp.com>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>
Message-ID: <ca3f6c50-65b7-4c47-1564-99e4b6518cd9@pengutronix.de>
Subject: Re: [PATCH v3 2/2] can: flexcan: adding platform specific details for
 LS1021A
References: <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-2-git-send-email-pankaj.bansal@nxp.com>
 <f7413c59-978e-fad1-6df0-3226067e64fa@pengutronix.de>
 <AM0PR0402MB3940EB22177698DBA63A5F24F1210@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <9c8816e4-5888-0b10-34c4-0f9fddb4bd53@pengutronix.de>
 <AM0PR0402MB39403E7EFEB9547234E25289F1210@AM0PR0402MB3940.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR0402MB39403E7EFEB9547234E25289F1210@AM0PR0402MB3940.eurprd04.prod.outlook.com>

--qLPdd47bbbK5t1w3s7SLxSwDLPSXqHSjw
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/23/2017 01:01 PM, Pankaj Bansal wrote:
>>> I got this version from Bill Of Material details of LS1021A SOC.
>>
>> Oh, nice. Do you have access to the vf610 list to get the IP core vers=
ion?
>=20
> I am sorry but I don't have access to vf610 list.

Ok.

>>> Actually in LS1021A Rev1 RX-FIFO mode is broken. Rev1 is initial
>>> release, and Rev2 Is final release. Which is why this comment.
>>
>> Ahh, can you please add this to the table above.
>=20
> I have already added LS1021A in table.

Yes, but not the information that the r1 has a broken FIFO.

>> You're not using the mailbox mode anymore, right?=20
>=20
> No, we are using timestamp based RX fifo.
>=20
>> This means the driver should work with the broken r1 silicon, too?
>=20
> I would think so. But as r1 is not officially supported version, I
> have not checked it.

Ok - I don't mind if nxp doesn't support it or not...

>> Are any of these silicons out in
>> the wild? Does it make sense to use "fsl,ls1021ar1-flexcan" for this
>> compatible?
>=20
> No. r1 silicon has not been delivered to any customer. We need not to s=
upport
> r1 silicon in compatible, as its not official supported version.

=2E..but if it's not out in the wild we don't have to add it. And wait
until someone complains :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qLPdd47bbbK5t1w3s7SLxSwDLPSXqHSjw--

--tJCA2urBXRa2e9MoK1d8sx0lrLae8vvJm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloWwB4ACgkQHv7KIOw4
HPb8uQgAgQB+FQLDae0cVVv4CwdESGNYv+BGNILOLZWujgvKepUUmhlCW1hopNbB
R2E6NbutkUB9OQtATtsBOYzAmu/VPj3kcIE4ByUGWPLj5Qdpj/6LSCDtfjrZGnoj
39vxJ8bV6r2Fd6aK3zZ/qhcUw/b1u6pBqjjSP12U0kiqKEnkpO9kS67adbQyhzTB
7ZZj10GpzqedGDz1N+YSPGGDmvezL63NVy6y9fqv8R60aujc+M98TTZNTxKin8d1
y+Y/ew1cfj6+bwDJ0PhOdYHB78mLKM9NYQDz9No/VnykdZGe5qYjDm30eBcduUhd
j6vx4xLeuGIOLQ15yTt4sricgstN2A==
=NMxO
-----END PGP SIGNATURE-----

--tJCA2urBXRa2e9MoK1d8sx0lrLae8vvJm--
