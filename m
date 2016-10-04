From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Tue, 4 Oct 2016 19:51:42 +0200
Message-ID: <8f5ebcf8-8bb6-a9f0-33af-47d4a551e811@pengutronix.de>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <20161004164725.08802a61@erd980>
 <20161004173129.GB25008@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hrsu77OPXlbMjMo9aQRn6DuOMiwTaPDCE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48172 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751146AbcJDRvv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 13:51:51 -0400
In-Reply-To: <20161004173129.GB25008@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hrsu77OPXlbMjMo9aQRn6DuOMiwTaPDCE
Content-Type: multipart/mixed; boundary="xQFMH7dPs296bOlAq41wnwme8HEgwsblP";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <8f5ebcf8-8bb6-a9f0-33af-47d4a551e811@pengutronix.de>
Subject: Re: j1939
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <20161004164725.08802a61@erd980>
 <20161004173129.GB25008@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161004173129.GB25008@airbook.vandijck-laurijssen.be>

--xQFMH7dPs296bOlAq41wnwme8HEgwsblP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2016 07:31 PM, Kurt Van Dijck wrote:
>>
>>> But often, especially for proprietary messages, not all 8 bytes are
>>> used, and the DLC is cut accordingly.
>>> And less often, this is done for TP too.
>>> I also did that for as long as I can remember.
>>> As long as all defined bytes are there, this should not really be a
>>> problem.
>>>
>>> Recently, someone on this list was confronted with an engine ECU that=

>>> dropped TP that had the last packet not 8 bytes long.
>>> And I believe I've encountered an issue a long time ago where this
>>> happened on all PGNs.
>>> So I introduced this option, having 3 possibilities:
>>> * no padding
>>> * padding for TP
>>> * padding for all PGN.
>>
>> I have yet to check, but I fear that in ISOBus conformance tests on so=
me
>> places at least this is tested for. I'd say that if the standard says =
"pad and
>> fill with 0xff", any ECU should do this and not doing it should be reg=
arded as
>> a bug...=20
>=20
> I (EIA Electronics) got a certified ISOBus Terminal with this code, bac=
k
> in 2011, with this code (well, the code back then). I cannot remember
> that I needed to pad TP.
> The networking layer was the easy part in Potsdam, the layers above wer=
e
> more difficult :-)
>=20
> Things may have become more strict in between.
> And we should be prepared for the strict setting.
> On the other hand, during debugging, not padding helps identifying the
> real data, and this has been valueable too for me.
>=20
> I think we agree on what must be possible, we may just differ on the
> defaults and how to set things.

It seems, or rather what I'd like to see is that we want most things to
be per socket option. All module parameters should go away. The default
for transport_max_size might be a system wide value, similar to
/proc/sys/net/core/rmem_max.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xQFMH7dPs296bOlAq41wnwme8HEgwsblP--

--hrsu77OPXlbMjMo9aQRn6DuOMiwTaPDCE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX8+wuAAoJED07qiWsqSVq5T8H/0ctG9Bf5YMsLc6IKokGi04b
GxIYiZqwuaDVuj+P/9GR53fQ/weiVYnqIj546EZQ2e5J2CGaQJi7Q0jCbmBLHZeH
YOn/o/ElFDXL8+XbEH5Co3ZsUMouLxDY2QNy1DfLvfMFyw1mYQatrZ0jYUozKyW2
J8VP7uyRfQfk4b0/eWBorhrzcQGnuFeKA4hJ1b6MuEDYj08AjHsB5udR1W8L0YKx
clKI57IszUnZhKpQvLXbxVKUKVwXQ70xqWTmnqByXD6YrdHCfVxwY+O1wgeiP/bL
Rqp3NljK9Fj7yeP7f3WFz/wy7GEWf0X0OUxLTavRO599z7/oonjYQuZWWhc4WZY=
=oDOx
-----END PGP SIGNATURE-----

--hrsu77OPXlbMjMo9aQRn6DuOMiwTaPDCE--
