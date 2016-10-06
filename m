From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Thu, 6 Oct 2016 09:26:00 +0200
Message-ID: <5fb6231c-4461-2be7-bd47-530aa62c121f@pengutronix.de>
References: <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <20161004164725.08802a61@erd980>
 <20161004173129.GB25008@airbook.vandijck-laurijssen.be>
 <8f5ebcf8-8bb6-a9f0-33af-47d4a551e811@pengutronix.de>
 <20161004184036.GD25008@airbook.vandijck-laurijssen.be>
 <48bf45a3-b724-a546-62ee-31a27dc3db33@pengutronix.de>
 <20161005180205.GE25008@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bXIVBbqhAQsswxmRR8CcpOcemWeUxlh2m"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59352 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750868AbcJFH0N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 03:26:13 -0400
In-Reply-To: <20161005180205.GE25008@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bXIVBbqhAQsswxmRR8CcpOcemWeUxlh2m
Content-Type: multipart/mixed; boundary="nRm8CjiKOSPHUWTLsuv5EPXvigFInqjXi";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <5fb6231c-4461-2be7-bd47-530aa62c121f@pengutronix.de>
Subject: Re: j1939
References: <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <20161004164725.08802a61@erd980>
 <20161004173129.GB25008@airbook.vandijck-laurijssen.be>
 <8f5ebcf8-8bb6-a9f0-33af-47d4a551e811@pengutronix.de>
 <20161004184036.GD25008@airbook.vandijck-laurijssen.be>
 <48bf45a3-b724-a546-62ee-31a27dc3db33@pengutronix.de>
 <20161005180205.GE25008@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161005180205.GE25008@airbook.vandijck-laurijssen.be>

--nRm8CjiKOSPHUWTLsuv5EPXvigFInqjXi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/05/2016 08:02 PM, Kurt Van Dijck wrote:
>> On 10/04/2016 08:40 PM, Kurt Van Dijck wrote:
>>>>> I think we agree on what must be possible, we may just differ on th=
e
>>>>> defaults and how to set things.
>>>>
>>>> It seems, or rather what I'd like to see is that we want most things=
 to
>>>> be per socket option. All module parameters should go away. The defa=
ult
>>>> for transport_max_size might be a system wide value, similar to
>>>> /proc/sys/net/core/rmem_max.
>>>
>>> do you propose to add /proc files?
>=20
>> No - However I'm not sure yet, though.
> In that case, I didn't understand your point :-(

The rmem_max and rmem_default and their wmem friends define both a
system wide default and a maximum for the read and write buffer of
sockets. And there are two sockopts to change the default up to the
maximum value that correspondes to the _max value. Where to put this
value is another question. As it's a system wide setting /proc might be
a sensible place.

>>> I'm willing to replace module parameters with /proc files, but I don'=
t
>>> see the real advantage yet. And module parameters were quicker :-)
>>
>> When trying to bring new code into the kernel, this is probably not th=
e
>> best argument :)
>=20
> Well, in my experience, the infrastructures are built so that
> easy-to-read code do the right thing in the right way.
> In that regard, I suspect module parameters may be the preferred way?

Some weeks ago Grek turned down a patch, as it introduced new module
parameters and said quite clearly no new module parameters.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nRm8CjiKOSPHUWTLsuv5EPXvigFInqjXi--

--bXIVBbqhAQsswxmRR8CcpOcemWeUxlh2m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX9fyKAAoJED07qiWsqSVq0iMH/iP+UQh0kfjWbDkedW+MOnPG
NvbXyXcIJTxz+2Bzps6V2/B7xvyCxEVm2R5PstgRfxhGkvkcsycJXafn2uPlNbJB
/Z2n6+rA5tg71oAQevl0ueS4WF7RgpMai5FNFfJZt42INFiCDDreDE0ZzNsczYrA
LW7eK60P7GC2/npFSpwRYNproR4tCozYkYVqRxPnmPSpDX+VSQwh8HGtv5otpkAO
y3MN87eprbonRiF8WAf0ezwumyX105W4zn74/GUnb4gNuws0jbEZqGi5ZjsUKcFo
HEOCCdLI0QtxneWaE9Lq4Vo8XFR5NjIgyefNuIoIs6xYzFT9CbFMPkgYXZBRP0U=
=5Bnl
-----END PGP SIGNATURE-----

--bXIVBbqhAQsswxmRR8CcpOcemWeUxlh2m--
