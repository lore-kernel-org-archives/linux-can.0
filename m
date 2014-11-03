From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 07/15] can: rx-fifo: Change to do controller off-load
 in interrupt and NAPI poll
Date: Mon, 03 Nov 2014 12:10:17 +0100
Message-ID: <54576299.6080907@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>	<1412956020-21489-8-git-send-email-david@protonic.nl>	<20141019220909.GC428@pengutronix.de> <20141020090613.63044885@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SoCGgd7IjgS2h5dhS3J0DOKm6XPRxXmir"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34544 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbaKCLKd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 06:10:33 -0500
In-Reply-To: <20141020090613.63044885@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SoCGgd7IjgS2h5dhS3J0DOKm6XPRxXmir
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2014 09:06 AM, David Jander wrote:
>>> +static int can_rx_fifo_napi_poll(struct napi_struct *napi, int quota=
)
>>> +{
>>> +	struct can_rx_fifo *fifo =3D container_of(napi, struct can_rx_fifo,=

>>> napi);
>>> +	int work_done =3D 0;
>>> +	int ret;
>>> +	unsigned int head;
>>> +	unsigned int tail;
>>> +
>>> +restart_poll:
>>> +	/* handle mailboxes */
>>> +	head =3D smp_load_acquire(&fifo->ring_head);
>>> +	tail =3D fifo->ring_tail;
>>> +	while ((CIRC_CNT(head, tail, fifo->ring_size) >=3D 1) &&
>>> +			(work_done < quota)) {
>>> +		ret =3D can_rx_fifo_read_napi_frame(fifo, tail);
>>> +		work_done +=3D ret;
>>> +		tail =3D (tail + 1) & (fifo->ring_size -1);
>>> +		smp_store_release(&fifo->ring_tail, tail);
>>> +	}
>>> +
>>> +	if (work_done < quota) {
>>> +		napi_complete(napi);
>>> +
>>> +		/* Check if there was another interrupt */
>>> +		head =3D smp_load_acquire(&fifo->ring_head);
>>> +		if ((CIRC_CNT(head, tail, fifo->ring_size) >=3D 1) &&
>>> +		    napi_reschedule(&fifo->napi))
>>> +			goto restart_poll;
>>
>> Hmmm, this looks a bit strange. If I understand the code correctly you=
 ask
>> that napi should be started again, but then jump directly to the begin=
ning.
>=20
> The documentation seems to say that one should use it like that:
>=20
> http://www.linuxfoundation.org/collaborate/workgroups/networking/napi

Some drivers do it this way, other don't.

> If you still think it is wrong, then tell me how to re-enable napi and
> continue correctly. AFAIK it is done like this in order to avoid a race=
 when
> the interrupt is called while NAPI polling was underway. napi_schedule(=
) just
> sets a flag, and does _not_ add work to a queue...

I think your code is correct. There are several aspects to it, as far as
I understand the NAPI code:
- NAPI_STATE_SCHED means a poll is scheduled
- napi_reschedule(): if NAPI_STATE_SCHED is already set it will return
  false. Otherwise NAPI_STATE_SCHED will be set and a sofirq will be
  raised, true is returned.
- I think the "goto restart_poll" is an optimisation, as the softirq
  will schedule the poll function again. But AFAICS it's fine, as
  napi_complete() checks for NAPI_STATE_SCHED set.
- The above code is needed for devices on an edge triggered interrupt
  line. As there is a race window between checking the RX buffer and
  enabling the interrupt line. As we don't have an interrupt here at
  all, we must have this code. Good work!

>>> +	}
>>> +
>>> +	return work_done;
>>> +}
>>> +
>>>  int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo=
)
>>>  {
>>> +	unsigned int weight;
>>>  	fifo->dev =3D dev;
>>> =20
>>>  	if ((fifo->low_first < fifo->high_first) &&
>>> -	    (fifo->high_first < fifo->high_last))
>>> +	    (fifo->high_first < fifo->high_last)) {
>>>  		fifo->inc =3D true;
>>> -	else if ((fifo->low_first > fifo->high_first) &&
>>> -		 (fifo->high_first > fifo->high_last))
>>> +		weight =3D fifo->high_last - fifo->low_first;
>>> +	} else if ((fifo->low_first > fifo->high_first) &&
>>> +		 (fifo->high_first > fifo->high_last)) {
>>>  		fifo->inc =3D false;
>>> -	else
>>> +		weight =3D fifo->low_first - fifo->high_last;
>>> +	} else
>>>  		return -EINVAL;
>>
>> Please but { } at every branch of the if else.
>=20
> Ok, will do.
>=20
>>> =20
>>> -	if (!fifo->read_pending || !fifo->mailbox_enable_mask ||
>>> -	    !fifo->mailbox_disable || !fifo->mailbox_receive)
>>> +	if (!fifo->mailbox_enable_mask || !fifo->mailbox_move_to_buffer ||
>>> +	    !fifo->mailbox_enable)
>>>  		return -EINVAL;
>>> =20
>>> +	/* Make ring-buffer a sensible size that is a power of 2 */
>>> +	fifo->ring_size =3D (2 << fls(weight));
>>> +	fifo->ring =3D kzalloc(sizeof(struct can_frame) * fifo->ring_size,
>>> +			     GFP_KERNEL);
>>> +	if (!fifo->ring)
>>> +		return -ENOMEM;
>>> +
>>> +	fifo->ring_head =3D fifo->ring_tail =3D 0;
>>> +
>>> +	/* Take care of NAPI handling */
>>> +	netif_napi_add(dev, &fifo->napi, can_rx_fifo_napi_poll, weight);
>>
>> I'm not sure, if the rx-fifo should take care of the whole NAPI, I thi=
nk it's
>> better to provide helper functions instead.
>=20
> Why not? We are removing the messages from the CAN controller in the IR=
Q
> already, so why would the CAN driver have to even care about NAPI which=

