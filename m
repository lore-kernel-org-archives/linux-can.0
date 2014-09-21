From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH 2/4] Consolidate and unify state change handling
Date: Sun, 21 Sep 2014 14:47:05 +0000
Message-ID: <541EE4E9.9010506@marel.com>
References: <541B0792.5030002@marel.com> <541C9BD8.8070303@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1on0083.outbound.protection.outlook.com ([157.56.110.83]:24480
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751145AbaIUOrM (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 21 Sep 2014 10:47:12 -0400
In-Reply-To: <541C9BD8.8070303@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org


On f=C3=B6s 19.sep 2014 21:10, Wolfgang Grandegger wrote:
> On 09/18/2014 06:25 PM, Andri Yngvason wrote:
>> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
>> ---
>> ...
>> -            cf->can_id |=3D CAN_ERR_CRTL;
>> -            cf->data[1] =3D (bec.txerr > bec.rxerr) ?
>> -                CAN_ERR_CRTL_TX_WARNING :
>> -                CAN_ERR_CRTL_RX_WARNING;
> Hm, can_change_state() handles the equal case differently. In the
> SJA1000 manual I found:
>
> "Errors detected during reception or transmission will affect the err=
or
> counters according to the CAN 2.0B protocol
> specification. The error status bit is set when at least one of the
> error counters has reached or exceeded the CPU
> warning limit of 96. An error interrupt is generated, if enabled."
>
> If both are equal we do not known if rx or tx has caused the state
> change and therefore setting "CAN_ERR_CRTL_TX_WARNING |
> CAN_ERR_CRTL_RX_WARNING" seems more logical, indeed. But maybe it sim=
ply
> does not happen. Any other opinions?
I think that not specifically handling the equal case would be wrong. L=
et's
consider the following sequence of events:
  * txerr reaches warning level
  * rxerr reaches warning level
If they are both equal at this point, you will only get a second
CAN_ERR_CRTL_TX_WARNING in the current implementation, whereas in the=20
proposed
implementation, the user would get
CAN_ERR_CRTL_TX_WARNING | CAN_ERR_CRTL_RX_WARNING and because the user=20
can know
the prior error state message, he can find out which state actually cha=
nged.

But this is all based on the premise that txerr hasn't progressed since=
=2E=20
In fact,
because we cannot assume that txerr stays in place until rxerr catches=20
up, this
is what we should be doing:
enum can_state errcount_to_state(unsigned int count)
{
     if (unlikely(count > 127))
         return CAN_STATE_ERROR_PASSIVE;

     if (unlikely(count > 96))
         return CAN_STATE_ERROR_WARNING;

     return CAN_STATE_ERROR_ACTIVE;
}

enum can_err_dir can_get_err_dir(unsigned int txerr, unsigned int rxerr=
)
{
     enum can_err_dir dir;

     enum can_state tx_state =3D errcount_to_state(txerr);
     enum can_state rx_state =3D errcount_to_state(rxerr);

     if (tx_state > rx_state)
         return CAN_ERR_DIR_TX;

     if (tx_state < rx_state)
         return CAN_ERR_DIR_RX;

     return CAN_ERR_DIR_TX | CAN_ERR_DIR_RX;
}

However, now that we've introduced errcount_to_state(), it seems to me=20
that it would
be simpler to dump the proposed CAN_ERR_DIR enum in favour of passing=20
the two states
directly to can_change_state().
>> -        }
>> -    case CAN_STATE_ERROR_WARNING:    /* fallthrough */
>> -        /*
>> -         * from: ERROR_ACTIVE, ERROR_WARNING
>> -         * to  : ERROR_PASSIVE, BUS_OFF
>> -         * =3D>  : error passive int
>> -         */
>> -        if (new_state >=3D CAN_STATE_ERROR_PASSIVE &&
>> -            new_state <=3D CAN_STATE_BUS_OFF) {
>> -            netdev_dbg(dev, "Error Passive IRQ\n");
>> -            priv->can.can_stats.error_passive++;
>> -
>> -            cf->can_id |=3D CAN_ERR_CRTL;
>> -            cf->data[1] =3D (bec.txerr > bec.rxerr) ?
>> -                CAN_ERR_CRTL_TX_PASSIVE :
>> -                CAN_ERR_CRTL_RX_PASSIVE;
>> -        }
>> -        break;
>> -    case CAN_STATE_BUS_OFF:
>> -        netdev_err(dev, "BUG! "
>> -               "hardware recovered automatically from BUS_OFF\n");
>> -        break;
>> -    default:
>> -        break;
>> -    }
>> +    can_change_state(dev, cf, new_state,
>> +             can_get_err_dir(bec.rxerr, bec.txerr));
> Saves a lot of lines :).
Indeed ;)
>
>> -    /* process state changes depending on the new state */
>> -    switch (new_state) {
>> -    case CAN_STATE_ERROR_WARNING:
>> -        netdev_dbg(dev, "Error Warning\n");
>> -        cf->can_id |=3D CAN_ERR_CRTL;
>> -        cf->data[1] =3D (bec.txerr > bec.rxerr) ?
>> -            CAN_ERR_CRTL_TX_WARNING :
> To validate the correct behaviour could you please send messages whil=
e
> the cable is disconnected. Then reconnect the cable and see how the
> error state decreases. You can monitor the behaviour with ""candump -=
td
> -e any,0:0,#FFFFFFFF" in another shell.
>
I'm using PCAN-USB Pro to generate errors on the bus. It works quite we=
ll.
I can generate tx errors by sending from the device and then have the p=
can
ruin a few frames. rx errors can be generated by having an other device=
 on
the bus outputting random data and then let the pcan corrupt the frames=
=2E

Sadly the error generation mechanism only works on windows. :(

I've tried the "disconnected cable" method too in the past. It usually
puts mscan into bus-off quite fast.

Thanks for the comments!

Andri
