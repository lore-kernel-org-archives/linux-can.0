From: Richard Weinberger <richard@sigma-star.at>
Subject: Re: [PATCH v2 2/3] can: cc770: Stop queue on NETDEV_TX_BUSY
Date: Mon, 12 Feb 2018 21:55:35 +0100
Message-ID: <1798644.r6m8FyMpzN@blindfold>
References: <20180130165649.22732-1-andri.yngvason@marel.com> <d62fdd54-4d06-db35-a0a0-b69759286bb5@grandegger.com> <8cd354eb-b610-b309-2a3f-a345f56aaecf@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lilium.sigma-star.at ([109.75.188.150]:33250 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753817AbeBLUy3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Feb 2018 15:54:29 -0500
In-Reply-To: <8cd354eb-b610-b309-2a3f-a345f56aaecf@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org, mkl@pengutronix.de, sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com, patric.thysell@br-automation.com

Am Montag, 12. Februar 2018, 21:44:11 CET schrieb Wolfgang Grandegger:
> Am 12.02.2018 um 21:37 schrieb Wolfgang Grandegger:
> > Hello,
> > 
> > Am 12.02.2018 um 20:40 schrieb Richard Weinberger:
> >> Andri,
> >> 
> >> Am Dienstag, 30. Januar 2018, 17:56:48 CET schrieb Andri Yngvason:
> >>> If the queue is not stopped, the start_xmit function will continue to be
> >>> called until the driver or the system is reset.
> >>> 
> >>> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> >>> ---
> >>>   drivers/net/can/cc770/cc770.c | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>> 
> >>> diff --git a/drivers/net/can/cc770/cc770.c
> >>> b/drivers/net/can/cc770/cc770.c
> >>> index 9fed163..12d3b89 100644
> >>> --- a/drivers/net/can/cc770/cc770.c
> >>> +++ b/drivers/net/can/cc770/cc770.c
> >>> @@ -405,6 +405,7 @@ static netdev_tx_t cc770_start_xmit(struct
> >>> sk_buff *skb,
> >>> struct net_device *dev)
> >>> 
> >>>       if ((cc770_read_reg(priv,
> >>>                   msgobj[mo].ctrl1) & TXRQST_UNC) == TXRQST_SET) {
> >>> +        netif_stop_queue(dev);
> >>>           netdev_err(dev, "TX register is still occupied!\n");
> >>>           return NETDEV_TX_BUSY;
> >>>       }
> >> 
> >> I see that some can drivers stop the queue, others not.
> >> What exactly is the problem in this case?
> > 
> > Stopping the queue and returning NETDEV_TX_BUSY does make little sense.
> > NETDEV_TX_BUSY will tell the upper layer to retry asap. In general that
> > case should be avoided by stopping the queue earlier. Actually,
> > netif_stop_queue(dev) is called directly after the if block above,
> > which means that "TX register is still occupied" indicates an error/bug.
> > I think there is a race somewhere.
> 
> If you run on "-rt", the IRQ is threaded. This would explain the issue.
> 
> Wolfgang.

Andri, do you see the "TX register is still occupied!" error message?
In my case, I never saw it while working on the rt-related stalls during my 
tests.

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
