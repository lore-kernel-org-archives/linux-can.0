From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Thu, 6 Oct 2016 14:13:10 +0200
Message-ID: <03b3bac9-b8c4-72ea-cc1d-9bf8f0210e3b@pengutronix.de>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
 <a6920929-30e0-0c69-52f1-96998698bbf6@pengutronix.de>
 <20161006092403.GA26915@airbook.vandijck-laurijssen.be>
 <9472847f-aa01-f4b0-f2cc-968a04c6ce06@pengutronix.de>
 <20161006102643.GB26915@airbook.vandijck-laurijssen.be>
 <7a910650-0d91-e98c-8694-2d8b32ae68a7@pengutronix.de>
 <20161006111347.GC26915@airbook.vandijck-laurijssen.be>
 <20161006113244.GD26915@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BgMipg7jmecWuFLut4oljwJK6hb7S58LD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37594 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751779AbcJFMNT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 08:13:19 -0400
In-Reply-To: <20161006113244.GD26915@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BgMipg7jmecWuFLut4oljwJK6hb7S58LD
Content-Type: multipart/mixed; boundary="51icrpxrS9OV7jpUVjOvXv9GDmv0j0Bxr";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>
Message-ID: <03b3bac9-b8c4-72ea-cc1d-9bf8f0210e3b@pengutronix.de>
Subject: Re: j1939
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
 <a6920929-30e0-0c69-52f1-96998698bbf6@pengutronix.de>
 <20161006092403.GA26915@airbook.vandijck-laurijssen.be>
 <9472847f-aa01-f4b0-f2cc-968a04c6ce06@pengutronix.de>
 <20161006102643.GB26915@airbook.vandijck-laurijssen.be>
 <7a910650-0d91-e98c-8694-2d8b32ae68a7@pengutronix.de>
 <20161006111347.GC26915@airbook.vandijck-laurijssen.be>
 <20161006113244.GD26915@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161006113244.GD26915@airbook.vandijck-laurijssen.be>

--51icrpxrS9OV7jpUVjOvXv9GDmv0j0Bxr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2016 01:32 PM, Kurt Van Dijck wrote:
>>>>>>
>>>>>> 1) I'll try to move module parameters to /proc/sys/net/can-j1939/ =
items.
>>>>
>>>> I'm done.
>>>> I fixed the Makefile so it can compile can-j1939 as module again :-)=

>>>> I changed the defaults to strict j1939 compliant (way-to-large max
>>>> 	packet size, padding).
>>>> And I migrated the module parameters to /proc/sys/net/can-j1939.
>>>> I loaded the module, and verified /proc, without any real wire tests=
=2E
>>>>
>>>> So you need to cherry-pick another 3 commits.
>>>
>>> Tnx. Does it compile with disabled PROC support?
>>
>> Yes, it just compiled (the module), not sure how it reacts when actual=
ly
>> used like that.
>> I just think I forgot to add descriptions in Documentation/sysctl.
>=20
> I added yet another commit, that add documentation of the new sysctl's.=


Thanks - Cherry-picked and added two incremental patches on my branch.

Marc.

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--51icrpxrS9OV7jpUVjOvXv9GDmv0j0Bxr--

--BgMipg7jmecWuFLut4oljwJK6hb7S58LD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX9j/WAAoJED07qiWsqSVqdk8H/jQrpnhreexX6jyUOw4oHEPQ
FgYNeprFefWPWfL57/eYZpVouuuBY/9gDyRi568GeoV72X25AfjPUUAKjNs/45l4
+hQuadg4hZ5H3oLw+Cde6v++uqmMzmHZpSmroYO8+qovChmo17P7E5sos0GsjrYu
d3EoyDK4dpiFioexPpfSkDo8k7l3uJsB9tvv3KD0V2wvvN3Igr3/XSpW4tvm4paS
JYxCL8G3zcIIRkzvij4wRl0xj9A3P3Qhw+bqeBHAm2+FiEVH5RfRgsh1K855DGjK
jp0NWvH6cg1lh+EYc0RnSmYmZusVQZ/5uH+/8TLAKyhd00x82PomOLJ57/lct90=
=HZe0
-----END PGP SIGNATURE-----

--BgMipg7jmecWuFLut4oljwJK6hb7S58LD--
