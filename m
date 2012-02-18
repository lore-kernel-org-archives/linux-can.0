From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: sja1000 fix isr hang when hw is unplugged under
 load
Date: Sat, 18 Feb 2012 18:00:16 +0100
Message-ID: <4F3FD920.7000504@pengutronix.de>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de> <4F3BE2AC.9020108@hartkopp.net> <4F3EB82C.7080905@pengutronix.de> <4F3FB6AB.4030506@grandegger.com> <4F3FC514.4000307@hartkopp.net> <4F3FD56F.4070800@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB1C523EB8D752EE8DAB922AC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43433 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab2BRRAU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 18 Feb 2012 12:00:20 -0500
In-Reply-To: <4F3FD56F.4070800@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1C523EB8D752EE8DAB922AC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/18/2012 05:44 PM, Wolfgang Grandegger wrote:
> On 02/18/2012 04:34 PM, Oliver Hartkopp wrote:
>> On 18.02.2012 15:33, Wolfgang Grandegger wrote:
>>
>>> On 02/17/2012 09:27 PM, Marc Kleine-Budde wrote:
>>>> On 02/15/2012 05:51 PM, Oliver Hartkopp wrote:
>>>>> In the case of hotplug enabled devices (PCMCIA/PCIeC) the removal o=
f the
>>>>> hardware can cause an infinite loop in the common sja1000 isr.
>>>>>
>>>>> Use the already retrieved status register to indicate a possible ha=
rdware
>>>>> removal and double check by reading the mode register in sja1000_is=
_absent.
>>>>>
>>>>> v2: Create a new function to not print information in irq context.
>>>>>
>>>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>>
>>>> Thanks for the patch. I'm going to commit it to can-next. Any object=
ions?
>>>
>>> Sorry for the late response but what is this double check good for? A=
ll
>>> register reads will return 0xff if the card is unplugged. And if the
>>> double check is OK we will continue even we have realized a clear
>>> failure (status was 0xff).
>>
>>
>> Hi Wolfgang,
>>
>> i checked the SJA1000 spec. The status register can potentially hold t=
he value
>> 0xFF by specification. So even when it's not very likely that it holds=
 0xFF -
>> it can be. Additionally you may have SJA1000 FPGA cores that do not be=
have
>> exactly like the SJA1000 itself.
>>
>> To double check the unlikely case i do a read on the mode register, wh=
ich has
>> some bits definitely set to "0" which is a strong indication for the
>> controller removal.
>=20
> OK, no more objections. Hope to find some time soon to test my PCAN PCc=
ard.

Can I add your Acked-by to the patch?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB1C523EB8D752EE8DAB922AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8/2SIACgkQjTAFq1RaXHMKqACeIVXK3WSuWBPcRoMJsbQRQPdc
zM4An1/3QOH01x6yovzFPsi/aq5LUXnt
=kryh
-----END PGP SIGNATURE-----

--------------enigB1C523EB8D752EE8DAB922AC--
