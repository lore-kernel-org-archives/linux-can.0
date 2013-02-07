From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] cangen: use long long in time computation for -g to support
 >2.1s
Date: Thu, 07 Feb 2013 13:57:07 +0100
Message-ID: <5113A4A3.70003@pengutronix.de>
References: <20130207101708.B072CFC0@ratt.gitorious.c.bitbit.net> <1360233489-14471-1-git-send-email-mkl@pengutronix.de> <511384F4.703@pengutronix.de> <51138A44.5090306@awinia.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2JSXNCXKHQNXSRDSRITNG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34538 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758378Ab3BGM5N (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Feb 2013 07:57:13 -0500
In-Reply-To: <51138A44.5090306@awinia.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Konrad Anton <konrad.anton@awinia.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2JSXNCXKHQNXSRDSRITNG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/07/2013 12:04 PM, Konrad Anton wrote:
> Hello,
>=20
> On 07.02.2013 11:41, Marc Kleine-Budde wrote:
>> we're a bit oldschool and discuss the code on the
>> linux-can@vger.kernel.org mailinglist. Feel free to subscribe.
>=20
> Can you please put that information on the Gitorious page for the next
> casual committer?
>=20
>=20
>>>       ts.tv_sec =3D gap / 1000;
>>> -    ts.tv_nsec =3D ((int)(gap * 1000000)) % 1000000000;
>>> +    ts.tv_nsec =3D (long)(((long long)(gap * 1000000)) % 1000000000l=
l);
>>
>> What's going on here exactly?
>>
>> gap is a double - Will it be converted into an int before multiplicati=
on
>> with 1000000? IIRC there is a difference between "gap * 1000000" and
>> "gap * 1000000.0". In the latter the multiplication is done in floatin=
g
>> point, because of the ".0".
>=20
> gap is a double.
> (gap * 1000000) will cause 1000000 to be converted to intermediate temp=
1
> of type double,
> temp1 will be truncated to long long temp2, losing its decimals,
> temp2 will be moduloed by 1000000000ll in a long-long mod operation,
> giving temp3.
> temp3 will be truncated to as many bits as long has, and stored in long=

> tv_nsec.
>=20
> I think it is safe.

Thanks for the details. Looks good. Can I add your Signed-off-by[1] to
the patch?

Marc
[1]
http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L298=

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2JSXNCXKHQNXSRDSRITNG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlETpKcACgkQjTAFq1RaXHMoUgCdEmlMcCPedjpFEmrDMD24HgUq
TEgAoJUO9aZpafmyOnEsdMqoNwzxb2Ze
=SxX2
-----END PGP SIGNATURE-----

------enig2JSXNCXKHQNXSRDSRITNG--
