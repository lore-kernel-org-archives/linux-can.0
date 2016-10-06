From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Thu, 6 Oct 2016 12:28:45 +0200
Message-ID: <7a910650-0d91-e98c-8694-2d8b32ae68a7@pengutronix.de>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
 <a6920929-30e0-0c69-52f1-96998698bbf6@pengutronix.de>
 <20161006092403.GA26915@airbook.vandijck-laurijssen.be>
 <9472847f-aa01-f4b0-f2cc-968a04c6ce06@pengutronix.de>
 <20161006102643.GB26915@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="odaFeOjnxLqeXs0SJjFxEgGeBm7Fk3Je6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47837 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755605AbcJFK2z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 06:28:55 -0400
In-Reply-To: <20161006102643.GB26915@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--odaFeOjnxLqeXs0SJjFxEgGeBm7Fk3Je6
Content-Type: multipart/mixed; boundary="8rRHQN9vrbuE6lVeRraoelmxEexulPSqN";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>,
 Kurt Van Dijck <kurt.van.dijck@eia.be>
Message-ID: <7a910650-0d91-e98c-8694-2d8b32ae68a7@pengutronix.de>
Subject: Re: j1939
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
 <a6920929-30e0-0c69-52f1-96998698bbf6@pengutronix.de>
 <20161006092403.GA26915@airbook.vandijck-laurijssen.be>
 <9472847f-aa01-f4b0-f2cc-968a04c6ce06@pengutronix.de>
 <20161006102643.GB26915@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161006102643.GB26915@airbook.vandijck-laurijssen.be>

--8rRHQN9vrbuE6lVeRraoelmxEexulPSqN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2016 12:26 PM, Kurt Van Dijck wrote:
>> On 10/06/2016 11:24 AM, Kurt Van Dijck wrote:
>>>>> * e2447ef: make TP data transmission work again
>>>>>   This commit fixes a mistake you've done with the fall-trough
>>>>>   statements in j1939tp_txnext (this isn't the easiest state machie=
n on
>>>>>   Earth :-) ).
>>>>
>>>> Thanks.
>>>>
>>>> I have cherry picked both and will push them to v4.7. If everything
>>>> works on the v4.7 branch, I'll squash most of it together an move to=
 v4.8.
>>>>
>>>> Thoughts?
>>>
>>> 1) I'll try to move module parameters to /proc/sys/net/can-j1939/ ite=
ms.
>=20
> I'm done.
> I fixed the Makefile so it can compile can-j1939 as module again :-)
> I changed the defaults to strict j1939 compliant (way-to-large max
> 	packet size, padding).
> And I migrated the module parameters to /proc/sys/net/can-j1939.
> I loaded the module, and verified /proc, without any real wire tests.
>=20
> So you need to cherry-pick another 3 commits.

Tnx. Does it compile with disabled PROC support?

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--8rRHQN9vrbuE6lVeRraoelmxEexulPSqN--

--odaFeOjnxLqeXs0SJjFxEgGeBm7Fk3Je6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX9ideAAoJED07qiWsqSVqkQoH/0YDitb1EPvH1ubAygpSBm7X
0/dyDcb7rtbiozK16/Rmp/Mc25PsZmMtJ0/NgNIESK0/ll7zcyK564lauQ02K7lo
AB19GvEtm0WnHaxWvxzBmDEOtYpu+QHwcaHOFEY6YGsRRxTs9H2fLT0Vbo6P9F1r
Wi3r+oo4wsYcl/ht1gzvPNjhQcycyFh0e8U0VzmUQMfBoR2bHMYL7E/MTG5Vib3K
NrbJZeiBkngx4DxWY48FY8zkRtndihLfo/EpqqqM7JDyhQ6+Sgvc51Hj22Mygoin
PknaPvXGAMqZijViFuD8219S6kOJA2AOc1+SR1Cn+mS6cugbINsKvH7NT1yfzdE=
=JZPX
-----END PGP SIGNATURE-----

--odaFeOjnxLqeXs0SJjFxEgGeBm7Fk3Je6--