> happens _after_ all that? Can you come up with an example where this ma=
y not
> be desirable?

If NAPI is handled by the rx-fifo exclusively, everything else i.e.
tx-complete and error handling cannot be done in NAPI. Thinking more
about this and looking at the above discussed code, maybe it's better to
have the napi in the rx-fifo code.

> Can you illustrate your idea with helper functions?

Something like can_rx_fifo_napi_poll() would be our helper function,
it's supposed to be called from the NAPI handler the driver has
registered. But the driver has to take care about the napi_complete()
and napi_reschedule(), which is probably quite fragile.... So keep it as
it is.

>=20
>>> +
>>>  	/* init variables */
>>>  	fifo->mask_low =3D can_rx_fifo_mask_low(fifo);
>>>  	fifo->mask_high =3D can_rx_fifo_mask_high(fifo);
>>> -	fifo->next =3D fifo->low_first;
>>> +	fifo->second_first =3D false;
>>>  	fifo->active =3D fifo->mask_low | fifo->mask_high;
>>>  	fifo->mailbox_enable_mask(fifo, fifo->active);
>>> =20
>>> @@ -338,60 +420,95 @@ int can_rx_fifo_add(struct net_device *dev, str=
uct
>>> can_rx_fifo *fifo) }
>>>  EXPORT_SYMBOL_GPL(can_rx_fifo_add);
>>> =20
>>> -int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota)
>>> +static unsigned int can_rx_fifo_offload_if_full(struct can_rx_fifo *=
fifo,
>>> unsigned int n) +{
>>> +	unsigned int head =3D fifo->ring_head;
>>> +	unsigned int tail =3D ACCESS_ONCE(fifo->ring_tail);
>>> +	unsigned int ret =3D 0;
>>> +
>>> +	if (CIRC_SPACE(head, tail, fifo->ring_size) >=3D 1) {
>>> +		ret =3D fifo->mailbox_move_to_buffer(fifo,
>>> &fifo->ring[head], n);
>>> +		if (ret)
>>> +			smp_store_release(&fifo->ring_head,
>>> +				(head + 1) & (fifo->ring_size - 1));
>>> +	} else {
>>> +		ret =3D fifo->mailbox_move_to_buffer(fifo, &fifo->overflow,
>>> n);
>>> +		if (ret)
>>> +			fifo->dev->stats.rx_dropped++;
>>> +	}
>>
>> That's the purpose of the overflow mailbox? fifo-> overflow seems to b=
e write
>> only?
>=20
> Yes.
> The idea is to simplify the code for the user. mailbox_move_to_buffer()=
 should
> just move the corresponding can message to the provided buffer and do a=
ll
> interrupt-flag clearing and stuff the driver needs to do in order to fr=
ee the
> MB. Its just that in the case we don't have space in the circular buffe=
r, I
> don't want to complicate things for the driver and tell him that this m=
essage
> should be discarded. Just think of fifo->overflow as a sort of /dev/nul=
l.
> Of course I could just pass NULL to that function, but IMHO that's dang=
erous
> because since it happens only very seldom, a missing check for NULL in =
that
> function may bite you when it is already too late (i.e. the driver alre=
ady hit
> mainline).

Okay, got it, nice idea. Can you put a comment in the struct rx-fifo.
Can you also document the requirements on the mailbox_move_to_buffer()
callback, I remember you've written this in some email....

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




--SoCGgd7IjgS2h5dhS3J0DOKm6XPRxXmir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUV2KcAAoJECte4hHFiupUEZoQAKxLui91CLZlr+99rgh8174v
gHqaF2u9p+HJ+6rTWBJ6Ai0+ABjzfdg8whEpUr/lwD7sJCAQmA2wfalfMcfNwQzm
w8l4LoJLd5RSY9wjCACKaBM/sPIyZ4qgno2l/IRAUFcPJl65Gg7JJLMlOc4ezH0r
rvmoR1Rg8746VjoGzp5DYdKyj6Y8sg2hC9+um6kBLgU2Vti7oDBspMbzn9lB42is
ZHCqUzLZ+8CKH3y59cFffHQVUIGuIiDgmST1MBABy8JnL90FoygRIzp7zezFW23D
vyv4e5W+rItTstavalM+ue7RcTjcaC8FWDeBVCxcN3b6FRMBnxbP5m9QzbEL1o88
sNoeG8eVCFqH2UC1Qv9qT6Vk2+3M9qq2j2s3fhxg6Y8oD2+XXaBC+AYu089byPr3
YTn2sv8rfTP1uodynpYMjE3dwCuSHDV3gf8VN6dfHv61WgKu+nRiy7+FmiQe2YfM
1X4gqwuSzOG3vpWDGDlvemRyVejrrjydHsPGFUGXtWHeQqiQ+GFjrk2egoGhlfnl
PjUNR7PA2eXUJF/zUg3g0lxbYcNpRkRPydwJigUerJWJf9AFhQ3xYM5BFCTs4uKe
8WMguqXYresn9P8rXEX2DCFSYfhbw3QglWL1h02SEBImo4pp5UmdlJRwo15oB++5
J3JQz+UC7zA34szsP0Rd
=Yjzb
-----END PGP SIGNATURE-----

--SoCGgd7IjgS2h5dhS3J0DOKm6XPRxXmir--
