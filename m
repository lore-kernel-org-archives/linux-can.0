From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: peak_pci: TX Frame Loss
Date: Tue, 22 Dec 2015 11:51:08 +0000
Message-ID: <20151222115108.GA9052@maxwell.marel.net>
References: <20151202180937.19023.96078@maxwell.marel.net>
 <565F4439.3050309@hartkopp.net>
 <565FE31D.8060606@hartkopp.net>
 <20151203112319.GA5230@maxwell.marel.net>
 <56602B1D.90601@pengutronix.de>
 <5666AF26.2080806@peak-system.com>
 <20151208105026.GA13146@maxwell.marel.net>
 <5666C242.8090506@peak-system.com>
 <20151208122455.GA16567@maxwell.marel.net>
 <56790625.6060908@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0056.outbound.protection.outlook.com ([157.55.234.56]:60288
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752961AbbLVLxB (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 22 Dec 2015 06:53:01 -0500
Content-Disposition: inline
In-Reply-To: <56790625.6060908@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, wg@grandegger.com, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com

On Tue, Dec 22, 2015 at 09:13:25AM +0100, Stephane Grosjean wrote:
> Hi Andri,
> 
> We're currently investigating hard onto this issue. On my side, I'm checking
> the software part and I'd like to discuss with you about one point:
> 
> AFAIK the "sja1000_start_xmit()" function calls are really serialized by the
> network core. So there's actually no need of any lock to share the access of
> the SJA1000 registers, regarding the Tx path. Right. But I don't see in this
> function any test condition over the Transmit Status bit before writing the
> outgoing CAN frame (aka "reg[SJA1000_SR] & SR_TS").
>
I tried adding it and it didn't do anything. See original message.
> 
> Without testing the Transmit Status bit before writing, wouldn't it be
> possible that any 2nd task overwrite a 1st frame written by a 1st task
> before it has been really sent by the SJA1000?
> 
I don't think so. The _start_xmit() call is scheduled via the wait queue, so
_start_xmit() being called concurrently would be a sign of a misbehaving wait
queue, but like I said, adding the check did not yield any results.

Thanks & Merry Xmas!
Andri
