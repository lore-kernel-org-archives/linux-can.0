From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/4] Consolidate and unify state change handling
Date: Sun, 21 Sep 2014 17:30:48 +0200
Message-ID: <541EEF28.5000103@grandegger.com>
References: <541B0792.5030002@marel.com> <541C9BD8.8070303@grandegger.com> <541EE4E9.9010506@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:53457 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbaIUPaw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 21 Sep 2014 11:30:52 -0400
In-Reply-To: <541EE4E9.9010506@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 09/21/2014 04:47 PM, Andri Yngvason wrote:
>=20
> On f=C3=B6s 19.sep 2014 21:10, Wolfgang Grandegger wrote:
>> On 09/18/2014 06:25 PM, Andri Yngvason wrote:
>>> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
>>> ---
>>> ...
>>> -            cf->can_id |=3D CAN_ERR_CRTL;
>>> -            cf->data[1] =3D (bec.txerr > bec.rxerr) ?
>>> -                CAN_ERR_CRTL_TX_WARNING :
>>> -                CAN_ERR_CRTL_RX_WARNING;
>> Hm, can_change_state() handles the equal case differently. In the
>> SJA1000 manual I found:
>>
>> "Errors detected during reception or transmission will affect the er=
ror
>> counters according to the CAN 2.0B protocol
>> specification. The error status bit is set when at least one of the
>> error counters has reached or exceeded the CPU
>> warning limit of 96. An error interrupt is generated, if enabled."
>>
>> If both are equal we do not known if rx or tx has caused the state
>> change and therefore setting "CAN_ERR_CRTL_TX_WARNING |
>> CAN_ERR_CRTL_RX_WARNING" seems more logical, indeed. But maybe it si=
mply
>> does not happen. Any other opinions?
> I think that not specifically handling the equal case would be wrong.=
 Let's
> consider the following sequence of events:
>  * txerr reaches warning level
>  * rxerr reaches warning level
> If they are both equal at this point, you will only get a second
> CAN_ERR_CRTL_TX_WARNING in the current implementation, whereas in the
> proposed
> implementation, the user would get
> CAN_ERR_CRTL_TX_WARNING | CAN_ERR_CRTL_RX_WARNING and because the use=
r
> can know
> the prior error state message, he can find out which state actually
> changed.

The question is what error (rx or tx) error did triger the error state
change interrupt. I doubt that such an interrupt is triggered when one
error counter catches up, .e.g. txer was > 128 and rxerr exceeded 128.
It's even not sure that all the controllers act the same way. Therefore
also keeping the current behaviour would be fine for me.

> But this is all based on the premise that txerr hasn't progressed sin=
ce.
> In fact,
> because we cannot assume that txerr stays in place until rxerr catche=
s
> up, this
> is what we should be doing:
> enum can_state errcount_to_state(unsigned int count)
> {
>     if (unlikely(count > 127))
>         return CAN_STATE_ERROR_PASSIVE;
>=20
>     if (unlikely(count > 96))
>         return CAN_STATE_ERROR_WARNING;
>=20
>     return CAN_STATE_ERROR_ACTIVE;
> }
>=20
> enum can_err_dir can_get_err_dir(unsigned int txerr, unsigned int rxe=
rr)
> {
>     enum can_err_dir dir;
>=20
>     enum can_state tx_state =3D errcount_to_state(txerr);
>     enum can_state rx_state =3D errcount_to_state(rxerr);
>=20
>     if (tx_state > rx_state)
>         return CAN_ERR_DIR_TX;
>=20
>     if (tx_state < rx_state)
>         return CAN_ERR_DIR_RX;
>=20
>     return CAN_ERR_DIR_TX | CAN_ERR_DIR_RX;
> }
>=20
> However, now that we've introduced errcount_to_state(), it seems to m=
e
> that it would
> be simpler to dump the proposed CAN_ERR_DIR enum in favour of passing
> the two states
> directly to can_change_state().

D'accord.

