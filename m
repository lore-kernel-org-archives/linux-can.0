Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B23CCA481
	for <linux-can@archiver.kernel.org>; Sat,  9 Jul 2022 10:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiGIKH6 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 9 Jul 2022 06:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiGIKHn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 Jul 2022 06:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F494C60F;
        Sat,  9 Jul 2022 03:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE0B360E75;
        Sat,  9 Jul 2022 10:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E25C341E6;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=dlmv/1uA+9jV5m0Yh6vFjW59sSYEsGHcbCnXJtFK6OI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDbmzQrK/8oCiAEnfmWeOMIgHVkZMnyTxAmhKJMa4t7nVTyVybKnSkQpoR6TIUwfH
         X4F/tO0GdftX0anPQxSEHyn3Svl7FSxebQpiwk8E4/m4/2kVPtY/QTuPDsM+ZNL436
         bLbagUGf18U94eiyKx5g5/LnChqA9ySB0gS5n/MaEvT26LpA0sJ+ep9oXy6/eB00Gq
         pYGjBDJqK49S2I8GCbRAgo5tAY4W+XIhi/0fbvn1B4IS9oxVXlZXNS5LRveQvmkDca
         qdYxxu3LP2AK873DgNR9rbzC7sdmY3lJz958rIB5xdauejgp5k+n6CwBXNBJ+ml940
         rB+n16OAjHN/w==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EGT-D2;
        Sat, 09 Jul 2022 11:07:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Max Staudt <max@enpas.org>, Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v3 01/21] docs: networking: update netdevices.rst reference
Date:   Sat,  9 Jul 2022 11:07:14 +0100
Message-Id: <a91cc9d0fe894e5740b4b8768b9d9f393a46e79d.1657360984.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Changeset 482a4360c56a ("docs: networking: convert netdevices.txt to ReST")
renamed: Documentation/networking/netdevices.txt
to: Documentation/networking/netdevices.rst.

Update its cross-reference accordingly.

Fixes: 482a4360c56a ("docs: networking: convert netdevices.txt to ReST")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

 drivers/net/can/can327.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 5da7778d92dc..925e880bf570 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -827,7 +827,7 @@ static netdev_tx_t can327_netdev_start_xmit(struct sk_buff *skb,
 	netif_stop_queue(dev);
 
 	/* BHs are already disabled, so no spin_lock_bh().
-	 * See Documentation/networking/netdevices.txt
+	 * See Documentation/networking/netdevices.rst
 	 */
 	spin_lock(&elm->lock);
 	can327_send_frame(elm, frame);
-- 
2.36.1

