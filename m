From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 0/3] remove do_get_state() callback
Date: Mon, 07 Oct 2013 21:25:31 +0200
Message-ID: <52530AAB.4040808@grandegger.com>
References: <1381157168-24588-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44040 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab3JGTZd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 15:25:33 -0400
In-Reply-To: <1381157168-24588-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

On 10/07/2013 04:46 PM, Marc Kleine-Budde wrote:
> Hello,
> 
> this patch series removes the do_get_state() callback from the driver
> interface, as it is not needed to get the state of the interface.

I just realized that Max's GS-USB driver would require it because the
device does not send asynchronous error and state change messages. But
thinking more about it, I tend to nack such a solution as it breaks many
user space programs.

Wolfgang.