>>> -        }
>>> -    case CAN_STATE_ERROR_WARNING:    /* fallthrough */
>>> -        /*
>>> -         * from: ERROR_ACTIVE, ERROR_WARNING
>>> -         * to  : ERROR_PASSIVE, BUS_OFF
>>> -         * =3D>  : error passive int
>>> -         */
>>> -        if (new_state >=3D CAN_STATE_ERROR_PASSIVE &&
>>> -            new_state <=3D CAN_STATE_BUS_OFF) {
>>> -            netdev_dbg(dev, "Error Passive IRQ\n");
>>> -            priv->can.can_stats.error_passive++;
>>> -
>>> -            cf->can_id |=3D CAN_ERR_CRTL;
>>> -            cf->data[1] =3D (bec.txerr > bec.rxerr) ?
>>> -                CAN_ERR_CRTL_TX_PASSIVE :
>>> -                CAN_ERR_CRTL_RX_PASSIVE;
>>> -        }
>>> -        break;
>>> -    case CAN_STATE_BUS_OFF:
>>> -        netdev_err(dev, "BUG! "
>>> -               "hardware recovered automatically from BUS_OFF\n");
>>> -        break;
>>> -    default:
>>> -        break;
>>> -    }
>>> +    can_change_state(dev, cf, new_state,
>>> +             can_get_err_dir(bec.rxerr, bec.txerr));
>> Saves a lot of lines :).
> Indeed ;)
>>
>>> -    /* process state changes depending on the new state */
>>> -    switch (new_state) {
>>> -    case CAN_STATE_ERROR_WARNING:
>>> -        netdev_dbg(dev, "Error Warning\n");
>>> -        cf->can_id |=3D CAN_ERR_CRTL;
>>> -        cf->data[1] =3D (bec.txerr > bec.rxerr) ?
>>> -            CAN_ERR_CRTL_TX_WARNING :
>> To validate the correct behaviour could you please send messages whi=
le
>> the cable is disconnected. Then reconnect the cable and see how the
>> error state decreases. You can monitor the behaviour with ""candump =
-td
>> -e any,0:0,#FFFFFFFF" in another shell.
>>
> I'm using PCAN-USB Pro to generate errors on the bus. It works quite =
well.

> I can generate tx errors by sending from the device and then have the=
 pcan
> ruin a few frames. rx errors can be generated by having an other devi=
ce on
> the bus outputting random data and then let the pcan corrupt the fram=
es.

Short-circuiting the CAN low and high lines is a simple method to

> Sadly the error generation mechanism only works on windows. :(
>=20
> I've tried the "disconnected cable" method too in the past. It usuall=
y
> puts mscan into bus-off quite fast.

Sending a message whithout cable should never trigger an bus-off. The t=
x
error counter never exceeds 128.

Here is an example output of "candump -candump -td -e any,0:0,#FFFFFFFF=
"
for a recovery from error passive state due to no ack/cable (reconnect
after 5s) for a SJA1000 on an on EMS PCI card:

 (000.201913)  can0   1C  [0]
 (000.212241)  can0  20000204  [8] 00 08 00 00 00 00 60 00   ERRORFRAME
        controller-problem{tx-error-warning}
        state-change{tx-error-warning}
        error-counter-tx-rx{{96}{0}}
 (000.003544)  can0  20000204  [8] 00 20 00 00 00 00 80 00   ERRORFRAME
        controller-problem{tx-error-passive}
        state-change{tx-error-passive}
        error-counter-tx-rx{{128}{0}}
 (004.901842)  can0   1D  [7] 1D F6 33 52 31 4B DE
 (000.000116)  can0  20000200  [8] 00 08 00 00 00 00 7F 00   ERRORFRAME
        state-change{tx-error-warning}
        error-counter-tx-rx{{127}{0}}
 (000.000678)  can0   1E  [6] 42 05 14 82 23 B6
 ...
 (000.201927)  can0   49  [4] 2F 1A 97 25
 (000.000096)  can0  20000200  [8] 00 40 00 00 00 00 5F 00   ERRORFRAME
        state-change{back-to-error-active}
        error-counter-tx-rx{{95}{0}}
 (000.202184)  can0   4A  [8] 7F 87 0E FE 03 BA 78 91

This is from my related patch-set.

Wolfgang.
