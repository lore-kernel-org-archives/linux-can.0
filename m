From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: using git
Date: Wed, 11 Jan 2012 14:04:05 +0100
Message-ID: <4F0D88C5.4060704@pengutronix.de>
References: <20111221091948.GC314@e-circ.dyndns.org> <4EF2D0F3.6080909@hartkopp.net> <4F0D6EA9.4070708@pengutronix.de> <4F0D6FB7.9090407@hartkopp.net> <20120111122609.GG314@e-circ.dyndns.org> <4F0D82E6.4050800@pengutronix.de> <20120111125433.GH314@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig173ED29F57F072487404EB28"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50852 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049Ab2AKNEL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 08:04:11 -0500
In-Reply-To: <20120111125433.GH314@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig173ED29F57F072487404EB28
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2012 01:54 PM, Kurt Van Dijck wrote:
> On Wed, Jan 11, 2012 at 01:39:02PM +0100, Marc Kleine-Budde wrote:
>> On 01/11/2012 01:26 PM, Kurt Van Dijck wrote:
>>>>> nitpick:
>>>>> Oliver, please don't forget to add your S-o-b if you are pushing co=
mmits
>>>>> to the tree.
>>>>
>>>>
>>>> Yes. I noticed myself, that i need to improve this process by readin=
g more git
>>>> documentation ;-)
>>>>
>>>> Yesterday i just cherry-picked the patch and pushed it to the repo.
>>>>
>>>> The next time i'll do it the right(TM) way :-)
>>>
>>> Oliver or Marc,
>>>
>>> just out of curiosity,
>>> what would be the right(TM) way?
>>
>> 3 possibilities:
>>
>> 1) merge your tree:
>> (if it only contains the patch we want)
>>
>> git checkout master
>> git merge tree-of-kvd/branch-name
>> git push origin master
>>
>> 2) cherry pick
>>
>> git checkout master
>> git cherry-pick -s commitish-of-patch  # -s automatically adds the S-o=
-b
>> git push origin master
>>
>> 3) apply patch
>>
>> git checkout master
>> git am -s /path/to/patch               # -s automatically adds the S-o=
-b
>> git push origin master
>>
>=20
> thanks for this lesson :-)
> 1 additional question:
> Would in case 3 the SHA commit name be the same?

Compared 2 and 3?

Usually not. As the meta data (here the timestamps) will be included in
the  calculation of the committish, it won't be the same. E.g. the meta
data of your commit in master:

Author:     Kurt Van Dijck <kurt.van.dijck@eia.be>
AuthorDate: Wed Dec 21 10:08:57 2011 +0100
Commit:     Oliver Hartkopp <socketcan@hartkopp.net>
CommitDate: Tue Jan 10 17:41:07 2012 +0100

But you can tweak the timestamps, e.g. during "git commit --amend" with
the environment variables GIT_AUTHOR_DATE, GIT_COMMITTER_DATE ("man
git-commit").

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig173ED29F57F072487404EB28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8NiMgACgkQjTAFq1RaXHO+OgCfQQ6kFPRq81Iug4LjzVLynoe2
kSMAn2ilch+jsUhiR4GK+aJBHLiA8QqL
=6aAu
-----END PGP SIGNATURE-----

--------------enig173ED29F57F072487404EB28--
