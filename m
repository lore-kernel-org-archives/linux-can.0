From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: AW: [PATCH v3 1/1] can: Add support for esd CAN PCIe/402 card
Date: Wed, 05 Nov 2014 11:11:01 +0100
Message-ID: <5459F7B5.7080002@pengutronix.de>
References: <1415080039-38327-1-git-send-email-thomas.koerper@esd.eu> <5458D372.3020604@hartkopp.net> <5458D403.9040803@pengutronix.de> <8CE1D0B9BFD2404DA079DDE1814A6F2E02BB65D1BB24@esd-s3.esd.local> <5459EA11.4060600@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rwhnBdgjQUUqgShcbUvctfpQKhS99SNWH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43788 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000AbaKEKLJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Nov 2014 05:11:09 -0500
In-Reply-To: <5459EA11.4060600@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, =?UTF-8?B?VGhvbWFzIEvDtnJwZQ==?= =?UTF-8?B?cg==?= <Thomas.Koerper@esd.eu>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rwhnBdgjQUUqgShcbUvctfpQKhS99SNWH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/05/2014 10:12 AM, Oliver Hartkopp wrote:
> On 05.11.2014 05:21, Thomas K=C3=B6rper wrote:
>=20
>> already was afraid the module param should be removed :)
>> May I print all these infos unconditionally?  ...If someone has
>> trouble with the card we really like to see that stuff first.
>=20
> Oh. It's no problem to print hardware specific information at startup.
> But this is IMO only too much because of it's formatting
>=20
> +	if (dump_infos) {
> +		dev_info(dev, "  Probe register: 0x%.8x\n",
> +			 acc_ov_read32(ov, ACC_OV_OF_PROBE));
> +		dev_info(dev, "  Features: 0x%.4x\n", ov->features);
> +		dev_info(dev, "  FPGA Version: 0x%.4x\n",
> +			 ov->version);
> +		dev_info(dev, "  Strappings: 0x%.4x\n",
> +			 acc_ov_read32(ov, ACC_OV_OF_INFO) >> 16);
> +		dev_info(dev, "  Active cores: %u\n",
> +			 ov->active_cores);
> +		dev_info(dev, "  Total cores: %u\n",
> +			 ov->total_cores);
> +		dev_info(dev, "  Core frequency: %u\n",
> +			 ov->core_frequency);
> +		dev_info(dev, "  Timestamp frequency: %u\n",
> +			 ov->timestamp_frequency);
> +	}
>=20
> What about putting these information in just one or two lines, e.g.
>=20
> esdacc: FPGA rev x.xx @ 3000Hz (TS @ 400Hz), probe reg x.xx, feat. x.xx=
, X of Y cores active=20

One line would be fine.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rwhnBdgjQUUqgShcbUvctfpQKhS99SNWH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWfe1AAoJECte4hHFiupU8/oQAJqMDeAAE9VxHJPopORfkM6C
WFYwIn87S8oZRnqWgGuXhYbto/einOaIC35PAc9LjMFYsqmfWW+SExq3A4dSAl3E
jZ826TOHI3LdmDo8r+RlkO8dCBZGahNdQ/ZcN0VDdz+bpmIUq+NzgAi4mBex/a3v
IhQHL6v2hnEbrizfbnygYZwZ//5aGVnSssj6BvV2JlD5U+Ln8j1C0jhiEixuwx2Y
twFHmQ3SH6EIUTKAMTm8kPMtwwW29flw0UqJSEwyT2kdkFC+CGHKnNUEBV+ExuwL
co7flf7m6Jsycmqt9WRjsqUDdShupVCatbf4VzQE2K4+ZG0/xHjrnapw2HTmcdYm
V8cqFS893F+Qv7kpEKlyl/DD3R8g+0MvQ8Vw9m+KzBkL8RxEE5FI79PcXHyB2zbk
RmJRJZUlaEx17nHHf/fFxAGAe7TUE2cEjj+6xcNu0uPpKMjKBG2rzkgoyJ3B7eD6
tsQY+zdiRWYogEJz14+OfOXK4hYf6Y7/Brl/y6yev+ttx9isuso2GLMhV+SRcZ2j
RnU7zs89Kri3AOe35YPkCFKoxVV+qB09qgmD53AcGgVg61KHvfa2Rkae618Myu6n
peX0/tdQM4657NSULd3tf0Bh46Rcp4qdPPkpj4u8yushlI2dRGNX7XHEywSQ347H
htS4yA8uoPlwva/2GTGQ
=Z6YF
-----END PGP SIGNATURE-----

--rwhnBdgjQUUqgShcbUvctfpQKhS99SNWH--
