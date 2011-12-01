From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: git-tree, NOW!
Date: Thu, 01 Dec 2011 12:03:09 +0100
Message-ID: <4ED75EED.6010009@pengutronix.de>
References: <48E9EDF6.4000009@pengutronix.de> <4ED6B460.2010508@pengutronix.de>	<4ED7351E.2010907@grandegger.com> <4ED745F6.8030302@pengutronix.de> <4ED7494F.6080603@grandegger.com> <4ED74AC7.40605@pengutronix.de> <4ED75BD0.6070802@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEF475153A1B03197F92ABB3E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59952 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab1LALDU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 Dec 2011 06:03:20 -0500
In-Reply-To: <4ED75BD0.6070802@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, socketcan-core@lists.berlios.de, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEF475153A1B03197F92ABB3E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/01/2011 11:49 AM, Oliver Hartkopp wrote:
>>> Yes. So far we just tried to signal "patch is now ready" by adding ou=
r
>>> "acked-by"... which does not work for a series of patches, espcially =
if
>>> it touches other sub-systems as well (powerpc, devicetree).
>>
>> Yes - but David sometimes merges patches if they are not reviewed. Lik=
e
>> the pch-can driver, where I missed to reply to net-dev.

> IMO if someone begins to post a new CAN driver on netdev we should pull=
 him to
> linux-can for further discussion & review. Indeed the PCH driver mainli=
ning

+1

> was painful and IIRC it could still be merged to an other driver.

Yep, but that's a different story :)

[...]

>>>>> That's also what Dave asks for. Apart from the tree he asks for som=
eone
>>>>> who acts as the one and only interface to him.
>>>>
>>>> Yes, technically that could/should be the git tree, in persona Wolfg=
ang
>>>> or/and (as Dave asked for one person) Oliver.
>>>
>>> Oliver?
>>
>> +1

> Well - i'm pretty happy that we splitted up the responsibilities some t=
ime ago
> and i'm currently only maintaining net/can. I'm working on this basical=
ly in
> my spare time and putting my eyes on all driver details too exceeds the=
 WAF ;-)

No need to look at the driver stuff.... (continuation below)

> Regarding net/can there's not much traffic & change. So it would be ok =
for me
> to stay on the current process on netdev-ML.

>>>>>> I've setup a git repo on gitorious:
>>>>>>
>>>>>> https://gitorious.org/linux-can/linux-can
>>>>>>
>>>>>> It's based on net-next, and currently David's net-next/master is p=
ushing
>>>>>> there. It probably takes some time, the box pushing has just 4 mbi=
t/s
>>>>>> upstream.
>>>>>>
>>>>>> Comments?
>>>>>
>>>>> Apart from net-next, we may also need the net tree (as branch?).
>>>>
>>>> During merge windows David merges into his net-next tree, anyway I c=
an
>>>> setup linux-can and linux-can-next, based on the linux-net and
>>>> linux-net-next trees.
>>>
>>> Do we need two trees? I thinks you can save a lot of bandwith (and di=
sk
>>> space) by using just one tree and two branches.
>=20
>=20
> As the net tree only get's fixes i wonder why we should clone that tree=
?
> Working directly on Dave's net-tree for fixes looks straight forward to=
 me.

Thinking about it - yes, what about just keeping linux-can-next.

> But the idea for a linux-can-next is great.
>=20
> This would settle the process that we discuss new drivers & changes on
> linux-can ML and finally commit the stuff in linux-can-next, where one =
of us
> can send a pull request to Dave.

=2E..you send the pull request.

> So everything beyond fixes would go this way then.

+1

So we communicate to davem that we now have a git tree, and Oliver is
the one that send the pull requests. Let's ask him if he wants to see
the patches in the pull request.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigEF475153A1B03197F92ABB3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7XXvQACgkQjTAFq1RaXHOXZACfQaxhA0lsu/IYLtzmphuIl5Ir
L5oAoIT50vq8j/SxnVBjp+tSRLhh3eVl
=xqbp
-----END PGP SIGNATURE-----

--------------enigEF475153A1B03197F92ABB3E--
