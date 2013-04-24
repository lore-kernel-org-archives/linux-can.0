From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Usb to can driver
Date: Wed, 24 Apr 2013 18:07:18 +0200
Message-ID: <51780336.5060800@pengutronix.de>
References: <1366737302.3325.36.camel@blackbox>  <51770161.2030005@pengutronix.de> <1366818490.5965.35.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2WWUBEXGWWROJINAISCNU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50277 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab3DXQHZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Apr 2013 12:07:25 -0400
In-Reply-To: <1366818490.5965.35.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2WWUBEXGWWROJINAISCNU
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/24/2013 05:48 PM, Max S. wrote:
>> Please use "./scripts/checkpatch.pl" from the kernel and fix all
>> coding style errors. Then repost :).

Please check your patch with ./scripts/checkpatch.pl, fix the errors,
then repost.

>> Can you explain how the "struct device_config" works.
>>
> struct __packed device_config {
> 	u16 byte_order;
>=20
> 	u32 hf_size;	/* size of a host frame */
> 	u32 hf_can_id;
> 	u32 hf_can_dlc;
> 	u32 hf_data;
> 	u32 hf_echo_id;
> 	u32 hf_channel;
> } conf;
>=20
> conf =3D (struct device_config){
> 	.byte_order =3D 0xbeef,
> 	.hf_size =3D sizeof(struct ss_host_frame),
> 	.hf_can_id =3D offsetof(struct ss_host_frame, frame.can_id),
> 	.hf_can_dlc =3D offsetof(struct ss_host_frame, frame.can_dlc),
> 	.hf_data =3D offsetof(struct ss_host_frame, frame.data),
> 	.hf_echo_id =3D offsetof(struct ss_host_frame, echo_id),
> 	.hf_channel =3D offsetof(struct ss_host_frame, channel),
> };
>=20
> ... send conf to device, packed that should be 26 bytes.
>=20
> The device uses byte_order which will appear as either 0xbeef or 0xefbe=

> to convert the other members to device byte order. (and to convert all
> future messages)

Use a u32 here instead of an u16, this way the struct is properly aligned=
=2E

> The device can then tell how the host prefers its can frames formatted.=

> The idea is that the struct device_config holds enough data to allow th=
e
> device to construct a struct ss_host_frame in host format, including
> padding & byte order.

Nice.

> since a struct ss_host_frame is simply a wrapper that includes a struct=

> can_frame, when a message arrives from the device, the host can copy th=
e
> struct can frame member without modification from the struct
> ss_host_frame into the skb.
>=20
> assumptions that are made:
> * The sizes of the struct can_frame members are id:u32 dlc:u8 data:u64 =
=2E
> * It is also assumed that existing defines like CAN_EFF_FLAG in can.h
> and can/error.h don't change, as they are used by the device to
> construct the can_id field.

You cannot rely in your firmware, that the struct can_frame and
CAN_*_FLAG doesn't change. Please define your own struct.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2WWUBEXGWWROJINAISCNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF4AzoACgkQjTAFq1RaXHOjLgCgh3dvvgyp50g+3ukT49gdJjIE
QxQAn35WBptOBCCgxvo+sGM98cmOSpUG
=uWcd
-----END PGP SIGNATURE-----

------enig2WWUBEXGWWROJINAISCNU--
