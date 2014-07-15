From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v4 2/2] can: m_can: add Bosch M_CAN controller support
Date: Tue, 15 Jul 2014 14:28:34 +0800
Message-ID: <20140715062833.GB9796@shlinux1.ap.freescale.net>
References: <1405338041-19945-1-git-send-email-b29396@freescale.com>
 <1405338041-19945-2-git-send-email-b29396@freescale.com>
 <53C3D155.8080005@gmail.com> <53C3D4BF.8030409@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:35798
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757766AbaGOGd3 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 Jul 2014 02:33:29 -0400
Content-Disposition: inline
In-Reply-To: <53C3D4BF.8030409@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com

On Mon, Jul 14, 2014 at 03:01:51PM +0200, Marc Kleine-Budde wrote:
[...]
> >> +#define IR_ERR_STATE    (IR_BO | IR_EW | IR_EP)
> >> +#define IR_ERR_LEC    (IR_STE    | IR_FOE | IR_ACKE | IR_BE | IR_CRCE)
> >> +#define IR_ERR_BUS    (IR_ERR_LEC | IR_WDI | IR_ELO | IR_BEU | IR_BEC \
> >> +            | IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | IR_RF1L \
> >> +            | IR_RF0L)
> 
> Please move the '|' to the end of the line.
> 

Got it.

Regards
Dong Aisheng
