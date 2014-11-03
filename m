From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 11/15] can: rx-fifo: Add support for can state tracking
 and error polling
Date: Mon, 03 Nov 2014 14:24:59 +0100
Message-ID: <5457822B.5090200@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>	<1412956020-21489-12-git-send-email-david@protonic.nl>	<545765D8.7090906@pengutronix.de>	<20141103135135.10fd4c6f@archvile>	<54577C03.7010609@pengutronix.de> <20141103140921.4ffd55e7@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SH3eI1pkfEKJvmhctsOVmnfUr1K25K0AE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46927 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaKCNZJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 08:25:09 -0500
In-Reply-To: <20141103140921.4ffd55e7@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SH3eI1pkfEKJvmhctsOVmnfUr1K25K0AE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2014 02:09 PM, David Jander wrote:
> On Mon, 03 Nov 2014 13:58:43 +0100
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 11/03/2014 01:51 PM, David Jander wrote:
>>>> On 10/10/2014 05:46 PM, David Jander wrote:
>>>>> The interrupt handler should store the error flags if needed and ca=
ll
>>>>> can_rx_fifo_irq_error() if there was an error flag set. This will t=
rigger
>>>>> a napi-poll that will call poll_can_state() and poll_bus_error()
>>>>> callbacks. Those should handle can state machine and send error fra=
mes
>>>>> as needed.
>>>>>
>>>>> Signed-off-by: David Jander <david@protonic.nl>
>>>>> ---
>>>>>  drivers/net/can/dev.c   | 23 ++++++++++++++++++++---
>>>>>  include/linux/can/dev.h |  9 +++++++++
>>>>>  2 files changed, 29 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>>>>> index fc35d28..dac7579 100644
>>>>> --- a/drivers/net/can/dev.c
>>>>> +++ b/drivers/net/can/dev.c
>>>>> @@ -352,6 +352,9 @@ static int can_rx_fifo_napi_poll(struct napi_st=
ruct
>>>>> *napi, int quota) unsigned int tail;
>>>>> =20
>>>>>  restart_poll:
>>>>> +	if (work_done < quota)
>>>>> +		work_done +=3D fifo->poll_can_state(fifo);
>>>>> +
>>>>
>>>> Do we need two callbacks in the poll-loop? I think one should be eno=
ugh.
>>>> The driver can call as many non-rx related functions as needed then.=

>>>> E.g. state change, bus error handling, tx-completion handling, etc..=
=2E
>>>
>>> Ok. I split it into two handlers, because I saw most drivers doing fi=
rst
>>> state-handling then message reception and last error handling... in t=
his
>>> particular order. If that order is not important, we can use one poll=
()
>>> function for both state- and error-handling.
>>> In that case... should the poll() handler be called _before_ or _afte=
r_
>>> handling the mailboxes?
>>
>> Following the general rule zero-one-infinity ("Allow none of foo, one =
of
>> foo, or any number of foo" [1]) one callback should be fine. As we are=

>> optimizing for not loosing RX CAN frames I tend to say it should come
>> after rx.
>=20
> Hahaha, ok, I got it :)
> Any idea on how to call this function? Just "poll" seems a little bit
> under-documented...

Yes, what about extra_poll, poll_extra?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SH3eI1pkfEKJvmhctsOVmnfUr1K25K0AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUV4IrAAoJECte4hHFiupUQZwP/2Q5rP7u2Lb81J8tqAnYgZTv
Xvs71aSjUH1eAX/fUG3bc4JmRG15d49+nZamqJKHdTU5Zd0rZbPRV94HyfLbXGuT
7lBljUCVFdnyL/87OLOgD8Ci+hxfGnWB7Z97LrCeXFjcz3yYmXtIak39gWmEb6JD
H+kb/4hHuujz1eNnLANpGr1Di1163plbj2Dcgaxy9yVNAMf63Zo/7IPzge1tfBbw
kVWlM/Jk5MXivyNdFhMDHIdNIiOL4kno9UKRBrG4+LfWGnF+QqUwHlGV0/yR8fXI
MKD2dxUYK8EqYZ+mSyeN6zEaEvWdH4PqNl8q3jTP36qIBVWyylQYOOn9Qq0RcK1N
kJtm7rprKGsewjLhhs5oKDnHDt+ba3P9Fy73wumrR5cndB5QDPRyzzM2K0V7EYqv
HoMKFqkDu7gEc9FkZCFmpgryLBQ4MuOdAsZm2bdhxGPPrQWCWbEtUIBXCoCxI/jz
WlbVilL9YnP7eLdFFrj6VMg9TaVt9tcv1z8RRnv4F/KDrErDcPFKp98tBA7vUZGB
vg0bdRL5fXGyw21XK3WjhfBbyZOV4+3apz9tAetmpFJ/lpkZN8+w27Nglc8GzF4X
sJl6lYdg76hRP35VvmFa6Rz/XTBYGxK8vQSAeXZK7ZPLCbyEMSnR3llbBRkA+CR0
t6J941Z5Zdwy9KjXIUau
=MmiZ
-----END PGP SIGNATURE-----

--SH3eI1pkfEKJvmhctsOVmnfUr1K25K0AE--
