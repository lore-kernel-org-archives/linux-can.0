From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: janz-ican3: error handling for CAL/CANopen firmware
Date: Sun, 8 May 2016 19:18:16 +0200
Message-ID: <572F74D8.8080801@pengutronix.de>
References: <572C5015.70601@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8r80lBxNfThIlgPsrCG6hhwrMMF5Jp98G"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57217 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750861AbcEHRSY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 May 2016 13:18:24 -0400
In-Reply-To: <572C5015.70601@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andreas_Gr=c3=b6ger?= <andreas24groeger@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8r80lBxNfThIlgPsrCG6hhwrMMF5Jp98G
Content-Type: multipart/mixed; boundary="WRNpFbnUUiJ6UnRfLjQx2lROIMSO9vnJk"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Andreas_Gr=c3=b6ger?= <andreas24groeger@gmail.com>,
 linux-can@vger.kernel.org
Message-ID: <572F74D8.8080801@pengutronix.de>
Subject: Re: [PATCH] can: janz-ican3: error handling for CAL/CANopen firmware
References: <572C5015.70601@gmail.com>
In-Reply-To: <572C5015.70601@gmail.com>

--WRNpFbnUUiJ6UnRfLjQx2lROIMSO9vnJk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/06/2016 10:04 AM, Andreas Gr=C3=B6ger wrote:
> Hi,
>=20
> my patch of May 2015 was missing the changed handling of error
> indications. With CAL/CANopen firmware the NMTS-SlaveEventIndication
> must be used instead of CAN-EventIndication. An appropriate slave node
> must be configured to report the errors.
>=20
> In our department (about 15 development systems with Janz ICAN3-
> modules with firmware 1.48, my system also with firmware ICANOS 1.35)
> we use the driver with this patch for about one year: no known problems=
=2E
>=20
> Signed-off-by: Andreas Gr=C3=B6ger <andreas24groeger@gmail.com>

[...]

> +/* Handle NMTS Slave Event Indication Messages from the firmware */
> +static void ican3_handle_nmtsind(struct ican3_dev *mod, struct ican3_m=
sg *msg)
> +{
> +	u16 subspec;
> +
> +	subspec =3D msg->data[0] + msg->data[1] * 0x100;
> +	if (subspec =3D=3D NMTS_SLAVE_EVENT_IND) {
> +		switch (msg->data[2]) {
> +		case NE_LOCAL_OCCURRED:
> +		case NE_LOCAL_RESOLVED:
> +			/* now follows the same message as Raw ICANOS CEVTIND
> +			 * shift the data at the same place and call this method
> +			 */
> +			msg->len -=3D 3;

> drivers/net/can/janz-ican3.c:1214:34: warning: bad assignment (-=3D) to=
 restricted __le16
> drivers/net/can/janz-ican3.c:1215:62: warning: incorrect type in argume=
nt 3 (different base types)
> drivers/net/can/janz-ican3.c:1215:62:    expected unsigned int [unsigne=
d] [usertype] <noident>
> drivers/net/can/janz-ican3.c:1215:62:    got restricted __le16 [usertyp=
e] len

msg->len is marked as __le16, so you're not allowed to work on it directl=
y.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WRNpFbnUUiJ6UnRfLjQx2lROIMSO9vnJk--

--8r80lBxNfThIlgPsrCG6hhwrMMF5Jp98G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXL3TYAAoJED07qiWsqSVqH6IIAK36BK/wnwdPmeVw2WhXt9ib
/IISxqwkxxt52XUkK4I5NzKKZ3AI3JPJqiNi2EY602UtjE2nMWDVCBzBuSfKmqHq
XqUtbAQrupsy6NehFh+rVesU4osBtR4+fWclluBPjS098IbRLvvgJFR1R3xtEQSa
f6YTu+ZFbK5g8BsBDFrZQ6zWkBFSFsjvcvIQ5gVjUxAV2+oOBWGZkoHiSeKqvmmL
62LRNzDhf0cEeCOfYYYOT6Je1Zi59lP+9Ev72qrrL39Pwk6qFCPt4QtIFWTm9rqL
n5wx/naJxtdpMhDFrYJnGSg23cnj/eY7pdz4TBHPV9xnVNfCGYhMMlkPlTfoNlk=
=rfF2
-----END PGP SIGNATURE-----

--8r80lBxNfThIlgPsrCG6hhwrMMF5Jp98G--
