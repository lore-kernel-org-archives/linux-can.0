From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 17 Aug 2017 13:57:13 +0200
Message-ID: <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Hu3ad1V8vdBJvbtScljpD2mh5b1JFH0cQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39703 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752175AbdHQL5T (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 07:57:19 -0400
In-Reply-To: <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hu3ad1V8vdBJvbtScljpD2mh5b1JFH0cQ
Content-Type: multipart/mixed; boundary="GUPJM4dwGOHdWbTmOfNpHPstClC9I9fDk";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
In-Reply-To: <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>

--GUPJM4dwGOHdWbTmOfNpHPstClC9I9fDk
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 07:03 AM, Oliver Hartkopp wrote:
>> Patch 9 removed the need for struct raw_sock::ifindex from the raw soc=
k, by
>> using struct sock::sk_bound_dev_if from the generic socket structure.
>=20
> Have a bad feeling on that - will comment later.

>> Patch 11: Cleans up the newly integrated CAN net namespace support.
>=20
> need to review

>> Patches 13-14: Where to put the per device protocol specific memory? a=
f_can
>> allocated it's memory during a netdev_notifier call, life cycle proves=
 to be
>> rather complicated (see remove_on_zero_entries, etc...), adding the j1=
939
>> memory makes it even more compilcated. So I decided to allocate the me=
mory
>> during the allocation if net_device. And this seems to work. More deta=
ils in
>> the individual patches.
>=20
> 'Seems to work' sounds frightening. There was a racy reason to have tha=
t=20
> implementation as-is. Although this approach sounds interesting. Need t=
o=20
> review too.
>=20
> I'm currently pretty busy at work.
> Please to not push these things without my ACK (as we had it with the=20
> namespace support where I crashed my easter holiday to fix/implement al=
l=20
> the missing stuff to fit the merge window).

Have you found some time to look at these issues?

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GUPJM4dwGOHdWbTmOfNpHPstClC9I9fDk--

--Hu3ad1V8vdBJvbtScljpD2mh5b1JFH0cQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmVhJkACgkQHv7KIOw4
HPbYGAgAyqTM/SAu9fQiMYV2eABmvGI2VIO+WmQtgOjmzextsZzlzT6wOzUg/cfh
PH1B12o62ZnIGBJo+RhQ4STAENmuE/Tc+8+sXF/HHEj0TaW54bXKL33cXYrR1IQ2
Oir2JkneXMLv0fihRGMBWpbb/+DK7Kn+/ijaNIXzuvZ4zc+rT7dxb+XSiCvei0o4
6wYNY6sYnTpeNSszbzoknl0UBj5dX8OyrGxoo3mQOE3YNCtGU0l2LrcYQtsDWEuY
FQtZ6IfLnSicujZVElzrj+PBxnOhyQqaQXHJbhXJykgu6I08UxNNEnJwni74rnlR
lRdpdC3jyzvwJ6ohADN0wX8m8Dls9g==
=tq8Z
-----END PGP SIGNATURE-----

--Hu3ad1V8vdBJvbtScljpD2mh5b1JFH0cQ--
