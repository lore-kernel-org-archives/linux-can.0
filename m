From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN j1939 library doubts
Date: Fri, 15 Mar 2013 11:33:45 +0100
Message-ID: <5142F909.5070007@pengutronix.de>
References: <loom.20130312T213038-40@post.gmane.org> <854F9BFD-752B-4B2B-A637-7310BCF8B7D2@emailplus.org> <20130313084248.GA449@vandijck-laurijssen.be> <loom.20130314T121737-364@post.gmane.org> <20130314122045.GD3382@vandijck-laurijssen.be> <loom.20130314T145923-349@post.gmane.org> <20130314210751.GC1387@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2NXKXIDQLCMKVBIDCNDST"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49650 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab3COKdt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Mar 2013 06:33:49 -0400
In-Reply-To: <20130314210751.GC1387@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Giox79 <giovanniparodi79@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NXKXIDQLCMKVBIDCNDST
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2013 10:07 PM, Kurt Van Dijck wrote:
> On Thu, Mar 14, 2013 at 04:20:08PM +0000, Giox79 wrote:
>> Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:
>>
>> In order to integrate your libs to my kernel, I was supposing to make =
a diff=20
>> between source file, looking mainly at can and iproute2, merge the dif=
fs and=20
>> build the whole system.
>> Do you think this is the right approach?
> no. I (just) prepared the repositories to allow easy merges.
>=20
> follow these steps (@Marc, can you just verify the 'git' calls):

:) Looks good.

> git clone your kernel, or get a stable one
> 	$ git clone http://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x-stable.git
> ... this takes time
> 	$ cd linux-stable
> 	$ git tag
> choose a version, like v3.3, or v3.8, ...
> 	$ git checkout <chosen-version>
> 	$ git checkout -b <new-branch-name>
> This last command creates a new branch, so you can play freely.
> Now choose your branch on http://gitorious.org/~kurt-vd/linux-can/linux=
-can-j1939
> , like j1939-v3.3
> 	$ git pull git://gitorious.org/~kurt-vd/linux-can/linux-can-j1939.git =
<gitorious-branch-name>

I would add Kurt's tree as a remote, instead of pull do:

    git remote add -f kurt git://gitorious.org/~kurt-vd/linux-can/linux-c=
an-j1939.git
    git merge kurt/<gitorious-branch-name>

If you already have a git tree, you can start with the "git remote add".

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2NXKXIDQLCMKVBIDCNDST
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFC+QkACgkQjTAFq1RaXHNWRACfWeqhO4ljLgrbYS57iP5rrotn
EE4AoIiuUwRrGFNaMN2Mch3m2tnODLvQ
=zd91
-----END PGP SIGNATURE-----

------enig2NXKXIDQLCMKVBIDCNDST--
