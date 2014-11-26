From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v3 1/4] can: dev: Consolidate and unify state change  handling
Date: Wed, 26 Nov 2014 14:12:25 +0000
Message-ID: <20141126141225.18934.71620@shannon>
References: <43755b0f-30ca-4baf-b3e3-410eaeab636a@GRBSR0089.marel.net>
 <5474ECBA.3060505@grandegger.com> <20141126102659.715.14133@shannon>
 <9d8fa00c692b72a6b8308839b9cb253a@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0068.outbound.protection.outlook.com ([157.55.234.68]:32768
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750907AbaKZOQk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Nov 2014 09:16:40 -0500
In-Reply-To: <9d8fa00c692b72a6b8308839b9cb253a@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de

Quoting Wolfgang Grandegger (2014-11-26 11:32:56)
> On Wed, 26 Nov 2014 10:26:59 +0000, Andri Yngvason
> <andri.yngvason@marel.com> wrote:
> > Quoting Wolfgang Grandegger (2014-11-25 20:55:22)
> >> On 09/26/2014 07:19 PM, Andri Yngvason wrote:
...
> >> > +     struct can_priv *priv = netdev_priv(dev);
> >> > +
> >> > +     if (new_state <= priv->state)
> >> > +             return;
> >> > +
> >> > +     switch (new_state) {
> >> > +     case CAN_STATE_ERROR_ACTIVE:
> >> > +             netdev_warn(dev, "%s: did we come from a state less
> than
> >> > error-active?",
> >> > +                         __func__);
> >> 
> >> Please remove __func__ here and below and use a more meaningful warning
> >> message. Such messages should make sense to non-experts as well...
> >> at least a little bit.
> >> 
> > This is actually a warning for the developer. It's means to tell him
> he's
> > doing
> > something seriously wrong. Maybe this should be an error then?
>
Any thoughts on this? Should I drop it or make a bigger bang?
>
> >>
> >> > +             break;
> >> > +     case CAN_STATE_ERROR_WARNING:
> >> > +             priv->can_stats.error_warning++;
> >> > +             break;
> >> > +     case CAN_STATE_ERROR_PASSIVE:
> >> > +             priv->can_stats.error_passive++;
> >> > +             break;
> >> > +     case CAN_STATE_BUS_OFF:
> >> > +             priv->can_stats.bus_off++;
> >> 
> >> Be careful here. This counter will also be incremented in
> can_bus_off().
> >>
> > Ooops.
> 
> I think it should be moved out of can_bus_off(). This requires a separate
> patch moving the line back to the drivers using can_bus_off().
> 
Thinking the same thing. We can do that later, though; right?

--
Andri
