From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add PM support
Date: Tue, 08 May 2012 20:34:56 +0200
Message-ID: <4FA96750.6020206@pengutronix.de>
References: <1336489937-29645-1-git-send-email-eric@eukrea.com> <4FA9394A.90303@pengutronix.de> <20120508173001.31ce8f0c@eb-e6520> <4FA93FC1.7030808@pengutronix.de> <20120508191459.703c4369@eb-e6520> <4FA95A17.8090406@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig24E25AF9BC5E74081A1FB576"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56466 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab2EHSfO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 May 2012 14:35:14 -0400
In-Reply-To: <4FA95A17.8090406@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig24E25AF9BC5E74081A1FB576
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/08/2012 07:38 PM, Oliver Hartkopp wrote:
> On 08.05.2012 19:14, Eric B=E9nard wrote:
>=20
>> Le Tue, 08 May 2012 17:46:09 +0200,
>> Marc Kleine-Budde <mkl@pengutronix.de> a =E9crit :
>>
>>> On 05/08/2012 05:30 PM, Eric B=E9nard wrote:
>>>> Hi Marc,
>>>>
>>>> Le Tue, 08 May 2012 17:18:34 +0200,
>>>> Marc Kleine-Budde <mkl@pengutronix.de> a =E9crit :
>>>>
>>>>> On 05/08/2012 05:12 PM, Eric B=E9nard wrote:
>>>>>> tested on an i.MX257
>>>>>
>>>>> What about the transceiver? Does is make sense to switch it off, to=
o?
>>>>>
>>>> this could make sense on platform which have a transceiver with an
>>>> enable input. I can add flexcan_transceiver_switch after/before
>>>> flexcan_chip_disable/enable but won't be able to test that feature.
>>>
>>> I looked at two ethernet drivers: ethernet/intel/ixgbe/ixgbe_main.c a=
nd
>>> ethernet/intel/ixgbe/ixgbe_main.c and AFAICS they basically do the sa=
me
>>> as in open/close. (btw: the flexcan driver switches the transceiver
>>> on/off on open/close.) I haven't implemented any network driver pm ye=
t,
>>> but what is a driver supposed to do in suspend/resume?
>>>
>> concerning the transceiver : that depends if you need to resume when
>> receiving a message on the CAN bus in which case you can't disable the=

>> transceiver (btw, I have an other patch which enable wakeup when
>> receiving a message on the CAN bus, but I need to clean and test it
>> again).
>=20
>=20
> I wonder if you mix up the enabling/disabling of the CAN transceiver (t=
rx)
> with the entire system power management.
>=20
> E.g. if you take the TJA1054A as an example, you can switch the trx int=
o a
> mode that switches off the power supply (INH-line) in order to wake up =
with a
> received CAN frame, which switches on the power supply and boots the sy=
stem.
>=20
> Even if you don't switch the power supply with the INH pin the trx wake=
s up
> with CAN traffic in this mode.
>=20
> To me switching the trx modes only makes sense to implement system powe=
r
> management states. IMO there's no need to switch them when setting the
> interface to up/down state. Or did i miss anything?

In the current implementation you can register a callback via
platform_data to enable/disable the transceiver. It's up to the board to
do something useful with it.

I think for now I'll take Eric's patch as it is, until we've implemented
something more complicated to support automotive style transceivers :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig24E25AF9BC5E74081A1FB576
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+pZ1YACgkQjTAFq1RaXHP4GACfU/uENnDLfD4X05KuJEIXXSBF
lyoAn0TG4Ej8plEGcX1tLoLkDICSV222
=eFR9
-----END PGP SIGNATURE-----

--------------enig24E25AF9BC5E74081A1FB576--
