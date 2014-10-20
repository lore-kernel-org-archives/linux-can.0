From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 06/15] can: rx-fifo: Increase MB size limit from 32 to
 64
Date: Mon, 20 Oct 2014 08:14:51 +0200
Message-ID: <20141020081451.5bf79051@archvile>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
	<1412956020-21489-7-git-send-email-david@protonic.nl>
	<20141019212549.GB428@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:1288 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbaJTGOb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Oct 2014 02:14:31 -0400
In-Reply-To: <20141019212549.GB428@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

On Sun, 19 Oct 2014 23:25:50 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On Fri, Oct 10, 2014 at 05:46:51PM +0200, David Jander wrote:
> > Signed-off-by: David Jander <david@protonic.nl>
> 
> Please move to the beginning of the series, so that I can squash all fifo
> related patches into one. So that we have just a single (hopefully perfect)
> rx-fifo patch.

Ok, will reorder the patches.

Best regards,

-- 
David Jander
Protonic Holland.
