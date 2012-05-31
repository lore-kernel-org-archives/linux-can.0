From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Thu, 31 May 2012 15:42:55 +0200
Message-ID: <4FC7755F.7020403@pengutronix.de>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de> <jq52en$i2e$1@dough.gmane.org> <4FC60FA7.2000600@pengutronix.de> <jq53rt$uqu$1@dough.gmane.org> <4FC61545.2020504@pengutronix.de> <jq5530$ag8$1@dough.gmane.org> <4FC61E27.6040309@pengutronix.de> <jq5760$sur$1@dough.gmane.org> <4FC62C3D.2000107@pengutronix.de> <jq7rnt$acc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig499E1F0EC7C5150F4852E1A7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44016 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758041Ab2EaNoG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 31 May 2012 09:44:06 -0400
In-Reply-To: <jq7rnt$acc$1@dough.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig499E1F0EC7C5150F4852E1A7
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

On 05/31/2012 03:29 PM, Martin Kozusky wrote:
> Dne 30.5.2012 16:18, Marc Kleine-Budde napsal(a):
>> On 05/30/2012 03:26 PM, Martin Kozusky wrote:
>>> Dne 30.5.2012 15:18, Marc Kleine-Budde napsal(a):
>>>> On 05/30/2012 02:50 PM, Martin Kozusky wrote:
>>>>>>> The best for me would be some kernel module which would just put
>>>>>>> the CAN
>>>>>>> frame into some big "from userspace available" buffer in the
>>>>>>> interrupt
>>>>>>> and nothing more. My app would check if there is anything new and=

>>>>>>> read
>>>>>>> it out.
>>>>>>> There are around 1500/sec (at 250kbit) can frames on the bus when=

>>>>>>> the
>>>>>>> problem arise, I think it's not that much.
>>>>>>
>>>>>> Are you writing the can frames to storage in the same thread as
>>>>>> receiving them?
>>>>>
>>>>>
>>>>> No, CAN has it's own thread, which is just making struct from can
>>>>> messages (reading via select() )  and writes them into another buff=
er.
>>>>> Then the main thread reads this buffer and writes to SD card. Now I=

>>>>> changed it so that this buffer is 30MB big, so I first store all th=
e
>>>>> messages into RAM, and when I don't need to record CAN frames
>>>>> anymore, I
>>>>> write all of them to card from this big buffer.
>>>>> But this is just limited workaround because I'm limited with the RA=
M
>>>>> size (so I had to make the buffer cyclic and just latest xxxx messa=
ges
>>>>> are stored, older are overwritten when the buffer is full).
>>>>
>>>> Have you setup realtime priorities for you CAN thread?
>>> No, I did't set up any special attributes. Do you mean I should use
>>> pthread_attr_setschedpolicy(ptr,SCHED_RR) or something else?
>>
>> or better SCHED_FIFO for your can thread.
> Hello Marc,
> I tried that and still when I write
> dd if=3D/dev/zero of=3D/mnt/mmcblk0p1/test bs=3D512 count=3D10000 (copy=
 5MB to
> SD card)  around 300 CAN frames (from 68500 frames) are lost :(

http://man7.org/linux/man-pages/man2/recvmmsg.2.html

Maybe you can use recvmmsg(). I don't know if it works already on can
sockets.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig499E1F0EC7C5150F4852E1A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/HdWUACgkQjTAFq1RaXHNcHQCfYxj7MiJbqZU/EZVmJLkeqvDi
HMwAn23pOvTmiz9hXh6ImGudh+Rdroav
=9SUr
-----END PGP SIGNATURE-----

--------------enig499E1F0EC7C5150F4852E1A7--
