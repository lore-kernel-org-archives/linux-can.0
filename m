Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B75C001DE
	for <linux-can@archiver.kernel.org>; Sat, 15 Jul 2023 11:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGOLch (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 15 Jul 2023 07:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGOLcg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 15 Jul 2023 07:32:36 -0400
X-Greylist: delayed 411 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Jul 2023 04:32:31 PDT
Received: from out-45.mta1.migadu.com (out-45.mta1.migadu.com [IPv6:2001:41d0:203:375::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0396F35A2
        for <linux-can@vger.kernel.org>; Sat, 15 Jul 2023 04:32:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689420338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GgBO3Tv3/nsdAMW9tPe+lkrolQmS53lBma06VUwvC6g=;
        b=BGr2PYcU7+0kv8jkoFJfhlV6lSU6LE26y/Zn4QHuOARBOFVEufACvFoaFPQ03GKTgy0Orf
        D9/R7Q9AAugyYX7ImfpFW7VUj5RNdddS7CMgaq4Os/2p39UHy9va2IIB6sJTsFNRxlNgm2
        LJY4KGVzSO6bgrk1rmhGB/tIbBIEBQ5NVuWvexlKoh5s60FewFQBN4jGWgHqSyOTjBWcYn
        1M7mfwmDg8rcM1SC3Yyp5T0a8M7sqF1Pq1SS0C4VEz14rzgc7BOeMnSFiZXuuRNmA005kd
        EAWHZS2Mmr7LIB5hiXP8gYu3IBVMlJEJCFLUf56reT01yZjHq/ASdstF4vIFnA==
From:   Jookia <contact@jookia.org>
To:     linux-sunxi@lists.linux.dev
Cc:     John Watts <contact@jookia.org>, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 0/4] Add support for Allwinner D1 CAN controllers
Date:   Sat, 15 Jul 2023 21:25:18 +1000
Message-ID: <20230715112523.2533742-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: John Watts <contact@jookia.org>

This patch series adds support for the Allwinner D1 CAN controllers.
It requires adding a new device tree compatible and driver support to
work around some hardware quirks.

John Watts (4):
  dt-bindings: net: can: Add support for Allwinner D1 CAN controller
  riscv: dts: allwinner: d1: Add CAN controller nodes
  can: sun4i_can: Add send support for the Allwinner D1
  can: sun4i_can: Correctly set acceptance registers on the D1

 .../net/can/allwinner,sun4i-a10-can.yaml      |  6 ++--
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 30 +++++++++++++++++++
 drivers/net/can/Kconfig                       |  4 +--
 drivers/net/can/sun4i_can.c                   | 22 ++++++++++++--
 4 files changed, 55 insertions(+), 7 deletions(-)

-- 
2.41.0

