From: Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: [PATCH 0/2] can: kvaser_usb: Small fixes
Date: Tue, 24 Oct 2017 12:23:27 +0200
Message-ID: <20171024102329.28526-1-jimmyassarsson@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:57224 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932428AbdJXKYO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 24 Oct 2017 06:24:14 -0400
Received: by mail-lf0-f65.google.com with SMTP id 90so23368817lfs.13
        for <linux-can@vger.kernel.org>; Tue, 24 Oct 2017 03:24:13 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>

Fix two issues in the kvaser_usb driver.

Jimmy Assarsson (2):
  can: kvaser_usb: Correct return value in printout
  can: kvaser_usb: Ignore CMD_FLUSH_QUEUE_REPLY messages

 drivers/net/can/usb/kvaser_usb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.14.2

