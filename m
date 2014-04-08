From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Tue, 8 Apr 2014 09:35:20 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404080930310.14882@ionos.tec.linutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <1963054.jznjb2yEgj@ws-stein> <alpine.DEB.2.02.1404071816100.14882@ionos.tec.linutronix.de> <1973262.duOsuUUePM@ws-stein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54782 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220AbaDHHfJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 03:35:09 -0400
In-Reply-To: <1973262.duOsuUUePM@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Tue, 8 Apr 2014, Alexander Stein wrote:
> On Monday 07 April 2014 18:27:11, Thomas Gleixner wrote:
> >  static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
> >  			      u32 pend, int quota)
> >  {
> > -	u32 pkts = 0, ctrl, obj, mcmd;
> > +	u32 pkts = 0, ctrl, obj;
> >  
> >  	while ((obj = ffs(pend)) && quota > 0) {
> >  		pend &= ~BIT(obj - 1);
> >  
> > -		mcmd = obj < C_CAN_MSG_RX_LOW_LAST ?
> > -			IF_COMM_RCV_LOW : IF_COMM_RCV_HIGH;
> > -
> > -		c_can_object_get(dev, IF_RX, obj, mcmd);
> > +		c_can_rx_object_get(dev, obj);
> >  		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
> >  
> >  		if (ctrl & IF_MCONT_MSGLST) {
> > @@ -820,21 +841,25 @@ static int c_can_read_objects(struct net
> >  		/* read the data from the message object */
> >  		c_can_read_msg_object(dev, IF_RX, ctrl);
> >  
> > -		if (obj < C_CAN_MSG_RX_LOW_LAST)
> > -			priv->rxmasked |= BIT(obj - 1);
> > -		else if (obj == C_CAN_MSG_RX_LOW_LAST) {
> > -			priv->rxmasked = 0;
> > -			/* activate all lower message objects */
> > -			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
> > -		}
> > +		c_can_rx_finalize(dev, priv, obj);
> >  
> >  		pkts++;
> >  		quota--;
> > -	} while ((obj = ffs(pend)) && quota > 0);
> > +	}
>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> BTW: This doesn't look right.

Crap. The second while() is a left over in an stale branch and I did
not notice that I was on that one. I'll send out an updated series
later today.

Thanks,

	tglx




