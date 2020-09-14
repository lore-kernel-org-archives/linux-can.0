Return-Path: <SRS0=NQcb=CX=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABBCC43461
	for <linux-can@archiver.kernel.org>; Mon, 14 Sep 2020 08:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DD8221E8
	for <linux-can@archiver.kernel.org>; Mon, 14 Sep 2020 08:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="I4Wog418"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgINIuM (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 14 Sep 2020 04:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgINIuF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Sep 2020 04:50:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF637C061788
        for <linux-can@vger.kernel.org>; Mon, 14 Sep 2020 01:50:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so17738907wrm.9
        for <linux-can@vger.kernel.org>; Mon, 14 Sep 2020 01:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Z76iN5dKrEwSbBG4O9fZZwE0qBKlqiQkkuHppjnLYk=;
        b=I4Wog418XUa15zpIkSdZkM0NfYYZFUjtsBkNZ/nbw/Vs16KcGu6uLbhnVEfgX/mnzm
         ngoZJMAxMmv4IxCIuOMUpm5SE+/85fyREV/XPkPMYm3dgvKcgMlbLFzS1cmalD84aXon
         0TXQg1ex1N/stApONUWBM15sM/2NPvq71eKY6xdsdLIOTY788Au2Gs/V3qPU9YRM8d84
         OvxVM/yV1/P1pPkB0PxNuskRmkB3+Bny/JmF7paTyd8qfKe4q9Ok5Ga+DOb2XH4aYiLX
         /g2tNeUFNF7b42K/SJLaE2ns2DWLx5d1aTkMYM/GF5jy2FMHQL/c+23W2mJlcBqgRkYZ
         j4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2Z76iN5dKrEwSbBG4O9fZZwE0qBKlqiQkkuHppjnLYk=;
        b=Plr8GSCGLnjQtoURZZDdPOaiyEq7vhsOMKTMIFUBqWKrInHeJs64vK/hUNhi52A79L
         gI9Vdluy+Kzfmd7oca6F5YGDF28GiIwhXIMC5/ugk+v4x65cmRUvb3I6gMs4aWatfLaC
         kIY0Q8jUa4djL1ZqEFDDCBj76wJ/jj7y9gOcFU1TVQt9KZKNGT4xh3h5PFoIP7dvGV8r
         0iMZ+0pBLGrKzxiwmyMDnVZBGCA4G5C6g645yhciQQevFtn1SN2eihCW+lRVCV8oRimV
         XutRWpXJUFHU3cln5g/1SPdFuokHlPXrCvPwlB5JRvRD1SOFsZXPzZ1+/2XyuD5a/Rb5
         IIXw==
X-Gm-Message-State: AOAM532byRsrd4sFONEaJP8Rw4sf6Yrcdle7rTP4EsyOrln7IEtxiAr9
        kUmUtqZ5FmEm2rcemGQ3a1FIwg==
X-Google-Smtp-Source: ABdhPJziOaoLyqZezVgUbtyPAxvBCTpzyAkveYpRhKWSfKSVWKFznTfHP8u9zRb8BEszGSJh/ZyEYQ==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr14104094wrq.381.1600073403505;
        Mon, 14 Sep 2020 01:50:03 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j14sm20378080wrr.66.2020.09.14.01.50.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 01:50:02 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 0/3] can: xilinx_can: Some minor changes
Date:   Mon, 14 Sep 2020 10:49:55 +0200
Message-Id: <cover.1600073396.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

recently some small patches come to our internal tree. We started to use
coverity which found 2 issues (last two patches) which is simply to fix.

Thanks,
Michal


Srinivas Neeli (3):
  can: xilinx_can: Limit CANFD brp to 2
  can: xilinx_can: Check return value of set_reset_mode
  can: xilinx_can: Fix incorrect variable and initialize with a default
    value

 drivers/net/can/xilinx_can.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.28.0

