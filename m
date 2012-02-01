From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 00/12] CAN updates for net-next, please review
Date: Wed, 01 Feb 2012 10:43:15 +0100
Message-ID: <4F290933.9060202@grandegger.com>
References: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:55326 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab2BAJnX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 04:43:23 -0500
In-Reply-To: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc,

On 01/31/2012 10:46 PM, Marc Kleine-Budde wrote:
> Hello,
> 
> I collected all pending patches from the mailinglist in order to push to
> davem. Are there some patches missing, which are rerady to go upstream?

The patch "[PATCH 04/12] can: replace the dev_dbg/info/err/... with the
new netdev_xxx macros" does have issues. Did you already apply it to
linux-can-next? Shoud I send a v2 or a followup patch? I have also
another fix for the ti_hecc driver, which I will send in a few minutes.

Thanks,

Wolfgang.
