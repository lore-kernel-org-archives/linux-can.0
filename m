From: David Jander <david@protonic.nl>
Subject: Re: RFC: [PATCH v2] can: flexcan: Implement errata ERR005829
Date: Thu, 18 Sep 2014 15:50:18 +0200
Message-ID: <20140918155018.7bef3ba3@archvile>
References: <1409755642-28233-1-git-send-email-david@protonic.nl>
	<54081940.6060402@pengutronix.de>
	<20140904104440.5766d764@archvile>
	<5418238B.6010600@pengutronix.de>
	<20140916142846.2ae8335c@archvile>
	<54184945.90900@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:22733 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777AbaIRNtw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 18 Sep 2014 09:49:52 -0400
In-Reply-To: <54184945.90900@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Tue, 16 Sep 2014 16:29:25 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 09/16/2014 02:28 PM, David Jander wrote:
> > Is it time to revisit my other patch(es) yet? If so, from where should I
> > pull the base?
> 
> Please review the flexcan series (v4) I just sent around. That will go
> into net/master then.

Looks good.

> For new the new flexcan features please use this as your base:
> 
> git://gitorious.org/linux-can/linux-can-next.git flexcan-next

Thanks. See my new patch v4 I just sent. I rebased on top of that and tested
it briefly. Seems to work fine.

Best regards,

-- 
David Jander
Protonic Holland.
