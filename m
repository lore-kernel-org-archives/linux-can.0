From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v3 1/4] can: dev: Consolidate and unify state change   handling
Date: Wed, 26 Nov 2014 15:38:36 +0000
Message-ID: <20141126153836.17535.10469@shannon>
References: <43755b0f-30ca-4baf-b3e3-410eaeab636a@GRBSR0089.marel.net>
 <5474ECBA.3060505@grandegger.com> <20141126102659.715.14133@shannon>
 <9d8fa00c692b72a6b8308839b9cb253a@grandegger.com>
 <20141126141225.18934.71620@shannon>
 <8dc1158e6f8986a738d2c0a6002ff91a@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0074.outbound.protection.outlook.com ([157.55.234.74]:14526
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752554AbaKZPms convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Nov 2014 10:42:48 -0500
In-Reply-To: <8dc1158e6f8986a738d2c0a6002ff91a@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de

Quoting Wolfgang Grandegger (2014-11-26 14:55:10)
> On Wed, 26 Nov 2014 14:12:25 +0000, Andri Yngvason
> <andri.yngvason@marel.com> wrote:
> > Quoting Wolfgang Grandegger (2014-11-26 11:32:56)
> >> On Wed, 26 Nov 2014 10:26:59 +0000, Andri Yngvason
> >> <andri.yngvason@marel.com> wrote:
> >> > Quoting Wolfgang Grandegger (2014-11-25 20:55:22)
> >> >> On 09/26/2014 07:19 PM, Andri Yngvason wrote:
> > ...
> >> >> > +     struct can_priv *priv = netdev_priv(dev);
> >> >> > +
> >> >> > +     if (new_state <= priv->state)
> >> >> > +             return;
> >> >> > +
> >> >> > +     switch (new_state) {
> >> >> > +     case CAN_STATE_ERROR_ACTIVE:
> >> >> > +             netdev_warn(dev, "%s: did we come from a state less
> >> than
> >> >> > error-active?",
> 
> This indicates a state change active to active, right? The it's definitely
> an error. Can it happen (code wise)?
> 
Well, no, I'll just remove this.
>
> >> >> > +                         __func__);
> >> >> 
> >> >> Please remove __func__ here and below and use a more meaningful
> >> >> warning
> >> >> message. Such messages should make sense to non-experts as well...
> >> >> at least a little bit.
> >> >> 
> >> > This is actually a warning for the developer. It's means to tell him
> >> he's
> >> > doing
> >> > something seriously wrong. Maybe this should be an error then?
> >>
> > Any thoughts on this? Should I drop it or make a bigger bang?
> 
> To realize malfunctioning it's better to have an error message, I think.
> Something like "invalid state change to error active detected"
>
Agreed.
> 
> >>
> >> >>
> >> >> > +             break;
> >> >> > +     case CAN_STATE_ERROR_WARNING:
> >> >> > +             priv->can_stats.error_warning++;
> >> >> > +             break;
> >> >> > +     case CAN_STATE_ERROR_PASSIVE:
> >> >> > +             priv->can_stats.error_passive++;
> >> >> > +             break;
> >> >> > +     case CAN_STATE_BUS_OFF:
> >> >> > +             priv->can_stats.bus_off++;
> >> >> 
> >> >> Be careful here. This counter will also be incremented in
> >> can_bus_off().
> >> >>
> >> > Ooops.
> >> 
> >> I think it should be moved out of can_bus_off(). This requires a
> separate
> >> patch moving the line back to the drivers using can_bus_off().
> >> 
> > Thinking the same thing. We can do that later, though; right?
> 
> It should be addressed by this patch series because above is the right
> place to increment can_stats.bus_off. What do you think naming the
> function "can_change_state_and_update_stats()"? This would make pretty
> clear what it does.
> 
I think that functions shouldn't actually do more than one thing and that if you
put an "and" in the function name, that's a really good indicator that the
function is doing more than it should.

The rationale here is that you shouldn't have to read the function to figure out
what it actually does when reading the code that uses it.

Also, we would actually have to call the function
"can_change_state_and_update_stats_and_compose_error_state_error_frame()"
which seems rather absurd.

"can_change_state" actually does three things, two of which are not changing the
state. We could change it to "can_process_state" which is more ambiguous, but
less misleading. Or maybe "can_do_state" or "can_feed_state".

I'm leaning towards splitting it up, but I'm fine with one function also if you
like that better.

Maybe someone else would like to chime in on this? Marc?

--
Andri
