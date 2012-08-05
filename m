From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: [PATCH can-next 0/5] can: add LED trigger support to common devices
Date: Sun, 5 Aug 2012 16:48:14 +0200
Message-ID: <20120805144814.GA2804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43519 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab2HEOqG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 5 Aug 2012 10:46:06 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-kernel@vger.kernel.org

Hello,

this patch series adds support for LED triggers to CAN devices commonly
found on SoC architectures, using the support code recently merged in
Marc's can-next tree.

I actually modified only drivers who's devices may be commonly found
in embedded platforms with associated cpu-controlled LEDs, let me know
if I missed anything.

As I lack the actual hardware, these patches are *compile tested* only,
so I hope to get some test on real hardware from other developers,
through the modifications should be quite straightforward.

Also, I'll let you know that I may not have access to my email during
the next week, so if you write me, I'll try to answer as soon as
possible.

Fabio


Fabio Baltieri (5):
      can: at91_can: add LED trigger support
      can: ti_hecc: add LED trigger support
      can: c_can: add LED trigger support
      can: mcp251x: add LED trigger support
      can: sja1000: add LED trigger support

 at91_can.c        |   10 ++++++++++
 c_can/c_can.c     |   17 ++++++++++++++++-
 mcp251x.c         |   23 +++++++++++++++++++----
 sja1000/sja1000.c |   17 ++++++++++++++++-
 ti_hecc.c         |   10 ++++++++++
 5 files changed, 71 insertions(+), 6 deletions(-)
