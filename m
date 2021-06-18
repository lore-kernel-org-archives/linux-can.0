Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354F6C48BDF
	for <linux-can@archiver.kernel.org>; Fri, 18 Jun 2021 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193D56121D
	for <linux-can@archiver.kernel.org>; Fri, 18 Jun 2021 08:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhFRIVe (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 18 Jun 2021 04:21:34 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:53650 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbhFRIV1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 04:21:27 -0400
Received: from localhost.localdomain ([114.149.34.46])
        by mwinf5d28 with ME
        id JYKA2500J0zjR6y03YKGcE; Fri, 18 Jun 2021 10:19:17 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 18 Jun 2021 10:19:17 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 0/2] Stop showing data bittiming if FD is turned off
Date:   Fri, 18 Jun 2021 17:19:02 +0900
Message-Id: <20210618081904.141114-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

While doing tests on TDC, I witnessed a strange behavior: the data
bittiming are still displayed after turning fd to off.

$ ip link set can0 type can bitrate 500000 dbitrate 2000000 fd on
$ ip link set can0 type can bitrate 500000 fd off
$ ip --details link show can0
1:  can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0 minmtu 0 maxmtu 0 
    can state STOPPED restart-ms 0 
	  bitrate 500000 sample-point 0.875
	  tq 12 prop-seg 69 phase-seg1 70phase-seg2 20  sjw 1 brp 1
	  ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
	  dbitrate 2000000 dsample-point 0.750
	  dtq 12 dprop-seg 14 dphase-seg1 15 dphase-seg2 10 dsjw 1 dbrp 1
	  tdcv 0 tdco 30 tdcf 0
	  ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32 brp_inc 1
	  tdcv_max 0 tdco_max 127 tdcf_max 127
	  clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 

This series comports two patches: one for the data bittiming parameters, one of the tdc parameters.

If possible, I wish to have the second patch squashed in the netlink
TDC series. I put comments after the --- cutter.


Vincent Mailhol (2):
  can: netlink: clear data_bittiming if fd is turned off
  can: netlink: clear tdc if fd is turned off

 drivers/net/can/dev/netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.31.1

