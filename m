From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: ti_hecc: canfdtest rx freeze
Date: Mon, 20 Feb 2017 11:28:02 +0100
Message-ID: <bb8046f4-efad-cb65-29da-8542daacc961@pengutronix.de>
References: <CAGm1_kux90=SkCquSB3Rdh0rJdQA1DPgt42849sw-pvnNWBAXA@mail.gmail.com>
 <f5b83085-8b2a-c6c0-34b6-dbfabc6b9a9a@pengutronix.de>
 <CAGm1_ksvsQWPUriKv=zyjW_JR7GNMt=43tOnphuE=ayNT6TH0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="K1E6a9l83KPeErLuXV5ijPGOQJd2Ot97H"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46171 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751147AbdBTKqk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2017 05:46:40 -0500
In-Reply-To: <CAGm1_ksvsQWPUriKv=zyjW_JR7GNMt=43tOnphuE=ayNT6TH0g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, "Grim, Dennis" <Dennis.Grim@teejet.com>, Andrey Skvortsov <andrej.skvortzov@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K1E6a9l83KPeErLuXV5ijPGOQJd2Ot97H
Content-Type: multipart/mixed; boundary="msJt1fg1QbwTRoTrADUvASdhvIsCvJM02";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "Grim, Dennis" <Dennis.Grim@teejet.com>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>
Message-ID: <bb8046f4-efad-cb65-29da-8542daacc961@pengutronix.de>
Subject: Re: ti_hecc: canfdtest rx freeze
References: <CAGm1_kux90=SkCquSB3Rdh0rJdQA1DPgt42849sw-pvnNWBAXA@mail.gmail.com>
 <f5b83085-8b2a-c6c0-34b6-dbfabc6b9a9a@pengutronix.de>
 <CAGm1_ksvsQWPUriKv=zyjW_JR7GNMt=43tOnphuE=ayNT6TH0g@mail.gmail.com>
In-Reply-To: <CAGm1_ksvsQWPUriKv=zyjW_JR7GNMt=43tOnphuE=ayNT6TH0g@mail.gmail.com>

--msJt1fg1QbwTRoTrADUvASdhvIsCvJM02
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/20/2017 11:04 AM, Yegor Yefremov wrote:
>> Does the ti_hecc core have a RX timestamp per mailbox? Then you can ma=
ke
>> use of the rx_offload helper.
>=20
> Yes, it does. See Section "23.10.2.2 Message Object Time Stamp
> Registers (CANMOTS)". What drivers use such a feature? Only PEAK so
> far?
>=20
>         /* convert timestamp into kernel time */
>         peak_usb_get_ts_tv(&mc->pdev->time_ref, mc->ts16, &tv);
>         hwts =3D skb_hwtstamps(skb);
>         hwts->hwtstamp =3D timeval_to_ktime(tv);
>=20
> Why should this help to resolve freezing issue?

David Jander and me created the rx-offload helper, which abstracts the
reading of the mailboxes for controllers with real fifos or mailboxes
which are filled in a particular order. The timestamp of the mailbox is
used to sort the CAN frames into chronological order.

The flexcan driver has been ported to that helper, see:

30164759db1b can: flexcan: make use of rx-offload's irq_offload_fifo
b3cf53e988ce can: flexcan: add support for timestamp based rx-offload

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--msJt1fg1QbwTRoTrADUvASdhvIsCvJM02--

--K1E6a9l83KPeErLuXV5ijPGOQJd2Ot97H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAliqxLUACgkQHv7KIOw4
HPZL9AgA0taV0qLaMJhzjApKKJspc8324M1OUYdm6bYUzSvKaVg6pwuWoF8r+0um
vVUW4kT5k6uUjGR4nfHXxjLIvvaP0/u+LOtU3m3TZNc/FBFTA0vHNojQxX9E8THW
YeTjhqai6lsaS187PkVKs9+0apZ2rp2BrPmGeuWaH9F2vEklYIr/WygVXdEhYhjJ
zbEjcDw20iaErIx9Jz5PMDzENfQLLZId8RHYkS+YzfNnM9a8bNlGF2T3REXX9QQT
V+60QHTUglbpJ14w2i5wCIF0L70YUsUJUsVsRwZ6QzVqKuMle+1rZvf8j/dbsWV3
/OofD6EAF6Dhd4lJv5Zp7EqiwFSFMA==
=yi1O
-----END PGP SIGNATURE-----

--K1E6a9l83KPeErLuXV5ijPGOQJd2Ot97H--
