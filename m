From: Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: [PATCH 0/3] Fixes for kvaser_usb driver
Date: Tue, 21 Nov 2017 08:22:25 +0100
Message-ID: <20171121072228.7570-1-jimmyassarsson@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43233 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbdKUHWh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Nov 2017 02:22:37 -0500
Received: by mail-lf0-f67.google.com with SMTP id 73so12880731lfu.10
        for <linux-can@vger.kernel.org>; Mon, 20 Nov 2017 23:22:36 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>

The first patch fix two missing free calls in error paths. The second patch
fix a bad comparison between signed and unsigned integer, causing undesired
behaviour. The third patch will ratelimit error prinouts, if incomplete USB
messages are received. My kernel log got flooded with these error messages,
when I encountered the bug described in the previous patch.

Jimmy Assarsson (3):
  can: kvaser_usb: free buf in error paths
  can: kvaser_usb: Fix comparison bug in kvaser_usb_read_bulk_callback()
  can: kvaser_usb: ratelimit errors if incomplete messages are received

 drivers/net/can/usb/kvaser_usb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.15.0

