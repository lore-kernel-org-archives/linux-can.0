From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: ems_usb: endianess warning
Date: Wed, 25 Mar 2015 09:44:22 +0100
Message-ID: <55127566.8050504@pengutronix.de>
References: <55044620.60903@pengutronix.de> <5511A6B5.2010507@ems-wuensche.com> <55127313.6090500@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rn7OA2xvwNSUugSE8BTRcfoJlahwO7KvH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59141 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbCYIo2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Mar 2015 04:44:28 -0400
In-Reply-To: <55127313.6090500@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Sebastian Haas <haas@ems-wuensche.com>, Sebastian Haas <dev@sebastianhaas.info>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rn7OA2xvwNSUugSE8BTRcfoJlahwO7KvH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/25/2015 09:34 AM, Marc Kleine-Budde wrote:
> On 03/24/2015 07:02 PM, Gerhard Uttenthaler wrote:
>> this took some time, sorry.
>=20
> Thanks, applied to can.

I missed the fact, that the ID is correct in the driver without the
patch, sparse just missed that. So this goes into can-next.

In the driver there's timestamp, which endianess is corret here?

> /* Main message type used between library and application */
> struct __packed ems_cpc_msg {
> 	u8 type;	/* type of message */
> 	u8 length;	/* length of data within union 'msg' */
> 	u8 msgid;	/* confirmation handle */
> 	u32 ts_sec;	/* timestamp in seconds */
> 	u32 ts_nsec;	/* timestamp in nano seconds */
        ^^^^^^^^^^^
>=20
> 	union {
> 		u8 generic[64];
> 		struct cpc_can_msg can_msg;
> 		struct cpc_can_params can_params;
> 		struct cpc_confirm confirmation;
> 		struct cpc_overrun overrun;
> 		struct cpc_can_error error;
> 		struct cpc_can_err_counter err_counter;
> 		u8 can_state;
> 	} msg;
> };

I know, the timestamp is not used in the driver, for now.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rn7OA2xvwNSUugSE8BTRcfoJlahwO7KvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVEnVqAAoJECte4hHFiupUqP0P/3nwifxfIqsYzb2CSlEbqIkI
6FfdK1J1w9L5a3AjjqfYTEIP2GoDyRjcMXTRXx6UskQjdRCNAYEbK5GQ4T+Cthzw
5G43G7H/kdbN6Tyg/w1vt0I72Y9t7GwZnJmKekMIQwvUMZMS+mGDM5IsaKlpgCb9
zFBimbE2tilsTHs/O/F9NlpxeucY3w6nHwwdvHXBWNoIb6WHU2C1W2w9RBOibGRD
pGg8YqeKQVekOHoYwDG1jnFsZQ9VZJs7PkhDPNbV2qctszDr6XTaHyv8uIVhnSjy
aG9chTORUsEgWiMfK+uppKtcSMlGTf7Rpp+H3Hczgm+JWWHbsWrCaogk/rJd6tD4
vP1JESewCVkY5rwR5K7Uzdp+hAlc6fFo4Jn5qWeEnhpWa6Zhm0g7MZGfVub5kIyA
oe754xuM2C6vF5FGr0VkYezs48UEQdVZhynd9JKdqMtlYKMNv9cALChebfwWD66i
e1y7pKHmXVgyFHAKBFZoc6Yqer8/HtZHwZtHArDPdPMEqGYh9HI7x0aDOlLm3gFV
9u+S+W9ZWODFfFtLrhZyaWL+qWBCKOMhO9Fa0wGzg1RmTVg82ZYOY9D39df3VNGr
mHWMfDbnSaVum4WT/f5P/ELtaM3suw1MSOpT+75hOMB4aNCNKSiXE13iH6fC3+62
aY6L4D4htB/3gVvWxlQg
=TkAP
-----END PGP SIGNATURE-----

--rn7OA2xvwNSUugSE8BTRcfoJlahwO7KvH--
