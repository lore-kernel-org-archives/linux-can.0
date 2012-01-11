From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: using git
Date: Wed, 11 Jan 2012 13:39:02 +0100
Message-ID: <4F0D82E6.4050800@pengutronix.de>
References: <20111221091948.GC314@e-circ.dyndns.org> <4EF2D0F3.6080909@hartkopp.net> <4F0D6EA9.4070708@pengutronix.de> <4F0D6FB7.9090407@hartkopp.net> <20120111122609.GG314@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig44580D2A362C30D7AB7A459E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59709 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757471Ab2AKMjI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 07:39:08 -0500
In-Reply-To: <20120111122609.GG314@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig44580D2A362C30D7AB7A459E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2012 01:26 PM, Kurt Van Dijck wrote:
>>> nitpick:
>>> Oliver, please don't forget to add your S-o-b if you are pushing comm=
its
>>> to the tree.
>>
>>
>> Yes. I noticed myself, that i need to improve this process by reading =
more git
>> documentation ;-)
>>
>> Yesterday i just cherry-picked the patch and pushed it to the repo.
>>
>> The next time i'll do it the right(TM) way :-)
>=20
> Oliver or Marc,
>=20
> just out of curiosity,
> what would be the right(TM) way?

3 possibilities:

1) merge your tree:
(if it only contains the patch we want)

git checkout master
git merge tree-of-kvd/branch-name
git push origin master

2) cherry pick

git checkout master
git cherry-pick -s commitish-of-patch  # -s automatically adds the S-o-b
git push origin master

3) apply patch

git checkout master
git am -s /path/to/patch               # -s automatically adds the S-o-b
git push origin master


For solution 1 and 2 you need Kurt's tree in your local repo (git remote
add).

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig44580D2A362C30D7AB7A459E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8NgukACgkQjTAFq1RaXHNFRgCeOoCa58DZrSSJg6lXAdpdEEXK
KuwAoIukQFweMckW7NWTy4I9O/Ra2s1k
=nohy
-----END PGP SIGNATURE-----

--------------enig44580D2A362C30D7AB7A459E--
