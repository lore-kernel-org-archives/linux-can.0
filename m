From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Is there any way of getting the CAN interfaces list, from any
 C program?
Date: Thu, 25 Apr 2013 11:20:10 +0200
Message-ID: <5178F54A.1040407@pengutronix.de>
References: <5169B395.2070703@hartkopp.net> <516D2ABB.4000300@pengutronix.de> <5177A090.6010904@peak-system.com> <20130424144929.GA2077@vandijck-laurijssen.be> <5178D00C.70507@grandegger.com> <5178D638.1010303@pengutronix.de> <5178DCC7.9090002@pengutronix.de> <20130425091547.GE448@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2GNOGTQURQTLOSGBKAPDK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50132 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab3DYJUO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Apr 2013 05:20:14 -0400
In-Reply-To: <20130425091547.GE448@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2GNOGTQURQTLOSGBKAPDK
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/25/2013 11:15 AM, Kurt Van Dijck wrote:
> On Thu, Apr 25, 2013 at 09:35:35AM +0200, Marc Kleine-Budde wrote:
>> On 04/25/2013 09:07 AM, Marc Kleine-Budde wrote:
>>> On 04/25/2013 08:41 AM, Wolfgang Grandegger wrote:
>>>> Hi Kurt,
>>>>
>>>> On 04/24/2013 04:49 PM, Kurt Van Dijck wrote:
>>>>> Hi Stephane,
>>>>>
>>>>> I have written this some time ago, not using it actually.
>>>>> I tried a modular approach, don't know if its usefull.
>>>>>
>>>>> PS: I used attachments.
>>>>
>>>> ~/enumif$ ./enumif
>>>> 1: lo	{loopback} <LOOPBACK,UP,LOWER_UP> UNKNOWN
>>>> 2: eth0	{ether} <BROADCAST,MULTICAST> DOWN
>>>> 3: eth1	{ether} <BROADCAST,MULTICAST,UP,LOWER_UP> UNKNOWN
>>>> 4: eth3	{ether} <NO-CARRIER,BROADCAST,MULTICAST,UP> DOWN
>>>> 5: can0	{can} <NOARP,UP,LOWER_UP,ECHO> UNKNOWN
>>>> 6: can1	{can} <NOARP,ECHO> DOWN
>>>> 7: can2	{can} <NOARP,ECHO> DOWN
>>>> 8: can3	{can} <NOARP,ECHO> DOWN
>>>> 9: pan0	{ether} <BROADCAST,MULTICAST> DOWN
>>>>
>>>> Cool! We know that "ip link" does list all network interfaces but th=
e
>>>> code doing the job is not really strength-forward. I think this woul=
d be
>>>> a nice enhancement of the can-utils.
>>>
>>> Good idea, Stephane, can you license the code under a permissive lice=
nse
>>> like LGPL or BSD?
>>
>> Errr...sorry. It's Kurt, who posted that code.
>=20
>> Kurt, can you give the code a nice license? :)
> What is needed for LGPL or BSD?
> Is there a short overview available?

If the code is LGPL we can include it in the libsocketcan. You are
allowed to link the library against your closed source application
(without to license under GPL). Any changes you make to the library have
to be made available as source code.

IANAL,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2GNOGTQURQTLOSGBKAPDK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF49UoACgkQjTAFq1RaXHPHggCfe2wEBkBioPBeo4UtK4SFuGy5
ZLUAn16eQoYyxxu+zGzTTygwnScnliZw
=3z5X
-----END PGP SIGNATURE-----

------enig2GNOGTQURQTLOSGBKAPDK--
