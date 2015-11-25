From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: J1939 crash after receiving BAM frame and no DT frame
Date: Wed, 25 Nov 2015 15:59:42 +0100
Message-ID: <5655CCDE.2090701@pengutronix.de>
References: <loom.20151120T162359-379@post.gmane.org>
 <20151123200923.GA4556@airbook.vandijck-laurijssen.be>
 <CAA7hF3zr0jcJNRn6EYVuFfhg-xCab5MR=B4budC1Pzce0xL7zg@mail.gmail.com>
 <20151125132633.GE764@airbook.vandijck-laurijssen.be>
 <CAA7hF3zSyPFDEzuPWmwwBhTf3005U_g8fEV3ses5_i+Gi=_ecw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AUP4cDXsVi4a8LdAj2lbOTKBgpoRrfae4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47760 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbKYO7w (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2015 09:59:52 -0500
In-Reply-To: <CAA7hF3zSyPFDEzuPWmwwBhTf3005U_g8fEV3ses5_i+Gi=_ecw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>, linux-can@vger.kernel.org, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AUP4cDXsVi4a8LdAj2lbOTKBgpoRrfae4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/25/2015 02:39 PM, laurent vaudoit wrote:
>>> i have found a workaround, working with rtpatch, but not sure if this=

>>> can be considered as a bug fix or not.
>>> in function j1939tp_rxtask, there is a call to j1939session_cancel,
>>> who call put_session
>>> and at the end of j1939tp_rxtask, we call put_session.
>>> if i comment this "second call" to put_session, the problem disappear=
=2E
>>
>> It seems that you added a memory leak because put_session if a ref
>> counter. You keep the session installed ... forever, or until a next
>> similar session is about to be created.
>>
>> I'm not sure either that this is the correct way to proceed.
>=20
> i'm not sure i understand well.
> this seems weird for me to have one get_session and 2 put_session
> should'nt we have one get_session and one put_session only? (this is
> what i tried)?

Maybe copy/pasting your patch here make the discussion easier :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AUP4cDXsVi4a8LdAj2lbOTKBgpoRrfae4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWVczeAAoJEP5prqPJtc/HgksIALy6c2CBnSd7x7TzrvrxeWUu
BAEKUirbJ6Tf35tbyyPml5E9fxBp1KqtUT51smC1yj3Xx1xWs+K9BTpdrPaa+WDX
wMxyqpc9ovyN8RAkhLFV3Jx16wKiba2vC8TYzVyUc3tZ0eCIT9j5BuIL3o9dxUr2
h5TbldnFBFdo1X0QcwgWVek1cbfFb66gfgKoKumqzH5+kai9CP1LcIX9pO6N0m5C
vpEMtq47RHQPdtbOt0sY+dw7iztiz9Qae+3ElWBf+Ba1rj/yBYfN3XTH2//311tj
H/NVeTYC9mggHJVFuOMwpbPs7XW+fCkLeh/a3bjs1y+6F+wIYo9YybZvAklu8Ng=
=k97c
-----END PGP SIGNATURE-----

--AUP4cDXsVi4a8LdAj2lbOTKBgpoRrfae4--
