From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: MCP251x bit rate calculations wrong
Date: Mon, 28 Oct 2013 17:05:28 +0100
Message-ID: <526E8B48.1090309@pengutronix.de>
References: <CANQdSEGgf=UiYwKcOyoLA2qmtiF19XaD46_3ZkTHRUXOwe-+yQ@mail.gmail.com> <CANQdSEHbU1PfoLG4oOK+epKOp-pyn3n9E4xCsHJQMh5Y9znTng@mail.gmail.com> <526E214A.9090108@pengutronix.de> <CANQdSEHertsyR2Zbs7XrC9W3nqe=D5yQjKE=qJqC7q1wXZtVeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1PPq5c1i4BOqGcuPjqXDA5pNcTu6mfGJv"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58852 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756536Ab3J1QFe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Oct 2013 12:05:34 -0400
In-Reply-To: <CANQdSEHertsyR2Zbs7XrC9W3nqe=D5yQjKE=qJqC7q1wXZtVeQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Brennan Ashton <bashton@brennanashton.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1PPq5c1i4BOqGcuPjqXDA5pNcTu6mfGJv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/28/2013 04:50 PM, Brennan Ashton wrote:
> On Mon, Oct 28, 2013 at 1:33 AM, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:
>> On 10/26/2013 07:26 PM, Brennan Ashton wrote:
>>> I did not see this line:
>>> 1024 >---priv->can.clock.freq =3D pdata->oscillator_frequency / 2;$
>>>
>>> So the kernel driver should be fine but in can utils this should stil=
l
>>> be fixed for the -1
>>
>> Can I add your Signed-off-by to the patch?
>>
>> Marc
>=20
> Sure,
> Signed-off-by: Brennan Ashton <bashton@brennanashton.com>

Pushed to master.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1PPq5c1i4BOqGcuPjqXDA5pNcTu6mfGJv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJui0kACgkQjTAFq1RaXHPVvQCfSZgVZTZiVmBY/+y4ZsyKQIY3
zokAn1k55SNYW/Vwsut+ew0RKku2ytxq
=KC8T
-----END PGP SIGNATURE-----

--1PPq5c1i4BOqGcuPjqXDA5pNcTu6mfGJv--
