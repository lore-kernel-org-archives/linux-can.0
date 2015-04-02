From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Thu, 02 Apr 2015 08:46:33 +0200
Message-ID: <551CE5C9.6020600@pengutronix.de>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>	<55187FF1.7020701@optusnet.com.au>	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>	<5519E5A9.7080104@optusnet.com.au>	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>	<551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com> <551C7D79.50906@optusnet.com.au> <loom.20150402T022922-646@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="t7jcoagA5Q7FbPEfnadlHrN1tJrmU9RNx"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48317 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbDBGqk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Apr 2015 02:46:40 -0400
In-Reply-To: <loom.20150402T022922-646@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Egnor <dan.egnor@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t7jcoagA5Q7FbPEfnadlHrN1tJrmU9RNx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/02/2015 02:33 AM, Dan Egnor wrote:
> That seems surprisingly awful for something that's an established gener=
ic=20
> interface for all CAN hardware on this operating system! No matter how =
many=20
> mailboxes the controller might support, the operating system simply doe=
s not=20
> support prioritized transmission.

You have access to all queueing disc in linux, to prioritize your CAN
frames until they are send via the CAN driver into the hardware. This is
currently done in all drivers via a single TX queue. In default
configuration (without a special queueing discipline), you have multiple
FIFO from the userspace (the sockets) that are combined into a single
FIFO (queueing disc + TX routine in driver +  hardward).

However, if you need more control, fist make use of a queueing disc.
Then, if you still suffer from prio inversion, we can have a look at
your hardware. For now, all drivers, even those with multiple TX
buffers, configure them into one large TX-FIFO. We can define and
implement a new per interface option (or options, if needed) that
switches the hardware between FIFO and priority based sending. This
however is still a problem, if all your HW buffers are filled with low
prio CAN frames before a high prio one has the change to be transferred
into the hardware. This leads us to the implementation of multiple TX
queues from the linux stack into the driver. This is manly used on big
server Ethernet card, so that more than one processor can send packages.
We have to check if a) we can attach a queueing disc to a TX queue and
b) if these multiple TX queues are properly used on a single processor
system.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--t7jcoagA5Q7FbPEfnadlHrN1tJrmU9RNx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVHOXNAAoJECte4hHFiupUliYP/j7xa1f3tggfcBMDuqQcsG85
Vjki7IL9hYlWXqFMgtuJgRj0Q2G9eDXjO3XnVPbXPua2KCDXKgGohJBIbL8E4V8a
kZJ9KL8vZgwGNQOHEYWlBU+m9V3tqik6RoEvKQqPtpT4K6q/Gq1cAb+6em+SPoD2
lqdTRWs3TC+QUdTONL4GQZne6ouHsF3cNL8MaAG0ZQBxD9e0fTzCDJ8x9uXdBSuT
qecW22txysrjGJtFyRXMAC/cYgRANel4DoLhzZGmDptYEAxD+B75bJYKupw3mpLh
9UdbSbF5RB+ZraCzUYXp4EBQFgVITUHUFGpqFUJHfFP9MESXKfxXzJVIiBNWmwxT
7OXPLYIHPS+bQF4dC92YqW5nIckrxum8xU7iv+e1BBwnr4xeg5MVmHg13q/sjQdK
zWeWJfa192tsjYvvX0la4s0DTAY8TynHGR8t6mqLfvtJN0aIYhYX61GNhvBSe0qM
UReB1b60M8bacTOti9EAh1yJTrTUHd/VSv2JUaxk0sea9INVPtd6+AHNPFXRvU9x
fV/u6lcUCJi37AUAKnp1duXH4ZyQe7a8DT+Qe/Drz02iITovztJfojmCYrJOuSLZ
1dvZFLfxY1gZ0M8MnE6e34JXJXLGwJT15B8NwdItfgPn5niVUBrXZ7UmKAVjXhXj
fRNQ6y24LensTCe5ccgZ
=g3yb
-----END PGP SIGNATURE-----

--t7jcoagA5Q7FbPEfnadlHrN1tJrmU9RNx--
