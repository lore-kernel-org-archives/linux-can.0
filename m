Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162BECCA47E
	for <linux-can@archiver.kernel.org>; Tue, 14 Jun 2022 12:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357135AbiFNMbL (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 14 Jun 2022 08:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbiFNM2i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Jun 2022 08:28:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89483CA7C
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 05:28:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z7so11366638edm.13
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=El3W9x0OB1VE70B0Lt3SBVyO+pC/HDeoL5aPqYtLRdg=;
        b=BiAOyZ/XYfnLieytaiCrXuW21pBo0n2NoPpY7GM5pLKNkdZ6mhfHALcly1gSTnfEe4
         qI+fC3AE55af0rHC7Zuc7avKy26528oBP6WLx0X1+3NsDEO9wLlCCMNx981e7baQ+V2m
         AgWjAXSvqm6SDChs9xqMjy0WTm6kXzNF1eumE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=El3W9x0OB1VE70B0Lt3SBVyO+pC/HDeoL5aPqYtLRdg=;
        b=cRYZZrAkCw8XfgJzxE5+ypgZyJ4/lQYc2eekkmI7u9RwRqyaAvoK37mY3Qr9BUuSmk
         6+B9XE3vEXMt4ZrW7Mvyhz5k5roQPji/K3UYa8F3Xy6NvlZcOP+P8CRebPY4TUeOGhcL
         rpsEbP+U/hY5eKpcQBddAfL/iXGQNcZZQevIQvwbPJmX6Vy/rTbMACR+Nx+fAeasz/3e
         aYvIT0eroPkPZ1oH65CHcAj9dsjrIP363KSlWn3zMkwrignksAt0gv9h4tci4nYALv5P
         Bzqo3c/m3phb+5LNHfvrKrhIDRvXKUGQUVVFQT7xfrKw9Mq38Wqejhcv+S8kZO6kNKu2
         Rxeg==
X-Gm-Message-State: AOAM5332gJSxYlA/J1CDmpX/FsMkzSaN8KGmNfVzDcC92wP0uwQCxMpJ
        VHCXB+GsCQQKwvTuyJ5uSFkWaOOrMiSd1Q==
X-Google-Smtp-Source: ABdhPJxY51V2+bRO3eItM3jvTt+mAR9YkliMJJzg3a6IzB/EvnBrA4haRAhoDvTT+4auNuo5PaeGfQ==
X-Received: by 2002:a05:6402:100c:b0:42d:f407:b050 with SMTP id c12-20020a056402100c00b0042df407b050mr5652088edu.39.1655209708968;
        Tue, 14 Jun 2022 05:28:28 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006f3ef214e2csm5087043ejp.146.2022.06.14.05.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 05:28:28 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4 02/12] can: slcan: use netdev helpers to print out messages
Date:   Tue, 14 Jun 2022 14:28:11 +0200
Message-Id: <20220614122821.3646071-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220614122821.3646071-1-dario.binacchi@amarulasolutions.com>
References: <20220614122821.3646071-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Replace printk() calls with corresponding netdev helpers.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/net/can/slcan.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index b37d35c2a23a..6162a9c21672 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -365,7 +365,7 @@ static netdev_tx_t slc_xmit(struct sk_buff *skb, struct net_device *dev)
 	spin_lock(&sl->lock);
 	if (!netif_running(dev))  {
 		spin_unlock(&sl->lock);
-		printk(KERN_WARNING "%s: xmit: iface is down\n", dev->name);
+		netdev_warn(dev, "xmit: iface is down\n");
 		goto out;
 	}
 	if (sl->tty == NULL) {
@@ -776,8 +776,7 @@ static void __exit slcan_exit(void)
 
 		sl = netdev_priv(dev);
 		if (sl->tty) {
-			printk(KERN_ERR "%s: tty discipline still running\n",
-			       dev->name);
+			netdev_err(dev, "tty discipline still running\n");
 		}
 
 		unregister_netdev(dev);
-- 
2.32.0

