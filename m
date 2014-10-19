From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 06/15] can: rx-fifo: Increase MB size limit from 32 to 64
Date: Sun, 19 Oct 2014 23:25:50 +0200
Message-ID: <20141019212549.GB428@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
 <1412956020-21489-7-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53818 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbaJSVZz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 19 Oct 2014 17:25:55 -0400
Content-Disposition: inline
In-Reply-To: <1412956020-21489-7-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

On Fri, Oct 10, 2014 at 05:46:51PM +0200, David Jander wrote:
> Signed-off-by: David Jander <david@protonic.nl>

Please move to the beginning of the series, so that I can squash all fifo
related patches into one. So that we have just a single (hopefully perfect)
rx-fifo patch.

regards,
Marc

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
