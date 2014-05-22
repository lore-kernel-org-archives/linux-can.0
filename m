From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Kernel Oops when setting j1939 device on
Date: Thu, 22 May 2014 13:47:03 +0200
Message-ID: <537DE3B7.7080302@pengutronix.de>
References: <CAJdBzeATNb2pBOdp5bpx86Bw+K00wYwjgFOuRGbtZSPXvMoBuQ@mail.gmail.com> <20140520201654.GD25701@vandijck-laurijssen.be> <CAJdBzeBEL=pz4imZvywVwZsjj3o7Gh6JshgKrm3aSbYOjMiZ6Q@mail.gmail.com> <20140521191215.GA581@vandijck-laurijssen.be> <CAJdBzeA8=UVGa0yR2AUexEJjhtcd16P=iwdoM8+MqM=UHvfdCw@mail.gmail.com> <20140522092927.GA23173@vandijck-laurijssen.be> <537DCA08.4040000@artisandeveloppeur.fr> <20140522113920.GB23173@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Fp2sTvbVwBLHSHKijh0qDdu5F4uPGx5uh"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52501 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbaEVLrS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 May 2014 07:47:18 -0400
In-Reply-To: <20140522113920.GB23173@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maxime Jayat <maxime@artisandeveloppeur.fr>, Timothy Vieregge <tvieregge@clearpathrobotics.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fp2sTvbVwBLHSHKijh0qDdu5F4uPGx5uh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2014 01:39 PM, Kurt Van Dijck wrote:
> Hey Maxime & Timothy,
>=20
> On Thu, May 22, 2014 at 11:57:28AM +0200, Maxime Jayat wrote:
> [...]
>>
>> I've hit the same problem as Timothy in the past. I've looked into it
>> and the reason for it is that the code in
>> https://gitorious.org/linux-can/linux-can-j1939/source/j1939-v3.8:net/=
can/af_can.c#L1020-1041
>> is different from the code in
>> https://gitorious.org/linux-can/can-j1939-modules/source/master:net/ca=
n/af_can.c#L1169
>> and the former still has a bug that is fixed in the latter in can_vali=
date_link_af.
>>
>> In particular:
>> 		cp =3D can_get_proto(nla_type(prot));
>> 		if (!cp || !cp->rtnl_link_ops)
>> 			ret =3D -EPROTONOSUPPORT;
>> 		else if (!cp->rtnl_link_ops->validate_link_af)
>> 			ret =3D 0;
>> 		else
>> 			ret =3D cp->rtnl_link_ops->validate_link_af(dev, prot);
>> 		can_put_proto(cp);
>> 		if (ret < 0)
>> 			return ret;
>>
>> doesn't end well for can_put_proto when can_get_proto returns NULL.
>=20
> That explains things, but I'm still puzzled why it did work on my machi=
nes.
> Maybe some other config option makes the call to module_put inside can_=
put_proto
> behave different?
>=20
> Anyway, you pointed to a real problem, and I promptly pushed a patch fo=
r it.
> Timothy, pulling in git and building again should really solve the prob=
lem
> that the systems fails. You will still need to load can-j1939, but you =
will
> informed better about this, and the system itself should not fail.
>=20
>>
>> I find it not very clear to see what is the most up-to-date repo for J=
1939
>> and whether all the branches in linux-can-j1939 are supposed to be mai=
ntained
>> along with can-j1939-modules.
>=20
> out-of-tree modules become old-fashioned with the use of git.
> can-j1939-modules is a remainder of the state we were in on berlios usi=
ng SVN.
> I don't intend to spend much effort on the out-of-tree modules ...

If you don't maintain the modules anymore, can you delete the repo? Or
add a prefix like -depreaced.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Fp2sTvbVwBLHSHKijh0qDdu5F4uPGx5uh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlN947cACgkQjTAFq1RaXHN8HgCdHZUOID2dRaXVcnL+NgdtDtdn
kp0An1Qg4gQ1c6O5webpemDEEaIgTmpn
=WkyF
-----END PGP SIGNATURE-----

--Fp2sTvbVwBLHSHKijh0qDdu5F4uPGx5uh--
