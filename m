From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Signal Driven SocketCAN Questions
Date: Thu, 4 Jan 2018 11:45:21 +0100
Message-ID: <c726c87f-e03e-fb4a-9102-1cc86497d923@pengutronix.de>
References: <CAM=RW1JfAk93sfECLSC0Wq9B6XMJYwof8=s5xq92CMUjkGjoZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0QfkFvsjLZbIma9UqRQ9ClnyErpotvFrS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46183 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752597AbeADKpe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Jan 2018 05:45:34 -0500
In-Reply-To: <CAM=RW1JfAk93sfECLSC0Wq9B6XMJYwof8=s5xq92CMUjkGjoZQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yousof Ebneddin Hamidi <youebned@gmail.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0QfkFvsjLZbIma9UqRQ9ClnyErpotvFrS
Content-Type: multipart/mixed; boundary="1mxLNh4QP6UEcsfsvld1ieA0aZ5mND4Bm";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Yousof Ebneddin Hamidi <youebned@gmail.com>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <c726c87f-e03e-fb4a-9102-1cc86497d923@pengutronix.de>
Subject: Re: Signal Driven SocketCAN Questions
References: <CAM=RW1JfAk93sfECLSC0Wq9B6XMJYwof8=s5xq92CMUjkGjoZQ@mail.gmail.com>
In-Reply-To: <CAM=RW1JfAk93sfECLSC0Wq9B6XMJYwof8=s5xq92CMUjkGjoZQ@mail.gmail.com>

--1mxLNh4QP6UEcsfsvld1ieA0aZ5mND4Bm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01/04/2018 10:48 AM, Yousof Ebneddin Hamidi wrote:
> I am trying to write a Signal Driven SocketCan with ROS in Ubuntu.
> I have two problems:

Uhh, better not use signals in Linux, better wait with a
select/poll/epoll or use an abstraction library like libevent, libev or
libuv.

> 1- I do not get a signal for each arrival message. Or maybe the
> process of the signal takes too much time that I miss some signals

ok

> 2- To solve the above problem I am reading the buffer until it is
> empty at each SIGIO. Therefore I guarantee that I read all the CAN
> messages and their timestamp. The new problem emerges now. The order
> of the read messages are not the same as the arrival order anymore and
> there will be some errors in the order every few read operation.
> Interestingly they have the correct timestamp.

Which hardware are you using?

> on the image with the link below, the right side is the output of my
> node and the left side is the output of the candump. As you can see
> there is a error labeled with "Time Error"
> https://i.imgur.com/OOOPl9L.png

Is candump and you application running at the same time?

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1mxLNh4QP6UEcsfsvld1ieA0aZ5mND4Bm--

--0QfkFvsjLZbIma9UqRQ9ClnyErpotvFrS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpOBcIACgkQHv7KIOw4
HPamEAf7BgIjFywwFdDmFaqBd8TP7G7UcSfJ9uMeUmzAuNkyfHdKN7rxf/4PFWH7
NmkTMN8MKai9TdbKmPfGC6Lq5p+j+39j+mEvJ2UmxOir3mxwxMb0I2MveEqZZnQi
Y5nSvdLzdhAUuQmLB+DnO4ptDANwzItrtAJtIGh9Zzn6y+sQDLPvOhywsN7KJ3Vd
OHmB5kM7Hmc8HH9P/uLz+0eY8YOKcveVIxwPG7BfecTjNcpIJlOe1VpJyIkqwl8G
AbCLmGAcSKT7ms2Ava4RG+DRulniJdLqBfAy7NIY2TI69/vZ1uk8obmVdHUj1zn+
HUK1u+CkFRT3H0AAR8DTfeCEcsoySQ==
=HPPS
-----END PGP SIGNATURE-----

--0QfkFvsjLZbIma9UqRQ9ClnyErpotvFrS--
