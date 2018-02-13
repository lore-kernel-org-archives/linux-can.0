From: Richard Weinberger <richard@sigma-star.at>
Subject: Re: [PATCH v2 1/3] can: cc770: Remove redundant IRQ ack
Date: Tue, 13 Feb 2018 11:35:49 +0100
Message-ID: <13808474.RQEnJ19omo@blindfold>
References: <20180130165649.22732-1-andri.yngvason@marel.com> <2795059.IeN8S1rsHy@blindfold> <151851733257.10946.11726494714017260046@maxwell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lilium.sigma-star.at ([109.75.188.150]:48488 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933865AbeBMKef (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Feb 2018 05:34:35 -0500
In-Reply-To: <151851733257.10946.11726494714017260046@maxwell>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, wg@grandegger.com, sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com, patric.thysell@br-automation.com

Andri,

Am Dienstag, 13. Februar 2018, 11:22:12 CET schrieb Andri Yngvason:
> Hi Richard,
> 
> Quoting Richard Weinberger (2018-02-12 19:41:48)
> 
> > Andri,
> > 
> > Am Dienstag, 30. Januar 2018, 17:56:47 CET schrieb Andri Yngvason:
> > > This has been reported to cause stalls on rt-linux.
> > > 
> > > Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> > > ---
> > > 
> > >  drivers/net/can/cc770/cc770.c | 15 ---------------
> > >  1 file changed, 15 deletions(-)
> > > 
> > > diff --git a/drivers/net/can/cc770/cc770.c
> > > b/drivers/net/can/cc770/cc770.c
> > > index 1e37313..9fed163 100644
> > > --- a/drivers/net/can/cc770/cc770.c
> > > +++ b/drivers/net/can/cc770/cc770.c
> > > @@ -447,15 +447,6 @@ static netdev_tx_t cc770_start_xmit(struct sk_buff
> > > *skb, struct net_device *dev)
> > > 
> > >       stats->tx_bytes += dlc;
> > > 
> > > -
> > > -     /*
> > > -      * HM: We had some cases of repeated IRQs so make sure the
> > > -      * INT is acknowledged I know it's already further up, but
> > > -      * doing again fixed the issue
> > > -      */
> > > -     cc770_write_reg(priv, msgobj[mo].ctrl0,
> > > -                     MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
> > > -
> > > 
> > >       return NETDEV_TX_OK;
> > >  
> > >  }
> > > 
> > > @@ -684,12 +675,6 @@ static void cc770_tx_interrupt(struct net_device
> > > *dev,
> > > unsigned int o) /* Nothing more to send, switch off interrupts */
> > > 
> > >       cc770_write_reg(priv, msgobj[mo].ctrl0,
> > >       
> > >                       MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
> > > 
> > > -     /*
> > > -      * We had some cases of repeated IRQ so make sure the
> > > -      * INT is acknowledged
> > > -      */
> > > -     cc770_write_reg(priv, msgobj[mo].ctrl0,
> > > -                     MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
> > > 
> > >       stats->tx_packets++;
> > >       can_get_echo_skb(dev, 0);
> > 
> > I saw that stalls too.
> > But instead of just removing these writes I suggest adding a quirk for the
> > can card where they cause trouble.
> > Maybe Wolfgang can give more details why they are here.
> 
> I did not run into this issue myself, I just included this because Patric
> sent me this patch for an issue that you were having. I did not know the
> original author, otherwise I would have added a "Suggested-by".

I'm the author of that debug patch. :-)
While reviewing the driver these acks alerted me and after removing them the 
can card no longer stopped working after some time.

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
