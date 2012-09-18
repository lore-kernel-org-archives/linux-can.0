From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2] can: sja1000: Add support for listen-only mode and
 one-shot mode
Date: Tue, 18 Sep 2012 20:27:07 +0200
Message-ID: <5058BCFB.7010902@grandegger.com>
References: <5058994E.8000501@gaisler.com> <1347986041-5358-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:43502 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab2IRS1U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 14:27:20 -0400
In-Reply-To: <1347986041-5358-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

On 09/18/2012 06:34 PM, Andreas Larsson wrote:
> One-shot mode correctly refrains from trying to resend frames that
> fail. However, all can frames are echoed back by can_get_echo_skb
> regardless of whether they were transmitted successfully or not. When
> in one-shot mode, sja1000 generates a transmit interrupt both for a
> successful and a failed transmission. It is not possible to
> distinguish between the cases and therefore not possible to refrain
> from echoing back a frame that was not transmitted successfully.

Did you check the transmission complete status bit (SR_TCS)? From the
data sheet it's not 100% clear if it should work with single-shot
messages as well.

Wolfgang.


