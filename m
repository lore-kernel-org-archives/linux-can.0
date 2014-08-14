From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH 4/4] can: flexcan: Disable error irq when in error passive
Date: Thu, 14 Aug 2014 15:19:37 +0200
Message-ID: <2700138.iRYuM1TADC@ws-stein>
References: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com> <1407850987-26707-4-git-send-email-alexander.stein@systec-electronic.com> <53EC9B17.80600@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:39432 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754297AbaHNNXF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Aug 2014 09:23:05 -0400
In-Reply-To: <53EC9B17.80600@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Thursday 14 August 2014 13:18:47, Marc Kleine-Budde wrote:
> On 08/12/2014 03:43 PM, Alexander Stein wrote:
> > If the error irq is enabled and the hardware is trying to send a CAN
> > message to an open bus it will receive a lot of acknowledge errors and
> > generating lots of interrupts. So error interrupts are disabled when
> > entering error passive and reenable them when leaving error passive.
> > We can only leave error passive by receiving CAN frames in which case NAPI
> > is scheduled anyway or by sending more CAN frames when send is possible
> > again. But with the transition of error counters from 96 to 95 the flags
> > TX_WRN and RX_WRN are gone again, so we need to remember the flags state
> > to detect a change there.
> 
> There are use cases where the error interrupts even when in passive mode
> are essential. You have a use case, where you'd like to turn them off
> completely. Have you had a look at the bus error limiting patches?

Do you mean "[PATCH v7] flexcan: add err_irq handler for flexcan" from Zhao Qiang?

Best regards,
Alexander
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

