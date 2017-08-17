From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939: bind() and connect()
Date: Thu, 17 Aug 2017 10:32:42 +0200
Message-ID: <69a74c1a-6042-76fb-e7f7-5c9dd884c034@pengutronix.de>
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
 <e2a14f73-9456-18c1-7e83-70d43e30cdf0@pengutronix.de>
 <20170815110116.4d12f4f3@erd980>
 <7164d44c-76f9-45f6-b5fa-c931f058163f@pengutronix.de>
 <20170815122453.3945bead@erd980>
 <20170816210831.GE32670@airbook.vandijck-laurijssen.be>
 <bc05b42e-a458-59ce-784c-9214345bbc51@pengutronix.de>
 <20170817082827.GA7870@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ad2n8fLIVmAw1k978d08JlwsctssE1ICS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59653 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751266AbdHQIcs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 04:32:48 -0400
In-Reply-To: <20170817082827.GA7870@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ad2n8fLIVmAw1k978d08JlwsctssE1ICS
Content-Type: multipart/mixed; boundary="9qlsuErEnoN54eUnfl7u5rcDlpa4sUpVU";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Jander <david@protonic.nl>, linux-can <linux-can@vger.kernel.org>
Message-ID: <69a74c1a-6042-76fb-e7f7-5c9dd884c034@pengutronix.de>
Subject: Re: j1939: bind() and connect()
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
 <e2a14f73-9456-18c1-7e83-70d43e30cdf0@pengutronix.de>
 <20170815110116.4d12f4f3@erd980>
 <7164d44c-76f9-45f6-b5fa-c931f058163f@pengutronix.de>
 <20170815122453.3945bead@erd980>
 <20170816210831.GE32670@airbook.vandijck-laurijssen.be>
 <bc05b42e-a458-59ce-784c-9214345bbc51@pengutronix.de>
 <20170817082827.GA7870@airbook.vandijck-laurijssen.be>
In-Reply-To: <20170817082827.GA7870@airbook.vandijck-laurijssen.be>

--9qlsuErEnoN54eUnfl7u5rcDlpa4sUpVU
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 10:28 AM, Kurt Van Dijck wrote:
>=20
>> Let's conclude:
>> - bind() to any not allowed
>> - bind() to a single interface needed before {send,rcv}_msg()
>> - re-bind() to same interface allowed
>> - bind() before connect() mandatory
> 4x ack
>=20
>> - re-connect() allowed
>=20
> As David pointed out, re-connect() is not necessary. If it makes things=

> much simpler, then drop it for now. right?

Fine with me.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--9qlsuErEnoN54eUnfl7u5rcDlpa4sUpVU--

--ad2n8fLIVmAw1k978d08JlwsctssE1ICS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmVVKoACgkQHv7KIOw4
HPZ01gf6Az2NFdOWfnavvDM5us0u5RIR6JdPzi/5vXAN9yZuhycIQpStvf3KuB07
Ue5nK99CMwFCiqrkKSKVYpEYyAfc0Wy9iwWFMaPVaxysMDYgpvNOygACvbx9LS3S
snDiyA6J1nAjEFkap+Z9MP8/KI+ZjUdx4CFd25lgR/JTyu941KsSNDenM4EJZTEu
YiG/aPMzRhislH5QThzJ0jNAzfhvYwfSzsXnVIiFxs/xM8PXxxBqkABNScuWhxJL
CmkdJNG1C6gYEGUPkyY8goFdpgGi8+s0n3ER0EBqOYMzuKKktAV60LGTZTFYNz2z
0jnYBGKfWA8+Vm9XvwFQIaG4sRcHFA==
=VuB5
-----END PGP SIGNATURE-----

--ad2n8fLIVmAw1k978d08JlwsctssE1ICS--
