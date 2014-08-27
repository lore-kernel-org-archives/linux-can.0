From: David Jander <david@protonic.nl>
Subject: [PATCH 0/3] Decrease likelyhood of RX overruns
Date: Wed, 27 Aug 2014 11:58:04 +0200
Message-ID: <1409133487-23367-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:17911 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933387AbaH0KTh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Aug 2014 06:19:37 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org

This patch series actually fixes 3 related issues, greatly improving
resilence under high latency conditions (e.g. non-real-time kernels).
This reduces the likelyhood of receive underruns when many back-to-back
messages are received at high bitrates.

The first patch is actually a fix to a bug that causes overruns being missed.

The second patch swaps the use of the RX FIFO for using the whole MB area
as a receive buffer and off-loading this buffer area directly in the IRQ-
handler.

The last patch is part of the implementation of errata ERR005829 for the
flexcan peripheral in i.MX6 SoCs. The first steps of this errata workaround
are implicitely included in patch 2 already.

David Jander (3):
  can: flexcan.c: Correctly initialize mailboxes
  can: flexcan.c: Re-write receive path to use MB queue instead of FIFO
  can: flexcan.c: Implement last step of workaround for errata ERR005829
