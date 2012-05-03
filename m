From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] CAN FD support
Date: Thu, 03 May 2012 15:44:10 +0200
Message-ID: <4FA28BAA.3000109@pengutronix.de>
References: <4FA2689D.5030905@hartkopp.net> <4FA26D28.80307@grandegger.com> <4FA26F65.5020804@hartkopp.net> <4FA275C1.4080905@grandegger.com> <20120503121833.GC416@vandijck-laurijssen.be> <4FA27C3C.8010806@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE037C581B5FFB92101224996"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37132 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148Ab2ECNoN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 09:44:13 -0400
In-Reply-To: <4FA27C3C.8010806@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE037C581B5FFB92101224996
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/03/2012 02:38 PM, Oliver Hartkopp wrote:
[...]

>> I share this.
>> I'd even prefer u16 over u8 even.
>> No legacy issues exist when changing the meaning of can_dlc, since cur=
rent
>> CAN frames have equal values for DLC & length!
>>
>>> the struct is also used by the app.
>=20
>=20
> Yes - that's the main problem IMO.
>=20
> What about this binary compatible introduction of cf->len ...

=2E..but it's not 100% source compatible, due to a compiler bug in gcc.
You cannot use C99 initializers on anonymous unions in certain gcc versio=
ns.

[..]

> --- a/include/linux/can.h
> +++ b/include/linux/can.h
> @@ -57,7 +57,10 @@ typedef __u32 can_err_mask_t;
>   */
>  struct can_frame {
>  	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> -	__u8    can_dlc; /* data length code: 0 .. 8 */
> +	union {
> +		__u8    can_dlc; /* data length code: 0 .. 8 */
> +		__u8    len; /* data length: 0 .. 8 */
> +	};
>  	__u8    data[8] __attribute__((aligned(8)));
>  };

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE037C581B5FFB92101224996
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+ii6oACgkQjTAFq1RaXHNBmQCaA/sADKBHZQO4ucffmt2jWf4u
pMgAnjdK/yfL2QLATENbe4+YeGHAGQJ6
=XtaD
-----END PGP SIGNATURE-----

--------------enigE037C581B5FFB92101224996--
