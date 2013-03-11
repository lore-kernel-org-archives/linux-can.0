From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Mon, 11 Mar 2013 17:00:59 +0100
Message-ID: <513DFFBB.8050406@pengutronix.de>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net> <513763CC.1070507@pengutronix.de> <20130307124012.GC603@vandijck-laurijssen.be> <5139A78D.9060005@pengutronix.de> <20130308100548.GA496@vandijck-laurijssen.be> <20130308125123.GA28383@pengutronix.de> <20130311092923.GA5114@vandijck-laurijssen.be> <513DF3D4.6090605@pengutronix.de> <20130311153437.GD5114@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2BONUDOWPGLNBFTMFORPL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56851 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab3CKQBB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Mar 2013 12:01:01 -0400
In-Reply-To: <20130311153437.GD5114@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>, Sako Youssouf <youssouf.sako@renault-trucks.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2BONUDOWPGLNBFTMFORPL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/11/2013 04:34 PM, Kurt Van Dijck wrote:
> On Mon, Mar 11, 2013 at 04:10:12PM +0100, Marc Kleine-Budde wrote:
>> On 03/11/2013 10:29 AM, Kurt Van Dijck wrote:
>>>
>>>
>>> On Fri, Mar 08, 2013 at 01:51:23PM +0100, Robert Schwebel wrote:
>>>> Hi Kurt,
>>>>
>>>> On Fri, Mar 08, 2013 at 11:05:48AM +0100, Kurt Van Dijck wrote:
>>>>> Could I just mark j1939 as "EXPERIMENTAL" in Kconfig.
>>>>> I think that is what I've seen most for 'unstable concepts'.
>>>>
>>>> EXPERIMENTAL is considered to be deprecated and might be removed fro=
m
>>>> the kernel, so I wouldn't go down that road. Staging sounds right.
>>>
>>> I see.
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/CodingStyle?id=3Dv3.9-rc2#n549
>>>
>>> Is such thing then appropriate?
>>
>> Does j1939 have a protocol number? Probably.
> Yes. 7.
>=20
>> If so, we shouldn't use the
>> "next free" one for an experimental protocol.
> That's another reason to have J1939 merged.
> I would have alerted anyhow when the protocol number 7 got allocated...=


Yes, but as soon as you are "officially" using the number 7, you have to
provide a stable API and ABI to the userspace.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2BONUDOWPGLNBFTMFORPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE9/7sACgkQjTAFq1RaXHMGNQCgh+2y5T3w4NFjFP35w8lS/XP9
2/EAn08acPzAOs91NbtqDCiWyL1UyPzt
=E7PE
-----END PGP SIGNATURE-----

------enig2BONUDOWPGLNBFTMFORPL--
