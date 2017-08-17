From: GBert <info@gerhard-bertelsmann.de>
Subject: [PATCH 0/2] can: sun4i: bug fixes
Date: Thu, 17 Aug 2017 15:59:47 +0200
Message-ID: <cover.1502971879.git.info@gerhard-bertelsmann.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:59232 "EHLO mail.rdts.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752944AbdHQOFj (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 17 Aug 2017 10:05:39 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

The patchset fixes two issues for Allwinner A10/A20 CAN IP

Gerhard Bertelsmann (2):
  can: sun4i: fix overrun
  can: sun4i: fix loopback mode

 drivers/net/can/sun4i_can.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
1.7.9.5

