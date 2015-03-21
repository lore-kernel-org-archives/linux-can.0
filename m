From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: [PATCH -stable 0/3] Bugfixes for the kvaser_usb module
Date: Sat, 21 Mar 2015 04:03:21 +0200
Message-ID: <1426903404-22925-1-git-send-email-ahmed.darwish@valeo.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34766 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbCUCEL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Mar 2015 22:04:11 -0400
Received: by wibg7 with SMTP id g7so1856799wib.1
        for <linux-can@vger.kernel.org>; Fri, 20 Mar 2015 19:04:10 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Olivier Sobrie <olivier@sobrie.be>
Cc: Linux-CAN <linux-can@vger.kernel.org>, "Ahmed S. Darwish" <ahmed.darwish@valeo.com>

From: "Ahmed S. Darwish" <ahmed.darwish@valeo.com>

Hi Marc,

This is a series of kvaser_usb bugfixes, backported for -stable
and generated against v3.19. It should apply cleanly on most
of the -stable kernel trees out there.

The patches needed simple backporting since `kvaser_usb' in all
earlier kernels does not have the can_change_state() changes or
the extra code for USBCan-II hardware models.

Each patch contains a reference in its log to the corresponding
upstream commit.

I've verified that each patch matches exactly, _hunk for hunk_,
its corresponding upstream commit. Nonetheless, I don't have a
pure Kvaser Leaf hardware at hand; someone with a Leaf-based
model should give them a quick smoke test (Olivier Sobrie?)

Thanks,

Ahmed S. Darwish (3):
  can: kvaser_usb: Avoid double free on URB submission failures
  can: kvaser_usb: Read all messages in a bulk-in URB buffer
  can: kvaser_usb: Fix tx queue start/stop race conditions

 drivers/net/can/usb/kvaser_usb.c |  131 ++++++++++++++++++++++++--------------
 1 files changed, 82 insertions(+), 49 deletions(-)

-- 
1.7.7.6

