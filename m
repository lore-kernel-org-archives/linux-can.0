From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939: bind() and connect()
Date: Thu, 17 Aug 2017 09:35:35 +0200
Message-ID: <bc05b42e-a458-59ce-784c-9214345bbc51@pengutronix.de>
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
 <e2a14f73-9456-18c1-7e83-70d43e30cdf0@pengutronix.de>
 <20170815110116.4d12f4f3@erd980>
 <7164d44c-76f9-45f6-b5fa-c931f058163f@pengutronix.de>
 <20170815122453.3945bead@erd980>
 <20170816210831.GE32670@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8lJBCBwN3vLOChHRFWiaw41dNr2rLgsJx"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41851 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750926AbdHQHjv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 03:39:51 -0400
In-Reply-To: <20170816210831.GE32670@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8lJBCBwN3vLOChHRFWiaw41dNr2rLgsJx
Content-Type: multipart/mixed; boundary="7pHHejcx66ekRkEQTbj7mQCvL78eeUj8B";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Jander <david@protonic.nl>, linux-can <linux-can@vger.kernel.org>
Message-ID: <bc05b42e-a458-59ce-784c-9214345bbc51@pengutronix.de>
Subject: Re: j1939: bind() and connect()
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
 <e2a14f73-9456-18c1-7e83-70d43e30cdf0@pengutronix.de>
 <20170815110116.4d12f4f3@erd980>
 <7164d44c-76f9-45f6-b5fa-c931f058163f@pengutronix.de>
 <20170815122453.3945bead@erd980>
 <20170816210831.GE32670@airbook.vandijck-laurijssen.be>
In-Reply-To: <20170816210831.GE32670@airbook.vandijck-laurijssen.be>

--7pHHejcx66ekRkEQTbj7mQCvL78eeUj8B
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/16/2017 11:08 PM, Kurt Van Dijck wrote:
>>> Bind to any interface doesn't work, you cannot send anything:
>>>
>>>> static int j1939sk_sendmsg(struct socket *sock, struct msghdr *msg, =
size_t size)
>>>> { =20
>>> [...]
>>>> 	ifindex =3D jsk->ifindex_started;
>>>> 	if (!ifindex)
>>>> 		return -EBADFD; =20
>>>
>>> And you will probably not receive anything, as the rx-register, which=

>>> takes place in j1939_ifindex_start() is not done if you try to bind t=
o
>>> any device (bound_dev_if =3D=3D 0).
>=20
> which is like calling tcpdump when the interface is down, yep.
> That's a stupid thing to do, but not necessarily a bad API.

=46rom my point of view, you either want to do diagnostics, then you'd us=
e
tcpdump/wireshark. Or you have a legitimate application scenario, but
then you don't want other applications to interfere with the packages
you receive.

First I want to keep it simple and allow only binds to exactly one
interface. If it later turns out, that bind to any is a requirement, we
can still add it.

>>>> 	if (bound_dev_if && bound_dev_if !=3D jsk->ifindex_started) { =20
>>> [...]
>>>>
>>>> 		ret =3D j1939_ifindex_start(bound_dev_if); =20
>>>
>>> Then I'll add proper test, that you have to bind to a specific
>>> interface. That will make the code much simpler.
>=20
> I agree that in contrast to my initial goal, binding to any interface
> complicates things. Since j1939 is not a routed protocol, you should be=

> aware of at least which interface you're running on.
> Userspace programs can still default to can0 :-)
>=20
> And it probably simplifies the socket code quite much. That's a good
> thing too.

ACK.

>> I agree. Don't know if the case for bind-any will ever be necessary in=
 the
>> context of J1939, but we certainly should keep things simple for now.
>> I've had cases myself where an ECU would talk J1939 on two interfaces =
at the
>> same time, but not yet something like a Group-Function server exportin=
g the
>> same functions on more than one interface. I could think of that use-c=
ase
>> happening though, but it can also be solved easily in user-space openi=
ng more
>> than one socket...
>=20
> Indeed, logical ECU's connected to 2+ j1939 busses cannot take any
> advantage by combining multiple interfaces. the 2+ busses will always b=
e
> addressed independantly, like David suggests by opening more sockets.

Let's conclude:
- bind() to any not allowed
- bind() to a single interface needed before {send,rcv}_msg()
- re-bind() to same interface allowed
- bind() before connect() mandatory
- re-connect() allowed

Is this correct?

regards.
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7pHHejcx66ekRkEQTbj7mQCvL78eeUj8B--

--8lJBCBwN3vLOChHRFWiaw41dNr2rLgsJx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmVR0cACgkQHv7KIOw4
HPZvOAf/aiRYCXJNzsWZHVMVkcaHxEKGY16131wGv2twzMkmkmkDFNdkselQqeUg
iWdMnXJPeMG/hYOxUODZdBR665A7/pdv8m7/8jS9rXBYUcr2aEPU09UG1u4oD5lb
68mrthPYmjzEr8kfuoSqEG9RIyOrkptO3I/9q1Rf02rk9widuHc2AQFWQOzsn+BV
vzu7UegVyvg7w+RbWzk8ar+q6oVN44M3Rwer3zDT6YqcCwGwHNJd22dsLAVAvSw7
85ckzi9x8tMxiGoc4IGYe5RMO3oIWA/z4mKz5LSAtqEFDoYZb6VTtHwduQDi1rCZ
mK1oDqOgTJIgLkcofl/uxrnGo4rXnQ==
=HGyB
-----END PGP SIGNATURE-----

--8lJBCBwN3vLOChHRFWiaw41dNr2rLgsJx--
