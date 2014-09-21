From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH 1/4] Consolidate and unify state change handling
Date: Sun, 21 Sep 2014 15:27:42 +0000
Message-ID: <541EEE6E.5010805@marel.com>
References: <541B078C.2020007@marel.com> <541C9306.1020800@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0092.outbound.protection.outlook.com ([157.56.111.92]:7090
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751503AbaIUP1t (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 21 Sep 2014 11:27:49 -0400
In-Reply-To: <541C9306.1020800@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org


On f=C3=B6s 19.sep 2014 20:33, Wolfgang Grandegger wrote:
> On 09/18/2014 06:25 PM, Andri Yngvason wrote:
>
> Please add a brief patch description. E.g. what is it good for and wh=
at
> does it improve.
I'll do that. Thanks for pointing this out.
>> ...
>> +
>> +void can_change_state(struct net_device *dev, struct can_frame *cf,
>> +              enum can_state state, enum can_err_dir err_dir)
> Thinking about it... passing txerr and rxerr directly here would make
> the err_dir obsolete and the code more simpler. CAN controllers
> not supporting tx/rx error counter should pass "0, 0".
There are controllers that do not expose the error counters but do expo=
se
the individual states of the error counters (e.g. mscan); or maybe rath=
er
which state changed? What I proposed in my reply to [PATCH 2/4] would
solve this.

>
> Also s/state/new_state/ would improve readability.
Yes.
>
>> +{
>> +    struct can_priv *priv =3D netdev_priv(dev);
>> +
>> +    if (unlikely(state =3D=3D priv->state)) {
>> +        netdev_warn(dev, "%s: oops, state did not change", __func__=
);
>> +        return;
>> +    }
>> +
>> +    if (state !=3D CAN_STATE_BUS_OFF)
>> +        cf->can_id |=3D CAN_ERR_CRTL;
>> +
>> +    switch (state) {
>> +    case CAN_STATE_ERROR_WARNING:
>> +        if (state > priv->state)
>> +            priv->can_stats.error_warning++;
>> +        cf->data[1] =3D can_make_state_warning(err_dir);
>> +        break;
>> +
>> +    case CAN_STATE_ERROR_PASSIVE:
>> +        if (state > priv->state)
>> +            priv->can_stats.error_passive++;
>> +        cf->data[1] =3D can_make_state_passive(err_dir);
>> +        break;
>> +
>> +    case CAN_STATE_ERROR_ACTIVE:
>> +        cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
>> +        break;
>> +
>> +    case CAN_STATE_BUS_OFF:
>> +        priv->can_stats.bus_off++;
>> +        cf->can_id |=3D CAN_ERR_BUSOFF;
>> +        break;
>> +
>> +    default:
> A netdev_warn would be nice here.
Yes, that would probably we wise in case someone accidentally passes=20
something
that isn't really a state.

Andri
