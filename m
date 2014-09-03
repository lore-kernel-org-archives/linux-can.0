From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 2/3] can: flexcan.c: Re-write receive path to use MB
 queue instead of FIFO
Date: Wed, 3 Sep 2014 17:42:17 +0200
Message-ID: <20140903174217.60c03741@archvile>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>
	<1409133487-23367-3-git-send-email-david@protonic.nl>
	<5405AA50.6040100@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:9298 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932333AbaICPmG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Sep 2014 11:42:06 -0400
In-Reply-To: <5405AA50.6040100@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

On Tue, 02 Sep 2014 13:30:24 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 08/27/2014 11:58 AM, David Jander wrote:
> > The FlexCAN controller has a RX FIFO that is only 6 messages deep, and a
> > mailbox space capable of holding up to 63 messages.
> > This space was largely unused, limiting the permissible latency from
> > interrupt to NAPI to only 6 messages. This patch uses all available MBs
> > for message reception and frees the MBs in the IRQ handler to greatly
> > decrease the likelihood of receive overruns.
> 
> What about the order of the incoming CAN frames? Is it still preserved?
> 
> You make use of the CTRL2 register, which is not present on some older
> (but supported) flexcan IP cores. You increase FLEXCAN_MCR_MAXMB to
> 0x40, which is not supported on older IPs. The register rximr, is also
> not present on older cores. Don't break support for the older CAN cores.

I've checked the RM of i.MX53, i.MX28 and i.MX25, and they all seem to support
the rximr registers. Which IP version doesn't support them (that is still
supported by this driver anyway)?

AFAICS, the only unsupported feature on older SoC's is the CTRL2 register, and
the fact that the documentation says the MCR_MAXMB field is only 6 bits wide,
right?

Best regards,

-- 
David Jander
Protonic Holland.
