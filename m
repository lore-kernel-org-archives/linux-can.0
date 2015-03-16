From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 1/2] can: kvaser_usb: Comply with firmware max
 tx URBs value
Date: Mon, 16 Mar 2015 13:56:39 +0100
Message-ID: <5506D307.7030703@pengutronix.de>
References: <20150226152011.GA6075@linux> <20150315150338.GA4492@linux> <5505CA97.6020503@pengutronix.de> <20150316121636.GA14280@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="JdxreEjaR9FkHd5nuwWRQA3V41ki2xi0T"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150316121636.GA14280@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JdxreEjaR9FkHd5nuwWRQA3V41ki2xi0T
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2015 01:16 PM, Ahmed S. Darwish wrote:
>>> -	netdev_dbg(netdev, "device registered\n");
>>> +	netdev_info(netdev, "device registered\n");
>>
>> This makes the driver more noisy, I'd like to drop that hunk, okay? No=

>> need to resend.

> Sure, go ahead.

Thanks.

> I have my reasons for that hunk above, but we can always discuss
> this in another separate patch ;-)

Don't try to sneak in unrelated changes :) I'd like to have the drivers
more quiet these days, even when doing ifup, ifdown.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--JdxreEjaR9FkHd5nuwWRQA3V41ki2xi0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVBtMKAAoJECte4hHFiupUg+sP/jpxhqMFLE6t4gL2eWmALfAF
uOGTLt7rLGSDRh/1HjOE1jQmo9EwbD/hvL/gbPRVxupudZFxff7OhvzLAiWkKwmm
kRQRM0K7PtE+mtcArT5Hh/rOCzqaKRTWhrbLmOi8rJZJyQOQ2qi8aLd7znRbjCYs
HDOy2dR0UIDu2PRGvc/DS5anltaNjYjt00EbGGqDkWfwmD9mYy3xoh0hcJY4HyDI
e5Y8z5OaNy3eEC2jBTe43Zx67ASCxos7BWzQA1ubhhUbz7VR+BzSQpWFoBpcdf3G
p5w/1Vr48CieOWvLQlpviwA0YktWWC41VxTOhOuqxa1A5yERaILreR8kwk8d5HX0
IRU8K3FdFOWJyT2hJim9beIte2KAvRFFOUr8nMhjeYPzI9CCY3HlB+/eiYRJTPse
tzV34APBLe1WdeeiwzN4Lw3nnmfGiHQWLLNLsDv0730m2OM/pzeUPU75g7BSeMII
CubjfWy5SyCWIh9q0o8LE0E2fPz2he9Nzdq8AMory0IvnZPjz2GtbLMP3lWpDloT
bgdkUHKRI7DxCxmpW8Qa0q17n9yg3gB4plrSrV3RPd8ctoOZX/IUz0sii0sgnBWt
xdqf8AqkIaI6K++6HhJ/gWmgywM8QpBDptr61tdCwP0cPZv2wrQpPVbWpH4rnqzY
JTQm1v6I2wr2l2beXaPj
=5xmP
-----END PGP SIGNATURE-----

--JdxreEjaR9FkHd5nuwWRQA3V41ki2xi0T--
