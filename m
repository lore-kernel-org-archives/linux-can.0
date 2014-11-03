From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 11/15] can: rx-fifo: Add support for can state tracking
 and error polling
Date: Mon, 03 Nov 2014 13:58:43 +0100
Message-ID: <54577C03.7010609@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>	<1412956020-21489-12-git-send-email-david@protonic.nl>	<545765D8.7090906@pengutronix.de> <20141103135135.10fd4c6f@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pHS8d1RjIUM7KrrnQavBFjUulpxA5v8mV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40363 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbaKCM6u (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 07:58:50 -0500
In-Reply-To: <20141103135135.10fd4c6f@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pHS8d1RjIUM7KrrnQavBFjUulpxA5v8mV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2014 01:51 PM, David Jander wrote:
>> On 10/10/2014 05:46 PM, David Jander wrote:
>>> The interrupt handler should store the error flags if needed and call=

>>> can_rx_fifo_irq_error() if there was an error flag set. This will tri=
gger
>>> a napi-poll that will call poll_can_state() and poll_bus_error()
>>> callbacks. Those should handle can state machine and send error frame=
s
>>> as needed.
>>>
>>> Signed-off-by: David Jander <david@protonic.nl>
>>> ---
>>>  drivers/net/can/dev.c   | 23 ++++++++++++++++++++---
>>>  include/linux/can/dev.h |  9 +++++++++
>>>  2 files changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>>> index fc35d28..dac7579 100644
>>> --- a/drivers/net/can/dev.c
>>> +++ b/drivers/net/can/dev.c
>>> @@ -352,6 +352,9 @@ static int can_rx_fifo_napi_poll(struct napi_stru=
ct
>>> *napi, int quota) unsigned int tail;
>>> =20
>>>  restart_poll:
>>> +	if (work_done < quota)
>>> +		work_done +=3D fifo->poll_can_state(fifo);
>>> +
>>
>> Do we need two callbacks in the poll-loop? I think one should be enoug=
h.
>> The driver can call as many non-rx related functions as needed then.
>> E.g. state change, bus error handling, tx-completion handling, etc...
>=20
> Ok. I split it into two handlers, because I saw most drivers doing firs=
t
> state-handling then message reception and last error handling... in thi=
s
> particular order. If that order is not important, we can use one poll()=

> function for both state- and error-handling.
> In that case... should the poll() handler be called _before_ or _after_=

> handling the mailboxes?

Following the general rule zero-one-infinity ("Allow none of foo, one of
foo, or any number of foo" [1]) one callback should be fine. As we are
optimizing for not loosing RX CAN frames I tend to say it should come
after rx.

Marc

[1] http://c2.com/cgi/wiki?ZeroOneInfinityRule

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pHS8d1RjIUM7KrrnQavBFjUulpxA5v8mV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUV3wDAAoJECte4hHFiupUbPMQAKwrATGuwhm1zfWTkIdCiRCk
K9lzejJ7QTm2obwaCr1a+guoN6vdWBliRdrOER4LLciiTn+wcBg+cNuCPdaDChGi
JvfIv3KRpU3y+2WAaUuzrz1qJsEbo6Mgw84AF9Iy595lrVfJupaR/EJU0gszgPZk
g1UNcEtw8LkwfYIkQIKuEXInqn27fOWxktaOG2rrKLVfZ5lyCqiB5DY6lt89QIJW
fopb2bMyX3pA2eNSt6v8AOsGDonUFDTLYwwVOrVDacfhzV2oLWqSH4hYnB0vJSpm
wLMI8n8RQYJQrI11HZZlUQWo/zXAelUkqRoionF91jLQLX3OExqp7vuzymRA66ax
T3RuTPPC13l74buHmxaq9CLGz7nBrJRol75gtCDylg177+vftsKlhF/lfnr/+SH3
aLGJl19XtW1hMgRX1FS+i6RKS8ul+NcCJpqUY6G9PmPPeF2PRnEsJT3KFAMcJOxr
mH9AqtMcwGZtrtsXRfC8mk2g4mD1DcKn1JXuzYlKnTBuTEv10vkbXnhDOpIsbiZq
k4nVqbcqM8yI+E7X38xUNnl3V4BSHXTxg4bC+pEOAhSzNa2srp+1AcLUqbHugi4s
BS0ghtoq5+KTpKoCe98RSuvKn602wEzaSjwzlqtIBNm6mjH2Kc8FduHOkKGnOf2l
7fDkfycbqPcGBzdrjP5m
=aJ5N
-----END PGP SIGNATURE-----

--pHS8d1RjIUM7KrrnQavBFjUulpxA5v8mV--
