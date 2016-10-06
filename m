From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Thu, 6 Oct 2016 10:59:50 +0200
Message-ID: <a6920929-30e0-0c69-52f1-96998698bbf6@pengutronix.de>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0ii4xDWfN23Xq0j822OMENdxERfdqWUjt"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48270 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966106AbcJFJAA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 05:00:00 -0400
In-Reply-To: <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0ii4xDWfN23Xq0j822OMENdxERfdqWUjt
Content-Type: multipart/mixed; boundary="n0JjXAVHGL1tRcLHKiGFWFmIunkVtXhJM";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>,
 Kurt Van Dijck <kurt.van.dijck@eia.be>
Message-ID: <a6920929-30e0-0c69-52f1-96998698bbf6@pengutronix.de>
Subject: Re: j1939
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161006084407.GB11907@airbook.vandijck-laurijssen.be>

--n0JjXAVHGL1tRcLHKiGFWFmIunkVtXhJM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2016 10:44 AM, Kurt Van Dijck wrote:
>> The remaining warning is about a case statement without fall through
>> annotations and/or breaks:
>>
> I rebased this code for my own use so that I have access to my
> individual commits. You will find this on
>=20
> git://github.com/kurt-vd/linux, branch j1939d-v4.7

As long as the diff between you and my branch is zero :)

> I pushed 2 extra commits:
> * 3dfa139: Pad TP data packets only
>   This is based on the discussions here. I promised to move the
>   padding...

Thanks.

> * e2447ef: make TP data transmission work again
>   This commit fixes a mistake you've done with the fall-trough
>   statements in j1939tp_txnext (this isn't the easiest state machien on=

>   Earth :-) ).

Thanks.

I have cherry picked both and will push them to v4.7. If everything
works on the v4.7 branch, I'll squash most of it together an move to v4.8=
=2E

Thoughts?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--n0JjXAVHGL1tRcLHKiGFWFmIunkVtXhJM--

--0ii4xDWfN23Xq0j822OMENdxERfdqWUjt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX9hKGAAoJED07qiWsqSVqDQwH/A2kmu/POpZOKugLLhokGl9v
eDNV9ifD7nHhOV9MtagRqAKtrqfZ4Jss/XEkAZKUfuVDuRch1/f7kZ82boYE8se2
Ri/hSOXn8ko7B1ocRlmp8+XX374+lRk/IjfRdWDjaP5DykhZ1c7fKQcJR3A5GLY4
74FFHczYhjvGLq+n8Ta4Z/jTK3bGX8vT81bQ38qi1bqJrNsbSRWDMvkUnv+OGyKB
Na3U1DKpdrpLkSg+3xIb4wg/K0PJLfcxy5kKR8IqmWTq69zn4wOrGPcpgHsu7Clg
yXprMsPZTZdfrdjUHtlD3B3qDKrwaN6mkGBZ/psi5P1p6GClr6+g1w5dYypDT0s=
=JlJP
-----END PGP SIGNATURE-----

--0ii4xDWfN23Xq0j822OMENdxERfdqWUjt--
