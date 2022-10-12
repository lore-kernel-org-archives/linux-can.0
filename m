Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737C6C4167D
	for <linux-can@archiver.kernel.org>; Wed, 12 Oct 2022 06:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJLG1H (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 12 Oct 2022 02:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJLG1G (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 12 Oct 2022 02:27:06 -0400
Received: from mxd2.seznam.cz (mxd2.seznam.cz [IPv6:2a02:598:2::210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB73A99FB;
        Tue, 11 Oct 2022 23:27:05 -0700 (PDT)
Received: from email.seznam.cz
        by email-smtpc1b.ng.seznam.cz (email-smtpc1b.ng.seznam.cz [10.23.13.15])
        id 555b47cbb1f794f55486e6a5;
        Wed, 12 Oct 2022 08:26:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1665555991; bh=zaMVf81+peIjjQCoUMAqrj52UKkM4T1hKf0Aa0rWato=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=JEIt4zgucI7V/jJTXwTKBz2QkFGliVO/DvRIp51nLOQqNpYcgodIX+69mFnuI/3dI
         XIB8jFTUTrJ3X0mA0ARVZhIMrY0f19t+fk8hgaKv2aYdVwNOS6xS0PLBEwDNtMdec5
         JMtyR3sUpxQxS8B+NqL5tSDPgoJBFJjTlZuetr0I=
Received: from localhost.localdomain (2a02:8308:900d:2400:bba2:4592:a1de:fd80 [2a02:8308:900d:2400:bba2:4592:a1de:fd80])
        by email-relay16.ko.seznam.cz (Seznam SMTPD 1.3.137) with ESMTP;
        Wed, 12 Oct 2022 08:26:29 +0200 (CEST)  
From:   Matej Vasilevski <matej.vasilevski@seznam.cz>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matej Vasilevski <matej.vasilevski@seznam.cz>
Subject: [PATCH v5 4/4] can: ctucanfd: remove __maybe_unused from suspend/resume callbacks
Date:   Wed, 12 Oct 2022 08:25:58 +0200
Message-Id: <20221012062558.732930-5-matej.vasilevski@seznam.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221012062558.732930-1-matej.vasilevski@seznam.cz>
References: <20221012062558.732930-1-matej.vasilevski@seznam.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Those two functions are always used, because they are exported symbols.

Spotted-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Matej Vasilevski <matej.vasilevski@seznam.cz>
---
 drivers/net/can/ctucanfd/ctucanfd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd.h b/drivers/net/can/ctucanfd/ctucanfd.h
index cf4d8cc5349e..756b46076f98 100644
--- a/drivers/net/can/ctucanfd/ctucanfd.h
+++ b/drivers/net/can/ctucanfd/ctucanfd.h
@@ -90,8 +90,8 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr,
 						struct net_device *ndev));
 void ctucan_remove_common(struct ctucan_priv *priv);
 
-int ctucan_suspend(struct device *dev) __maybe_unused;
-int ctucan_resume(struct device *dev) __maybe_unused;
+int ctucan_suspend(struct device *dev);
+int ctucan_resume(struct device *dev);
 int ctucan_runtime_resume(struct device *dev);
 int ctucan_runtime_suspend(struct device *dev);
 
-- 
2.25.1

