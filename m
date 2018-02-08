From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939: Attempt to make j1939 network namespace-aware
Date: Thu, 8 Feb 2018 16:08:30 +0100
Message-ID: <6152a755-dcac-e47c-db38-88d709cc5fb2@pengutronix.de>
References: <CAHChkrvE+uczdhu66snkAt8p2AfgM=sKraaxFJTRDCSXjdS24g@mail.gmail.com>
 <20180206203752.GG1198@airbook.vandijck-laurijssen.be>
 <CAHChkrt1jnY64HJNMinLAc-xaT04i=WyyLug+yVpUew7wqoaAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kAWJZ6GYurk4z52wVM1QJG2rPlESVmq7k"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36893 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbeBHPJL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Feb 2018 10:09:11 -0500
In-Reply-To: <CAHChkrt1jnY64HJNMinLAc-xaT04i=WyyLug+yVpUew7wqoaAQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kAWJZ6GYurk4z52wVM1QJG2rPlESVmq7k
Content-Type: multipart/mixed; boundary="pjfpg26zU3iMJycyw8yMcOTMadbvpXJVB";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org
Message-ID: <6152a755-dcac-e47c-db38-88d709cc5fb2@pengutronix.de>
Subject: Re: j1939: Attempt to make j1939 network namespace-aware
References: <CAHChkrvE+uczdhu66snkAt8p2AfgM=sKraaxFJTRDCSXjdS24g@mail.gmail.com>
 <20180206203752.GG1198@airbook.vandijck-laurijssen.be>
 <CAHChkrt1jnY64HJNMinLAc-xaT04i=WyyLug+yVpUew7wqoaAQ@mail.gmail.com>
In-Reply-To: <CAHChkrt1jnY64HJNMinLAc-xaT04i=WyyLug+yVpUew7wqoaAQ@mail.gmail.com>

--pjfpg26zU3iMJycyw8yMcOTMadbvpXJVB
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/07/2018 05:41 PM, Elenita Hinds wrote:
> Thanks for the feedback, Kurt. I'll split into separate patches as
> suggested for clarity. The additional whitespaces were due to linux
> kernel styles imposed upon in my environment (enabled and won't let me
> commit unless I align certain lines).

I've manually picked the (maybe not all) whitespace changes manually and
added them to linux-can-next/j1939. Please send your patches using git
not via a webinterface, as it makes the patches unusable.

> I found missing changes in the j1939 notifier block which I think can
> cause the kernel to panic when a CAN bus interface goes down. This is
> fixed and will post the changes.

As Kurt said, please make this a seperate patch.

> I also figured out how to complete the TODO item and will post these as=
 well.
>=20
> I'm also trying to coordinate these changes with Oleksij (Rempel) but
> he is out for the moment.
>=20
> To answer your questions above, based on the kernel examples and
> implied on the info I've seen, I think almost all need duplicating and
> this includes the /proc and module parameters (see detailed
> description in http://apprize.info/linux/kernel/15.html). And yes, the
> ifindex values can be re-used in different namespaces.

In the j1939 branch proc support has been removed for now.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pjfpg26zU3iMJycyw8yMcOTMadbvpXJVB--

--kAWJZ6GYurk4z52wVM1QJG2rPlESVmq7k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlp8Z+4ACgkQk9IU1zQo
ZfGJfwf+IyM/zeOS70aqQcDpg972ocJRnjdCT8+vYTlErPeXrSDdx33gNRCkHHgZ
dSv3+uyxjqA71V1OCq3gEv/zvDayh3BCoxrUD+ym2RCFjJ4PRh9ltMQMiWGs6oa4
psEoCfJCuvIP1cnDngbYPUJ1B0+yEnVQ/k+IgnhP26tb5Kva1lq+NrFpNHQBa2eD
48CNq8FvW0ft14gP7SsbLRe+JtMAILRTX/Tzpqe/X0dmV3oX64Ar9NdPiac0rbXd
+/UqttbRCS62NrY1kCc/BJX7Rkm2dM1SBpg/Way4Jo4r0JtgCB9ggXsWv6uNQOY9
3dLTHBg2P3rentrGLICVVg6896Xf6Q==
=4gSh
-----END PGP SIGNATURE-----

--kAWJZ6GYurk4z52wVM1QJG2rPlESVmq7k--
