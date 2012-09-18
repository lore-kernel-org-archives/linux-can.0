From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH] can: sja1000: Add support for listen-only mode and
 one-shot mode
Date: Tue, 18 Sep 2012 09:16:03 -0700
Message-ID: <20120918161603.GC12449@ovro.caltech.edu>
References: <1347897482-26379-1-git-send-email-andreas@gaisler.com>
 <50587B46.7060506@pengutronix.de>
 <50588115.8070907@grandegger.com>
 <5058994E.8000501@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:37855 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab2IRQQH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 12:16:07 -0400
Content-Disposition: inline
In-Reply-To: <5058994E.8000501@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, software@gaisler.com

On Tue, Sep 18, 2012 at 05:54:54PM +0200, Andreas Larsson wrote:
> On 09/18/2012 04:11 PM, Wolfgang Grandegger wrote:
> > On 09/18/2012 03:46 PM, Marc Kleine-Budde wrote:
> >> On 09/17/2012 05:58 PM, Andreas Larsson wrote:
> >>> Packages that fails to be transmitted in one-shot mode are never the
> >>> less echoed back as sja1000 does not give any indication when a single
> >>> transmission has failed.
> >>
> >> Uhh... can any of the SJA1000 gurus comment to this?
> >
> > The commit message is incomplete and confusing, I agree. The patch
> > obviously implements listen-only and one-shot mode. From the data sheet:
> >
> > LOM FUNCTION:
> >    1: listen only; in this mode the CAN controller would
> >    give no acknowledge to the CAN-bus, even if a message is received
> >    successfully; the error counters are stopped at the current value
> >    normal
> >
> > Single-shot:
> >    Setting the command bits CMR.0 (TR) and CMR.1 (AT) simultaneously
> >    results in sending the transmit message once. No re-transmission will
> >    be performed in the event of an error or arbitration lost
> >    (single-shot transmission).
> 
> The limitation is that when a one-shot message transmission fails, a 
> Transmit Interrupt is generated and as a consequence can_get_echo_skb is 
> called. Thus a can frame is echoed back even when the transmission fails 
> (instead of being discarded). When one-shot mode is enabled no other 
> interrupts are generated on a failed transmission. Thus, as far as I can 
> see, there is no way for the failed frames not to be echoed back locally 
> in this case.
> 

I worked around this limitation in the janz-ican3 driver by writing my
own version of the can_put_echo_skb() and can_get_echo_skb() functions.
Also notice the skb_dequeue() in ican3_handle_cevtind(), which handles
the transmission failure case.

It is probably possible to modify the SJA1000 driver to do something
similar.

Hope it helps,
Ira

> I'll try to word it better in the next version of the patch.
> 
> >> Some write-more-readable-code comments inline :)
> >>
> >>> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> >>> ---
> >>>   drivers/net/can/sja1000/sja1000.c |   10 +++++++---
> >>>   1 files changed, 7 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
> >>> index 4c4f33d..cc771d9 100644
> >>> --- a/drivers/net/can/sja1000/sja1000.c
> >>> +++ b/drivers/net/can/sja1000/sja1000.c
> >>> @@ -141,6 +141,7 @@ static void set_normal_mode(struct net_device *dev)
> >>>   	struct sja1000_priv *priv = netdev_priv(dev);
> >>>   	unsigned char status = priv->read_reg(priv, REG_MOD);
> >>>   	int i;
> >>> +	u8 normal = priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY ? MOD_LOM : 0;
> >
> >> What about a more readable:
> >> 	u8 normal = 0;
> >>
> >> 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> >> 		normal = MOD_LOM;
> >>
> >>>
> >>>   	for (i = 0; i < 100; i++) {
> >>>   		/* check reset bit */
> >>> @@ -156,7 +157,7 @@ static void set_normal_mode(struct net_device *dev)
> >>>   		}
> >>>
> >>>   		/* set chip to normal mode */
> >>> -		priv->write_reg(priv, REG_MOD, 0x00);
> >>> +		priv->write_reg(priv, REG_MOD, normal);
> >>>   		udelay(10);
> >>>   		status = priv->read_reg(priv, REG_MOD);
> >>>   	}
> >>> @@ -278,6 +279,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
> >>>   	canid_t id;
> >>>   	uint8_t dreg;
> >>>   	int i;
> >>> +	u8 oneshot;
> >>>
> >>>   	if (can_dropped_invalid_skb(dev, skb))
> >>>   		return NETDEV_TX_OK;
> >>> @@ -310,7 +312,8 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
> >>>
> >>>   	can_put_echo_skb(skb, dev, 0);
> >>>
> >>> -	sja1000_write_cmdreg(priv, CMD_TR);
> >>> +	oneshot = (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT) ? CMD_AT : 0;
> >>> +	sja1000_write_cmdreg(priv, CMD_TR | oneshot);
> >>
> >> something simmilar here, too
> >
> > I would prefer here:
> >
> > 	u8 reg = CMD_TR; (or cmd or cmdreg)
> >
> > 	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> > 		reg |= CMD_AT;
> >
> > A cached value seem overkill. Similar above.
> 
> Thanks for the input from both of you! I'll take care of that.
> 
> 
> > Andreas, I'm curious what you are using the one-shot mode for.
> 
> In situations when the current view of some information is repeatedly 
> being sent there is no use in trying to resend an old view of the 
> information. In such a case it would be nice to allow for discarding 
> failed frames using one-shot mode.
> 
> Cheers,
> Andreas
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
