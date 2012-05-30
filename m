From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Wed, 30 May 2012 16:18:37 +0200
Message-ID: <4FC62C3D.2000107@pengutronix.de>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de> <jq52en$i2e$1@dough.gmane.org> <4FC60FA7.2000600@pengutronix.de> <jq53rt$uqu$1@dough.gmane.org> <4FC61545.2020504@pengutronix.de> <jq5530$ag8$1@dough.gmane.org> <4FC61E27.6040309@pengutronix.de> <jq5760$sur$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig11ECE646A7D0EA12CF8862C2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35021 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab2E3O00 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 May 2012 10:26:26 -0400
In-Reply-To: <jq5760$sur$1@dough.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig11ECE646A7D0EA12CF8862C2
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

On 05/30/2012 03:26 PM, Martin Kozusky wrote:
> Dne 30.5.2012 15:18, Marc Kleine-Budde napsal(a):
>> On 05/30/2012 02:50 PM, Martin Kozusky wrote:
>>>>> The best for me would be some kernel module which would just put
>>>>> the CAN
>>>>> frame into some big "from userspace available" buffer in the interr=
upt
>>>>> and nothing more. My app would check if there is anything new and r=
ead
>>>>> it out.
>>>>> There are around 1500/sec (at 250kbit) can frames on the bus when t=
he
>>>>> problem arise, I think it's not that much.
>>>>
>>>> Are you writing the can frames to storage in the same thread as
>>>> receiving them?
>>>
>>>
>>> No, CAN has it's own thread, which is just making struct from can
>>> messages (reading via select() )  and writes them into another buffer=
=2E
>>> Then the main thread reads this buffer and writes to SD card. Now I
>>> changed it so that this buffer is 30MB big, so I first store all the
>>> messages into RAM, and when I don't need to record CAN frames anymore=
, I
>>> write all of them to card from this big buffer.
>>> But this is just limited workaround because I'm limited with the RAM
>>> size (so I had to make the buffer cyclic and just latest xxxx message=
s
>>> are stored, older are overwritten when the buffer is full).
>>
>> Have you setup realtime priorities for you CAN thread?
> No, I did't set up any special attributes. Do you mean I should use
> pthread_attr_setschedpolicy(ptr,SCHED_RR) or something else?

or better SCHED_FIFO for your can thread.

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig11ECE646A7D0EA12CF8862C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/GLEEACgkQjTAFq1RaXHPkWACggTYzMyLtyAlaqTUc5+QqsjzM
9pkAn0WyilwjddwS4SNW9P8H7cc/Xmej
=iApL
-----END PGP SIGNATURE-----

--------------enig11ECE646A7D0EA12CF8862C2--
