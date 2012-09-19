From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Wed, 19 Sep 2012 09:47:46 +0200
Message-ID: <505978A2.5010609@pengutronix.de>
References: <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <50586DE4.9020707@grandegger.com> <50587058.7090703@pengutronix.de> <50587987.3070308@grandegger.com> <50587A4F.5060105@pengutronix.de> <5058C28A.5030300@grandegger.com> <5058C505.6020605@pengutronix.de> <5058C7EC.1080206@grandegger.com> <20120918202018.GA78585@macbook.local> <50595B4A.10409@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0EC6A0A92D81593A9F2DF6C8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37392 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab2ISHrx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Sep 2012 03:47:53 -0400
In-Reply-To: <50595B4A.10409@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, =?UTF-8?B?SGVpbnotSsO8cmdlbiA=?= =?UTF-8?B?T2VydGVs?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Kurt Van Dijck <kurt.van.dijck@eia.be>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0EC6A0A92D81593A9F2DF6C8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2012 07:42 AM, Oliver Hartkopp wrote:
[...]

>>>>>>> What do people really want/need and why? This is still not clear =
to me.
>>>>>>> More input would be nice.
>>>>>>
>>>>>> Heinz-J=C3=BCrgen uses abort current TX Message on SJA1000, can yo=
u give us
>>>>>> more insight? I've talked to customers, e.g. they want to abort th=
e
>>>>>> current frame if it takes "too long" to send it, because the frame=
s CAN
>>>>>> id priority is too low.
>>
>> If "too long" is defined as a period of time where it makes sense to
>> take such actions in software (like > 10msec), and your message still
>> did not get out, but you wanted it to be,
>> then IMO the bus load is too high with regard to the expected time res=
trictions.
>>
>> Or am I missing something?

I was just describing the use case for a "abort-current-tx" command. The
it takes "too long" and then abort will be implemented in the userspace.
But without a "abort-current-tx" command this is not possible. It was
not my intention to propose to implement an automatic abort if message
is too old in the kernel as a framework option.

> The question is, if we should add some time of expiry to the tx-skb?!?

No, see above.

> I have not checked whether the new ematch queuing discipline
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dcomm=
itdiff;h=3Df057bbb6f9ed0fb61ea11105c9ef0ed5ac1a354d
>=20
> http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf
>=20
> would allow already to sort out expired skbs.
>=20
> This is probably the preferred solution instead of checking expired skb=
s
> inside the driver.

I don't want to check for expired frames in the driver.

>>>>> What we could implement rather easily is a "tx-abort-last" or
>>>>> "tx-abort-all" netlink command. As this command does not make sense=
 when
>>>>> more than one message is pending I'm in favor of "tx-abort-last".
>>>>
>>>> I like to have both commands.
>>>
>>> But then "tx-abort-all" should also clear the tx socket queue. Also b=
e
>>> aware that more than one socket may send messages. Let's wait for mor=
e
>>> use-cases.
>>
>> I'm afraid tx-abort-all & tx-abort-last cause more damage than good,
>> especially, but not only, in multi-user environments.
>=20
>=20
> These netlink commands are/can be restricted to be used by root only.
> Maybe for some special use-cases it makes sense to have them.
>=20
> When draining the tx queues from the driver side, all skbs are purged.
> I think this is not bound to a special socket instance then.
>=20
> Summarizing i would suggest to check the expiring possibility of skbs (=
which
> will kill out-dated CAN frames) - and only implement a tx-abort command=
 that
> kills the latest frame only.

You mean a "in-band" skb that kills out-dated CAN frames? No, no inband
magic, please.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig0EC6A0A92D81593A9F2DF6C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBZeKUACgkQjTAFq1RaXHNzxwCeJpuE0bN0/7/E5aj9W10dbIEp
0QAAnjUMphRoVClIQJGTthzUQ4G5R080
=ZOTG
-----END PGP SIGNATURE-----

--------------enig0EC6A0A92D81593A9F2DF6C8--
