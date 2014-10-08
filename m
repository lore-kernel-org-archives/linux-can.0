From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Wed, 08 Oct 2014 11:56:04 +0200
Message-ID: <54350A34.1020402@pengutronix.de>
References: <1411995175-13540-1-git-send-email-david@protonic.nl>	<4712537.n1vM034J9B@ws-stein>	<20141001110741.0e8e5ffb@archvile>	<5856354.jaFqUxgnZF@ws-stein>	<20141001113432.18ec8bed@archvile>	<542BD038.2070106@pengutronix.de>	<20141006092825.765bd50d@archvile>	<54326823.7030000@pengutronix.de> <20141008110839.489a786d@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wI9qfhVrRui5oP3cqgeIcKPJF7V3WPanK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43578 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015AbaJHJ4M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 Oct 2014 05:56:12 -0400
In-Reply-To: <20141008110839.489a786d@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wI9qfhVrRui5oP3cqgeIcKPJF7V3WPanK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/08/2014 11:08 AM, David Jander wrote:
>=20
> Dear Marc,
>=20
> On Mon, 06 Oct 2014 12:00:03 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 10/06/2014 09:28 AM, David Jander wrote:
>>>>> 2.- Since the problem addressed by my patch to at91_can is very sim=
ilar,
>>>>> what about solving these problems in the SocketCAN framework (if th=
at is
>>>>> possible)?
>>>>
>>>> Have you had a look at my rx-fifo branch in
>>>> https://gitorious.org/linux-can/linux-can-next? It already tries to
>>>> abstract the simulation of the FIFO with the linear mailboxes.
>>>
>>> Looks interesting. I think it is a good idea to do this in dev.c, sin=
ce
>>> there are obviously more CAN drivers that can use this. Unfortunately=
 it
>>> seems you are still pretending the napi-poll handler to call
>>> can_rx_fifo_poll(). Wouldn't it be better to just empty all MBs into =
a
>>> circular buffer or kfifo from the interrupt handler instead?
>>
>> Yes probably, I started the rx-fifo patch before you came up with that=
 idea.
>>
>>> I still don't understand the results Alexander is getting, though....=

>>>
>>> What are you going to do with the rx-fifo work? Do you recommend to b=
ase my
>>> patch on that? In that case, calling can_rx_fifo_poll() from the inte=
rrupt
>>> handler will look a little awkward... but it should work. Or should I=

>>> propose an extension to rx-fifo?
>>
>> My plans, or rather the points that need to be addressed for the rx-fi=
fo
>> are:
>> - improve to work with more than 32 mailboxes. 64 are probably enough
>>   for everybody :)
>> - make it work with the flexcan linear buffers
>> - make it work with the ti_hecc driver
>> - add option or convert to run from interrupt handler and copy to
>>   kfifo/cyclic buffer/...
>=20
> Can you lend you brain for a sec on this problem... I think I discovere=
d a
> race condition in your rx-fifo code, but it might just be me not unders=
tanding
> it correctly....
>=20
> 	do {
> 		pending =3D fifo->read_pending(fifo);
> 		pending &=3D fifo->active;
>=20
> 		if (!(pending & BIT_ULL(fifo->next))) {
> 			/*
> 			 * Wrap around only if:
> 			 * - we are in the upper group and
> 			 * - there is a CAN frame in the first mailbox
> 			 *   of the lower group.
> 			 */
> 			if (can_rx_fifo_ge(fifo, fifo->next, fifo->high_first) &&
> 			    (pending & BIT_ULL(fifo->low_first))) {
> 				fifo->next =3D fifo->low_first;
> 				fifo->active |=3D fifo->mask_high;
> 				fifo->mailbox_enable_mask(fifo, fifo->mask_high);
> 			} else {
> 				break;
> 			}
> 		}
>=20
> In this piece of code, suppose that fifo->next is in the upper half and=
 a
> message is being written to the MB it is pointing at, but it is still n=
ot
> pending. The lower half has already been enabled and filled up complete=
ly (due
> to latency). In that case, fifo-next will jump back to fifo->low_first =
and
> leave a lonely filled MB in the middle of the upper half, that will tri=
gger
> and infinite loop between IRQ and can_rx_fifo_poll(). The interrupt wil=
l never
> get cleared again.
> I know this is an extreme case of latency being so high as to fill more=
 than
> the complete lower half, but if it strikes, it results in a lock-up. Am=
 I
> right, or did I screw up somewhere?

Correct analysis :( At least it shows it makes sense to have this code
in a central place.....

If we handle the low_first mailbox, we might have to check if the "old"
next, or better, if any of the mailboxes >=3D old_next are pending *and*
there is a non pending mailbox < "old" next. This should be possible
with one or two clever bitmasks.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--wI9qfhVrRui5oP3cqgeIcKPJF7V3WPanK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQ1CjQACgkQjTAFq1RaXHPL8QCffMQbdyZQDi7U51AzL34CrOsF
ptwAoIUuDmO9FS71d7yU9Wx+BWabxCb7
=uBeX
-----END PGP SIGNATURE-----

--wI9qfhVrRui5oP3cqgeIcKPJF7V3WPanK--
