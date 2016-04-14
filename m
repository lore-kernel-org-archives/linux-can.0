From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: bit-timing and sample point
Date: Thu, 14 Apr 2016 16:06:22 +0200
Message-ID: <570FA3DE.9030001@pengutronix.de>
References: <570E205B.7030900@pengutronix.de>
 <20160414102608.GC16018@airbook.vandijck-laurijssen.be>
 <570F7547.8030805@pengutronix.de>
 <20160414121932.GA7409@airbook.vandijck-laurijssen.be>
 <570F8DCA.4090701@pengutronix.de>
 <KL1PR06MB10312DC099D9EE3A19B6B872C3970@KL1PR06MB1031.apcprd06.prod.outlook.com>
 <570F93B2.1010804@pengutronix.de>
 <KL1PR06MB1031E7E5F2414AF6C81030A4C3970@KL1PR06MB1031.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="c6nk3nHwStk3KTNKHmaJNKWp52orUXNNq"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35738 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754446AbcDNOGe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Apr 2016 10:06:34 -0400
In-Reply-To: <KL1PR06MB1031E7E5F2414AF6C81030A4C3970@KL1PR06MB1031.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c6nk3nHwStk3KTNKHmaJNKWp52orUXNNq
Content-Type: multipart/mixed; boundary="qQ1VS3QulkAvpw0sv5eU9QMNQejtHsd81"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <570FA3DE.9030001@pengutronix.de>
Subject: Re: bit-timing and sample point
References: <570E205B.7030900@pengutronix.de>
 <20160414102608.GC16018@airbook.vandijck-laurijssen.be>
 <570F7547.8030805@pengutronix.de>
 <20160414121932.GA7409@airbook.vandijck-laurijssen.be>
 <570F8DCA.4090701@pengutronix.de>
 <KL1PR06MB10312DC099D9EE3A19B6B872C3970@KL1PR06MB1031.apcprd06.prod.outlook.com>
 <570F93B2.1010804@pengutronix.de>
 <KL1PR06MB1031E7E5F2414AF6C81030A4C3970@KL1PR06MB1031.apcprd06.prod.outlook.com>
In-Reply-To: <KL1PR06MB1031E7E5F2414AF6C81030A4C3970@KL1PR06MB1031.apcprd06.prod.outlook.com>

--qQ1VS3QulkAvpw0sv5eU9QMNQejtHsd81
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/14/2016 03:05 PM, Ramesh Shanmugasundaram wrote:
>> Are there any common dbitrates? The array if common bitrates is:
>=20
> Not sure. I read in one of the NXP white paper 2 & 5Mbps are common
> data bitrates. I have tested 2Mbps only (transceiver capability). May
> be we can start with 2, 5 & 8Mbps. The tool already allows to print
> values for a specific bitrate. So we are covered.

12 MBit/s seems to be the max.

> static unsigned int common_data_bitrates[] =3D {
> 	12000000,
> 	10000000,
> 	8000000,
> 	5000000,
> 	4000000,
> 	2000000,
> 	1000000,
> };

Can you give the the typical refclocks for the rcar canfd?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qQ1VS3QulkAvpw0sv5eU9QMNQejtHsd81--

--c6nk3nHwStk3KTNKHmaJNKWp52orUXNNq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXD6PeAAoJED07qiWsqSVq8AkH/3DQcS0IklnOpkD/KrLEFUsl
fLmGdlCW7bdLM4qStvxuhSwrD32Aee58Qfalp9PN25dQCwQm47Ha4DRktgjU1IHf
XsCI2jxGAeIrCRJfZjoUQ6xePL9TXQZV3S7WhGVvcJLRe0F/YfVSlG9EstLn9JrT
08SSrgzf1UbhdBXSoZj6v7kJPI+Eeh8HKQ006dOpC1zLxJjGklXe4/yH+C8QHVWR
3YjmUw/Sa4UHDCUxrbTbIjdF1WGhWzHsDhlwIrhaFSczSFS+sf3I/MsVxfVjE06Q
lBGUFPB/cPSqS5gPDKmWQxInYnWK4lYChwzND5Ox1KWQ6oi86dsKHiB7wc8AeFo=
=0DiE
-----END PGP SIGNATURE-----

--c6nk3nHwStk3KTNKHmaJNKWp52orUXNNq--
