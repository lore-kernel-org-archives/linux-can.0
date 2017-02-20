From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: ti_hecc: canfdtest rx freeze
Date: Mon, 20 Feb 2017 10:21:05 +0100
Message-ID: <f5b83085-8b2a-c6c0-34b6-dbfabc6b9a9a@pengutronix.de>
References: <CAGm1_kux90=SkCquSB3Rdh0rJdQA1DPgt42849sw-pvnNWBAXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lBBnLdEmI5SRxJuul3Kov29gqfSroQrCK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56107 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751147AbdBTJV5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2017 04:21:57 -0500
In-Reply-To: <CAGm1_kux90=SkCquSB3Rdh0rJdQA1DPgt42849sw-pvnNWBAXA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "Grim, Dennis" <Dennis.Grim@teejet.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lBBnLdEmI5SRxJuul3Kov29gqfSroQrCK
Content-Type: multipart/mixed; boundary="U7NclVaWU1FbrIa9awdhhaWKhBnPVxova";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Yegor Yefremov <yegorslists@googlemail.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 "Grim, Dennis" <Dennis.Grim@teejet.com>
Message-ID: <f5b83085-8b2a-c6c0-34b6-dbfabc6b9a9a@pengutronix.de>
Subject: Re: ti_hecc: canfdtest rx freeze
References: <CAGm1_kux90=SkCquSB3Rdh0rJdQA1DPgt42849sw-pvnNWBAXA@mail.gmail.com>
In-Reply-To: <CAGm1_kux90=SkCquSB3Rdh0rJdQA1DPgt42849sw-pvnNWBAXA@mail.gmail.com>

--U7NclVaWU1FbrIa9awdhhaWKhBnPVxova
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/20/2017 10:08 AM, Yegor Yefremov wrote:
> I have a trouble with ti_hecc driver. When doing tx I have no
> problems, but rx path freezes after about 18 frames.
>=20
> The problem is that in ti_hecc_rx_poll() the while loop will be left
> when we flip the mailboxes:
>=20
>                 } else if (priv->rx_next =3D=3D HECC_MAX_TX_MBOX - 1) {=

>                         priv->rx_next =3D HECC_RX_FIRST_MBOX;
>                         break;
>                 }
>=20
> but, if there are still unhandled packets we leave the routine without
> enabling RX mailbox interrupts. So if we don't receive any other
> interrupts CAN interface "freezes". So removing break fixes this
> issue.
>=20
> But when running canfdtest -vv can0 for example against PEAK's USB-CAN
> ti_hecc stops to receive frames after about 1 minute. Invoking "ip
> link set can0 down" freezes the system.
>=20
> I've applied Wolfgang's patch from 12.12.2016 with multiple spin_lock
> fixes, but it didn't improve the situation.
>=20
> Any idea?

Does the ti_hecc core have a RX timestamp per mailbox? Then you can make
use of the rx_offload helper.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--U7NclVaWU1FbrIa9awdhhaWKhBnPVxova--

--lBBnLdEmI5SRxJuul3Kov29gqfSroQrCK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAliqtQMACgkQHv7KIOw4
HPbRGggAyH6FDmMlk9f5tTrjH4Hq+2jM5SaKJCJ2QhmWRJK7JCmX4kG1uchAceRx
mFUAk7lXPb8vkXgvwUcRM8bFYiGLjNUG4sX0N3biJly+M8xzlt1jNSQqK+beziSg
EXY1ikOnO0bL54dHvK9DqZ+YoqwZx6WYMMl9d6AIYmRNnAcDjkpC3DIAwwaxM4OD
BZ9N0l7uq7ZnWxM9I+aAeSOdRdMQOw+y9QiONoe0J3/ULtv6MPxBBbjjys88ab0V
o6TdInl6AlpXhhh/pn9fjXT3ChUEmrricekeMvn40sXl+mRn/LaB8y/Ig29aKC28
kqo7N8DMR6kwUHY6pCU5Kmb0+EWROQ==
=wEL7
-----END PGP SIGNATURE-----

--lBBnLdEmI5SRxJuul3Kov29gqfSroQrCK--
