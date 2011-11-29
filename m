From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Gitorious] Activity: dschanoeh updated merge request for...
Date: Tue, 29 Nov 2011 15:08:13 +0100
Message-ID: <4ED4E74D.3090608@pengutronix.de>
References: <20111129121452.B4F9F7590F@steelheart.shortcut.kunder.linpro.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A6CDC0E42985BCF56175248"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55294 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474Ab1K2OIS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Nov 2011 09:08:18 -0500
In-Reply-To: <20111129121452.B4F9F7590F@steelheart.shortcut.kunder.linpro.no>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dschanoeh@googlemail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A6CDC0E42985BCF56175248
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello * and dschanoeh,

On 11/29/2011 01:14 PM, Gitorious wrote:
> -----------------------------------------------------------------------=
-
> dschanoeh updated merge request for dschanoehs-can-utils with can-utils=
=2E
> The merge request is at http://gitorious.org/linux-can/can-utils/merge_=
requests/1
> -----------------------------------------------------------------------=
-

I just received this pull request from you. It basically consists of
* removing plain old Makefile
* fixes for the old include directory

Regarding removing Makefile, fine with me, Oliver what do you think?

I've started some time ago to import the includes from the svn into the
git, but kernel only includes were still left. Now I just updated my git
repo which merges the includes and adopts both Makefile and autotools.

There is a squashed version, which imports the includes without their
history. This branch is called master-squashed.

Please checkout the master branch (or master-squashed) of my repo and tes=
t:
https://gitorious.org/~bet-frogger/linux-can/mkl-can-utils

There is a j1939 branch, too.

Please test and comment, if everything works I want to commit either my
master branch or master-squashed to the official repo, which branch is
better?

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3A6CDC0E42985BCF56175248
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7U51AACgkQjTAFq1RaXHN3iwCfZLfr7qGbarOSpExQYRS0QRvc
7vMAn2eSCRg0qIZ/LU2pnyoRoxqxxVrc
=7eJG
-----END PGP SIGNATURE-----

--------------enig3A6CDC0E42985BCF56175248--
