From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Softing Firmware on gitorious
Date: Thu, 12 Jan 2012 11:12:20 +0100
Message-ID: <4F0EB204.406@pengutronix.de>
References: <4F0DB66F.50509@hartkopp.net> <4F0DBF90.5050906@pengutronix.de> <4F0DC8BC.4040704@hartkopp.net> <20120112082536.GA380@e-circ.dyndns.org> <20120112090217.GB380@e-circ.dyndns.org> <4F0EA442.8080303@pengutronix.de> <20120112093009.GC380@e-circ.dyndns.org> <4F0EA90C.2050109@pengutronix.de> <20120112100137.GE380@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE36CAE4E3032635EFEF22936"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34945 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab2ALKMZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Jan 2012 05:12:25 -0500
In-Reply-To: <20120112100137.GE380@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE36CAE4E3032635EFEF22936
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2012 11:01 AM, Kurt Van Dijck wrote:
> On Thu, Jan 12, 2012 at 10:34:04AM +0100, Marc Kleine-Budde wrote:
>> On 01/12/2012 10:30 AM, Kurt Van Dijck wrote:
>>>>> The 5.01 package states the binary blob (and their code) is GPLv2.
>>>>> The remainders of the 4.6 package I still have (only the firmware p=
art) also
>>>>> state it's all released under GPLv2.
>>>>
>>>> Do you mean the binary blob's source code is available as GPLv2? Do =
we
>>>> have access to the source code? Would be interesting for the Debian =
Kernel.
>>> Softing releases a linux driver package, with linux driver code and f=
irmware
>>> under GPLv2. The firmware is packaged as array's in c files.
>>> The sources of the firmware itself are not available.
>>
>> IANAL, some people think that a binary firmwarer w/o source code
>> available under GPLv2 isn't GPv2.
> I _think_ the Debian goal is to have a Free system.=20
> Firmware under GPLv2 without source, IMHO, _is_ GPLv2, but not Free.

My opinion is: There is no GPLv2 without source :)
The driver is GPLv2, but the firmware isn't. But I don't mind using the
driver. I just wanted to point out that it's probably not included in
debian's standard kernel.

>> However, we can document that in the WHENCE file of the linux firmware=

>> reporitory.
> I think we can distribute the files, as long as we mention the source
> (=3DSofting) to comply with the GPLv2.

I think we should add the firmware to the linux firmware archive and
document its origin.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE36CAE4E3032635EFEF22936
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8OsgYACgkQjTAFq1RaXHPAWwCeIBS7W4/WUY6DXSlztgmfQS9/
pMgAoIzXBq1skIULLBXscwWJ6ufzeQNn
=Wrpp
-----END PGP SIGNATURE-----

--------------enigE36CAE4E3032635EFEF22936--
