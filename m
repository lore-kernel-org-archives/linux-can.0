From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [iproute2 1/2] Update CAN netlink header
Date: Tue, 22 Jul 2014 16:23:29 +0200
Message-ID: <53CE73E1.7060301@pengutronix.de>
References: <1405935800-26622-1-git-send-email-nebaruzdin@gmail.com>	 <1405935800-26622-2-git-send-email-nebaruzdin@gmail.com>	 <53CD532F.90905@hartkopp.net> <1406038184.9500.2.camel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AB4f2psGpAoKi6snlNiuTqgHX2KlUeaSd"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52742 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbaGVOXg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jul 2014 10:23:36 -0400
In-Reply-To: <1406038184.9500.2.camel@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AB4f2psGpAoKi6snlNiuTqgHX2KlUeaSd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/22/2014 04:09 PM, Nikita Edward Baruzdin wrote:
> On Mon, 2014-07-21 at 19:51 +0200, Oliver Hartkopp wrote:
>> Hello Nikita,
>>
>> On 21.07.2014 11:43, Nikita Edward Baruzdin wrote:
>>> Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
>>> ---
>>>  include/linux/can/netlink.h | 12 ++++++++----
>>
>>
>>>   * CAN device statistics
>>> @@ -122,9 +124,11 @@ enum {
>>>  	IFLA_CAN_RESTART_MS,
>>>  	IFLA_CAN_RESTART,
>>>  	IFLA_CAN_BERR_COUNTER,
>>> +	IFLA_CAN_DATA_BITTIMING,
>>> +	IFLA_CAN_DATA_BITTIMING_CONST,
>>>  	__IFLA_CAN_MAX
>>>  };
>>
>> This change has already been applied to the iproute2 git repository fr=
om
>> Stephen Hemminger:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/
>>
>> See:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/di=
ff/include/linux/can/netlink.h?id=3De4d5edba68970124c5ce245a11a5c5cd4dde9=
ae1
>>
>> The best is, to wait until Stephen has pulled the Linux headers into h=
is tree.
>> This will usually happen when the merge window for the Kernel 3.17(!) =
is
>> closed - e.g. in 4-6 weeks from now.
>>
>> After the kernel header update in the iproute2 git repository it makes=
 sense
>> to post your patch 2/2 as
>>
>> 	iproute2: add support for CAN presume-ack feature
>>
>> and send this simultaneously on linux-can and linux-netdev ML.
>>
>> So let's wait for Stephen updating his iproute2 tree ...
>>
>> Thanks,
>> Oliver
>>
>=20
> Got it, I was looking at linux-can/iproute2 tree.
>=20
> And what about libsocketcan patches?

I've just applied them to libsocketcan master.

Thnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AB4f2psGpAoKi6snlNiuTqgHX2KlUeaSd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPOc+EACgkQjTAFq1RaXHPHMgCfV8H2AdeD5/kSLo+tF++8/Y91
8VsAoI9Xz+Gk2owCLBWjIvEOIlml6Co2
=ts7E
-----END PGP SIGNATURE-----

--AB4f2psGpAoKi6snlNiuTqgHX2KlUeaSd--
