From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 3/3] can: flexcan.c: Implement last step of workaround
 for errata ERR005829
Date: Tue, 2 Sep 2014 13:36:38 +0200
Message-ID: <20140902133638.7876ae3d@archvile>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>
	<1409133487-23367-4-git-send-email-david@protonic.nl>
	<5405A9F7.5090004@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:5272 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbaIBLg0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 07:36:26 -0400
In-Reply-To: <5405A9F7.5090004@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

On Tue, 02 Sep 2014 13:28:55 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 08/27/2014 11:58 AM, David Jander wrote:
> > It is not clear if this errata only applies to i.MX6, but the impact of
> > the workaround should be minimal. Basically it comes down to reserving
> > mailbox 0 as a permanently inactive MB and writing twice to its C/S field
> > on every message transmit.
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> 
> Please fix this errata in one patch exactly. Please fix the errata
> before introducing a new feature, i.e. rewriting of the RX path.

Ok, I will try to split this out in the next version.

Best regards,

-- 
David Jander
Protonic Holland.
