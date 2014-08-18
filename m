From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH 2/4] can: flexcan: Detect error passive state change
Date: Mon, 18 Aug 2014 08:05:47 +0200
Message-ID: <2862259.Nup8ES7SpR@ws-stein>
References: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com> <1407850987-26707-2-git-send-email-alexander.stein@systec-electronic.com> <53EDBFAA.3070809@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:37140 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750911AbaHRGJJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Aug 2014 02:09:09 -0400
In-Reply-To: <53EDBFAA.3070809@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Friday 15 August 2014 10:07:06, Marc Kleine-Budde wrote:
> On 08/12/2014 03:43 PM, Alexander Stein wrote:
> > Assuming there is no CAN frame reception or CAN_CTRLMODE_BERR_REPORTING:
> > If the Tx error counter steps from 127 to 128 the hardware enters error
> > passive. But in this case the FLEXCAN_ESR_ERR_STATE bits are unset:
> > TWRN_INT and RWRN_INT are not set during the transition from <96 to >=96.
> 
> Which hardware are you using? According to the documentation TWRN_INT
> and RWRN_INT _are_ actually set during the transition from <96 to >=96.

Meh, wrong case description... What I wanted to write:
TWRN_INT and RWRN_INT are _only_ set during the transition from <96 to >=96.
And for the records I'm using a i.MX35.

> > So we do not schedule NAPI thus not evaluating the error counters.
> > So we also check TX_WRN and RX_WRN in order to detect error passive.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > ---
> >  drivers/net/can/flexcan.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> > index fd79dd40840b..5e391ec70a2b 100644
> > --- a/drivers/net/can/flexcan.c
> > +++ b/drivers/net/can/flexcan.c
> > @@ -721,7 +721,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
> >  	 * - bus error IRQ and bus error reporting is activated
> >  	 */
> >  	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
> > -	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> > +	    (reg_esr & (FLEXCAN_ESR_ERR_STATE |
> > +			FLEXCAN_ESR_TX_WRN | FLEXCAN_ESR_RX_WRN)) ||
> >  	    flexcan_has_and_handle_berr(priv, reg_esr)) {
> >  		/*
> >  		 * The error bits are cleared on read,
> > 
> 
> Marc
> 
> 

-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

