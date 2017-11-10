From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: flexcan: Remodel FlexCAN register r/w APIs for
 big endian FlexCAN controllers.
Date: Fri, 10 Nov 2017 12:09:10 +0100
Message-ID: <e87441cc-3848-1125-f4f0-02f1a630c36b@pengutronix.de>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <a08c34d0-5870-b4b3-f68d-3db33ba3e950@pengutronix.de>
 <AM0PR0402MB3940A39D32C4725DE1B8C426F1540@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="66wbt33U2RhWK5tesG6tVt0fEg6uauPFQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54261 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752405AbdKJLJU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Nov 2017 06:09:20 -0500
In-Reply-To: <AM0PR0402MB3940A39D32C4725DE1B8C426F1540@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Sakar Arora <Sakar.Arora@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--66wbt33U2RhWK5tesG6tVt0fEg6uauPFQ
Content-Type: multipart/mixed; boundary="BPWddx9j3b7q9G8pkCa2as3DfpgELiR8d";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Bansal <pankaj.bansal@nxp.com>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Sakar Arora <Sakar.Arora@freescale.com>
Message-ID: <e87441cc-3848-1125-f4f0-02f1a630c36b@pengutronix.de>
Subject: Re: [PATCH 1/2] can: flexcan: Remodel FlexCAN register r/w APIs for
 big endian FlexCAN controllers.
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <a08c34d0-5870-b4b3-f68d-3db33ba3e950@pengutronix.de>
 <AM0PR0402MB3940A39D32C4725DE1B8C426F1540@AM0PR0402MB3940.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR0402MB3940A39D32C4725DE1B8C426F1540@AM0PR0402MB3940.eurprd04.prod.outlook.com>

--BPWddx9j3b7q9G8pkCa2as3DfpgELiR8d
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 12:06 PM, Pankaj Bansal wrote:
> Hi Marc,
>=20
> Thank you for reviewing my changes.
>=20
> 2. Some of the original team members that had contributed to these chan=
ges have left the organization. Please suggest on how to give them credit=
 in these patches?

Hmm, ok. Do they have a new email address?

> 3. Regarding backward compatibility with PowerPC, I see that there is o=
nly one platform in PowerPC architecture that is using flexcan.
>     There is only one platform in "arch/powerpc/boot/dts/" having flexc=
an node. p1010si-post.dtsi
>     I have added the big-endian property in that platform and have test=
ed it on P1010 platform after backporting the patch to Freescale SDK 1.4 =
linux.
>     I have sent the patch for this. See "[PATCH 2/3] powerpc: dts: P101=
0: Add endianness property to flexcan node"
>     I believe these changes can be accepted for both powerpc and arm an=
d other architectures that use flexcan.

No, this is not acceptable. You break the device tree. Please add the
le, be information to the devtype data.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--BPWddx9j3b7q9G8pkCa2as3DfpgELiR8d--

--66wbt33U2RhWK5tesG6tVt0fEg6uauPFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloFiNYACgkQHv7KIOw4
HPYSkgf/YBeTn4yRngldXrwGg459DQbV576B8a1g5AiDdcPA9sovhH0AU/0+RrKP
RrKApvwX3siTwdfWPjvS47MHyPpGuJnAy3/bb48YX4X2PXEHeUJjiiKEsAjEViqS
/RIPTHuyFBqopFSPUK7kWMdzXgVDqVMQiC+hm/ryVvVfiRMmrmDj3bNsfgRhom+7
wShfsZSu7WeglXW9b+aJFtIzU16eLRYLPZ8SzhxeumYg26tCHt9euztdsMyT3L8l
0S/jaPF7FqZHULaSIvLgMZBIuCqJiZY8ukCglR9rnpbIjh4PPhfwJAetqQccjXGP
YhT5LWK85h956nuqiZex97skZaBt5A==
=GTHF
-----END PGP SIGNATURE-----

--66wbt33U2RhWK5tesG6tVt0fEg6uauPFQ--
