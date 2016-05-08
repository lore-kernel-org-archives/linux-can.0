From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: janz-ican3: error handling for CAL/CANopen firmware
Date: Sun, 8 May 2016 19:46:49 +0200
Message-ID: <572F7B89.8020503@pengutronix.de>
References: <572C5015.70601@gmail.com> <572F74D8.8080801@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0GO5dqv7enDMcD0kTiwCmulfwS72tG0NR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59245 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750913AbcEHRq4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 May 2016 13:46:56 -0400
In-Reply-To: <572F74D8.8080801@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andreas_Gr=c3=b6ger?= <andreas24groeger@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0GO5dqv7enDMcD0kTiwCmulfwS72tG0NR
Content-Type: multipart/mixed; boundary="uXhD6dHjHqRK0HIl0Gvb7GCaCV67WDFDc"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Andreas_Gr=c3=b6ger?= <andreas24groeger@gmail.com>,
 linux-can@vger.kernel.org
Message-ID: <572F7B89.8020503@pengutronix.de>
Subject: Re: [PATCH] can: janz-ican3: error handling for CAL/CANopen firmware
References: <572C5015.70601@gmail.com> <572F74D8.8080801@pengutronix.de>
In-Reply-To: <572F74D8.8080801@pengutronix.de>

--uXhD6dHjHqRK0HIl0Gvb7GCaCV67WDFDc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2016 07:18 PM, Marc Kleine-Budde wrote:
> On 05/06/2016 10:04 AM, Andreas Gr=C3=B6ger wrote:
>> Hi,
>>
>> my patch of May 2015 was missing the changed handling of error
>> indications. With CAL/CANopen firmware the NMTS-SlaveEventIndication
>> must be used instead of CAN-EventIndication. An appropriate slave node=

>> must be configured to report the errors.
>>
>> In our department (about 15 development systems with Janz ICAN3-
>> modules with firmware 1.48, my system also with firmware ICANOS 1.35)
>> we use the driver with this patch for about one year: no known problem=
s.
>>
>> Signed-off-by: Andreas Gr=C3=B6ger <andreas24groeger@gmail.com>
>=20
> [...]
>=20
>> +/* Handle NMTS Slave Event Indication Messages from the firmware */
>> +static void ican3_handle_nmtsind(struct ican3_dev *mod, struct ican3_=
msg *msg)
>> +{
>> +	u16 subspec;
>> +
>> +	subspec =3D msg->data[0] + msg->data[1] * 0x100;
>> +	if (subspec =3D=3D NMTS_SLAVE_EVENT_IND) {
>> +		switch (msg->data[2]) {
>> +		case NE_LOCAL_OCCURRED:
>> +		case NE_LOCAL_RESOLVED:
>> +			/* now follows the same message as Raw ICANOS CEVTIND
>> +			 * shift the data at the same place and call this method
>> +			 */
>> +			msg->len -=3D 3;
>=20
>> drivers/net/can/janz-ican3.c:1214:34: warning: bad assignment (-=3D) t=
o restricted __le16
>> drivers/net/can/janz-ican3.c:1215:62: warning: incorrect type in argum=
ent 3 (different base types)
>> drivers/net/can/janz-ican3.c:1215:62:    expected unsigned int [unsign=
ed] [usertype] <noident>
>> drivers/net/can/janz-ican3.c:1215:62:    got restricted __le16 [userty=
pe] len
>=20
> msg->len is marked as __le16, so you're not allowed to work on it direc=
tly.

I've added some endianness handling:

> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.=
c
> index a75e66e6a5bf..f13bb8d9bb84 100644
> --- a/drivers/net/can/janz-ican3.c
> +++ b/drivers/net/can/janz-ican3.c
> @@ -1211,8 +1211,8 @@ static void ican3_handle_nmtsind(struct ican3_dev=
 *mod, struct ican3_msg *msg)
>                         /* now follows the same message as Raw ICANOS C=
EVTIND
>                          * shift the data at the same place and call th=
is method
>                          */
> -                       msg->len -=3D 3;
> -                       memmove(msg->data, msg->data + 3, msg->len);
> +                       le16_add_cpu(&msg->len, -3);
> +                       memmove(msg->data, msg->data + 3, le16_to_cpu(m=
sg->len));
>                         ican3_handle_cevtind(mod, msg);
>                         break;
>                 case NE_REMOTE_OCCURRED:

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uXhD6dHjHqRK0HIl0Gvb7GCaCV67WDFDc--

--0GO5dqv7enDMcD0kTiwCmulfwS72tG0NR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXL3uJAAoJED07qiWsqSVqehEIAKDL2jjNANNr2AARbLPlYmAp
K1SVxWGz7TseaCTA8UZHzFKKxEbmsiW/++FqbETb10+dhspsJr2DzQdFQb5SafYJ
o8AeGh4nEFmysEES2VD6ai6YXMkAlO5BEibIoXvR5uGibHu4BVSxEcIlceeKAeD+
iEXHIDP8pdfRxQ3bAeNjnL4ARNHx56OG810lLwQu1jQrCPktAcA/qKfSdc4cFkMs
5PLAaoZ5U9rV/vJTDD4jQMu+z7wltM9cshJo+e51o5OAvaceVxZD0OnE3y+RRfUI
IPyJ6mKVonOqPevbR0JqMCMHCMvG/6O1Wr9XVftCK7pW9okuJI1ThZayonhUhbc=
=Lcne
-----END PGP SIGNATURE-----

--0GO5dqv7enDMcD0kTiwCmulfwS72tG0NR--
