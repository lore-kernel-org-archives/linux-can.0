From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Wed, 19 Sep 2012 09:39:29 +0200
Message-ID: <505976B1.6080900@pengutronix.de>
References: <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <50586DE4.9020707@grandegger.com> <50587058.7090703@pengutronix.de> <50587987.3070308@grandegger.com> <50587A4F.5060105@pengutronix.de> <5058C28A.5030300@grandegger.com> <5058C505.6020605@pengutronix.de> <5058C7EC.1080206@grandegger.com> <20120918202018.GA78585@macbook.local> <50596B50.901@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0508FB9295370CE8376814A6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51277 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829Ab2ISHjf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Sep 2012 03:39:35 -0400
In-Reply-To: <50596B50.901@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, =?ISO-8859-1?Q?Heinz-J=FCrg?= =?ISO-8859-1?Q?en_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0508FB9295370CE8376814A6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/19/2012 08:50 AM, Wolfgang Grandegger wrote:
> On 09/18/2012 10:20 PM, Kurt Van Dijck wrote:
>> On Tue, Sep 18, 2012 at 09:13:48PM +0200, Wolfgang Grandegger wrote:
>>> On 09/18/2012 09:01 PM, Marc Kleine-Budde wrote:
>>>> On 09/18/2012 08:50 PM, Wolfgang Grandegger wrote:
>>>>> On 09/18/2012 03:42 PM, Marc Kleine-Budde wrote:
>>>>>> On 09/18/2012 03:39 PM, Wolfgang Grandegger wrote:
>>>>>>> On 09/18/2012 03:00 PM, Marc Kleine-Budde wrote:
>>>>>>>> On 09/18/2012 02:49 PM, Wolfgang Grandegger wrote:
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>>> We have several customers who asked how to abort pending TX me=
ssages,
>>>>>>>>>> too. Which involves:
>>>>>>>>>> a) clear the TX-queue in Linux
>>>>>>>>>> b) clear queue in hardware
>>>>>>>>>> c) abort currently transmitting CAN frame
>>>>>>>>>>
>>>>>>>>>> I think c) would be a usecase of its own, too.
>>>>>>>>>
>>>>>>>>> I think you need c) for b), at least for some controllers. Thes=
e
>>>>>>>>
>>>>>>>> Yes, if it's a hardware limitation so be it. But if we design an=

>>>>>>>> interface it should support "clear everything" (a+b+c), but also=
 just
>>>>>>>> only c.
>>>>>>>
>>>>>>> Yes, that you be nice. The only portable "clear everything" (a+b+=
c) I
>>>>>>> see is "ifconfig down -> up". This also answers you other related=
 mail.
>>>>>>>
>>>>>>> What do people really want/need and why? This is still not clear =
to me.
>>>>>>> More input would be nice.
>>>>>>
>>>>>> Heinz-J=FCrgen uses abort current TX Message on SJA1000, can you g=
ive us
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
>>
>>>>>
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
> At least it's incompatible with multi-user (-sender) support and it doe=
s
> not fit into the Linux networking principles! And so far I have not
> heard strong arguments for implementing message flush and abort. I stil=
l
> believe that a device stop->restart is enough to cure such problems. Bu=
t
> let's wait and see.

Network stop->start does basically drain all buffers (software +
hardware + frame currently sending). Just remove the currently tx-ing
frame is a valid use case, and ifconfig down; ifconfig  up has some
drawbacks:
- a transceiver (if controlled by the driver) will be switched
  off and on.
- the clocks will be turned off and on
- there might be some "mdelay" or "msleep" loops during hw/sw reset

In case the hardware a clear hw fifo and abort current tx frame there
might be a much faster and cleaner way.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig0508FB9295370CE8376814A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBZdrUACgkQjTAFq1RaXHNovQCfZTKnUrVuysXC0YosNHGnBnUr
o6cAnROj0Yq+RB7qPTTn08wdON5FHOwt
=qU/w
-----END PGP SIGNATURE-----

--------------enig0508FB9295370CE8376814A6--
