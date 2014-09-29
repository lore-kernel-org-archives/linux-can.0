From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue instead of FIFO
Date: Mon, 29 Sep 2014 15:29:28 +0200
Message-ID: <8124948.gcTnPkg5PL@ws-stein>
References: <1411995175-13540-1-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:39371 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753534AbaI2Nhe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Sep 2014 09:37:34 -0400
In-Reply-To: <1411995175-13540-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Monday 29 September 2014 14:52:55, David Jander wrote:
> The FlexCAN controller has a RX FIFO that is only 6 messages deep, and a
> mailbox space capable of holding up to 63 messages.
> 
> This space was largely unused, limiting the permissible latency from interrupt
> to NAPI to only 6 messages. This patch uses all available MBs for message
> reception and frees the MBs in the IRQ handler to greatly decrease the
> likelihood of receive overruns.
> 
> Signed-off-by: David Jander <david@protonic.nl>

AFAICT, If you disable Rx FIFO mode, you essentially break RTR reception on (at least) i.MX3. Please refere to the reference manual 24.4.8.1 Remote Frames.
Vybrid and i.MX6 (not sure about i.MX5) seem to have more features about RTR reception.

Best regards,
Alexander

