From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3 1/4] can: dev: Consolidate and unify state change  handling
Date: Wed, 26 Nov 2014 12:32:56 +0100
Message-ID: <9d8fa00c692b72a6b8308839b9cb253a@grandegger.com>
References: <43755b0f-30ca-4baf-b3e3-410eaeab636a@GRBSR0089.marel.net>
 <5474ECBA.3060505@grandegger.com> <20141126102659.715.14133@shannon>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:39787 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbaKZLc6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 26 Nov 2014 06:32:58 -0500
In-Reply-To: <20141126102659.715.14133@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de

On Wed, 26 Nov 2014 10:26:59 +0000, Andri Yngvason
<andri.yngvason@marel.com> wrote:
> Quoting Wolfgang Grandegger (2014-11-25 20:55:22)
>> On 09/26/2014 07:19 PM, Andri Yngvason wrote:
>> > The handling of can error states is different between platforms.
>> > This is an attempt to correct that problem.
>> > 
>> > I've moved this handling into a generic function for changing the
>> > error state. This ensures that error state changes are handled
>> > the same way everywhere (where this function is used).
>> 
>> I think it's also important to note that now also *decreasing* error
>> states are reported.
>>
> Roger.
>> 
>> > Changes made since last proposal:
>> > can: dev: remove can_errcnt_to_state
>> > can: dev: reduce nesting in can_change_state
>> 
>> Please move the changes after the "---" line below.
>> 
> OK.
>>
>> > Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
>> > ---
>> >  drivers/net/can/dev.c          | 94
>> >  ++++++++++++++++++++++++++++++++++++++++++
>> >  include/linux/can/dev.h        |  4 ++
>> >  include/uapi/linux/can/error.h |  1 +
>> >  3 files changed, 99 insertions(+)
>> > 
>> > diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>> > index 02492d2..a10b6ab 100644
>> > --- a/drivers/net/can/dev.c
>> > +++ b/drivers/net/can/dev.c
>> > @@ -273,6 +273,100 @@ static int can_get_bittiming(struct net_device
>> > *dev, struct can_bittiming *bt,
>> >       return err;
>> >  }
>> >  
>> > +static void can_update_error_counters(struct net_device *dev,
>> > +                                   enum can_state new_state)
>> 
>> s/can_update_error_counters/can_update_error_stats/ ?
>> 
> Yeah, that makes sense.
>>
>> Error counters are usually txerr/rxerr.
>> 
>> > +{
>> > +     struct can_priv *priv = netdev_priv(dev);
>> > +
>> > +     if (new_state <= priv->state)
>> > +             return;
>> > +
>> > +     switch (new_state) {
>> > +     case CAN_STATE_ERROR_ACTIVE:
>> > +             netdev_warn(dev, "%s: did we come from a state less
than
>> > error-active?",
>> > +                         __func__);
>> 
>> Please remove __func__ here and below and use a more meaningful warning
>> message. Such messages should make sense to non-experts as well...
>> at least a little bit.
>> 
> This is actually a warning for the developer. It's means to tell him
he's
> doing
> something seriously wrong. Maybe this should be an error then?
>>
>> > +             break;
>> > +     case CAN_STATE_ERROR_WARNING:
>> > +             priv->can_stats.error_warning++;
>> > +             break;
>> > +     case CAN_STATE_ERROR_PASSIVE:
>> > +             priv->can_stats.error_passive++;
>> > +             break;
>> > +     case CAN_STATE_BUS_OFF:
>> > +             priv->can_stats.bus_off++;
>> 
>> Be careful here. This counter will also be incremented in
can_bus_off().
>>
> Ooops.

I think it should be moved out of can_bus_off(). This requires a separate
patch moving the line back to the drivers using can_bus_off().

Wolfgang.


