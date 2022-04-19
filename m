Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3A7C433F5
	for <linux-can@archiver.kernel.org>; Tue, 19 Apr 2022 11:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349602AbiDSLoe (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352300AbiDSLnJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Apr 2022 07:43:09 -0400
X-Greylist: delayed 97 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 04:39:51 PDT
Received: from mail1.wrs.com (unknown-3-146.windriver.com [147.11.3.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39E72DF5;
        Tue, 19 Apr 2022 04:39:49 -0700 (PDT)
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 23JBdZV3005115
        (version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 19 Apr 2022 04:39:36 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 23JBdYg3000737
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Apr 2022 04:39:34 -0700 (PDT)
Received: from otp-dpanait-l2.corp.ad.wrs.com (128.224.125.182) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 19 Apr 2022 04:39:31 -0700
From:   Dragos-Marian Panait <dragos.panait@windriver.com>
To:     <stable@vger.kernel.org>
CC:     <dragos.panait@windriver.com>, <wg@grandegger.com>,
        <mkl@pengutronix.de>, <davem@davemloft.net>,
        <paskripkin@gmail.com>, <gregkh@linuxfoundation.org>,
        <hbh25y@gmail.com>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4.14 0/1] can: usb_8dev: backport fix for CVE-2022-28388
Date:   Tue, 19 Apr 2022 14:38:33 +0300
Message-ID: <20220419113834.3116927-1-dragos.panait@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [128.224.125.182]
X-ClientProxiedBy: ala-exchng01.corp.ad.wrs.com (147.11.82.252) To
 ala-exchng01.corp.ad.wrs.com (147.11.82.252)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The following commit is needed to fix CVE-2022-28388:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d3925ff6433f98992685a9679613a2cc97f3ce2

Hangyu Hua (1):
  can: usb_8dev: usb_8dev_start_xmit(): fix double dev_kfree_skb() in
    error path

 drivers/net/can/usb/usb_8dev.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)


base-commit: 74766a973637a02c32c04c1c6496e114e4855239
-- 
2.17.1

