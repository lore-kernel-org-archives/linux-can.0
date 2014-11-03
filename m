From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 12/15] can: flexcan: Add support for RX-FIFO.
Date: Mon, 3 Nov 2014 13:55:32 +0100
Message-ID: <20141103135532.7d0134bd@archvile>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
	<1412956020-21489-13-git-send-email-david@protonic.nl>
	<5457665D.9030008@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:4368 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbaKCMy6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 07:54:58 -0500
In-Reply-To: <5457665D.9030008@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

On Mon, 03 Nov 2014 12:26:21 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 10/10/2014 05:46 PM, David Jander wrote:
> > This adds support for RX-FIFO simulating a FIFO from a linear array of
> > message- boxes. This breaks RTR reception on flexcan older than V10.
> 
> Breaking things in one patch and fixing them later is not a good idea.
> Please squash this patch into 4/15, so that we don't have an
> intermediate non-rx-fifo flexcan driver.

Ok. I just thought that this series would be heavily squashed anyway before
moving further upstream....
Will try to squash that part.

Best regards,

-- 
David Jander
Protonic Holland.
