Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E629AC48BDF
	for <linux-can@archiver.kernel.org>; Fri, 18 Jun 2021 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64C560698
	for <linux-can@archiver.kernel.org>; Fri, 18 Jun 2021 17:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhFRRjM (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 18 Jun 2021 13:39:12 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:15078 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhFRRjM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 13:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624037821;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=WvA82nkklBw0SViN504lD6tM11gS4L/jSSq1mmQNij4=;
    b=bgnNplGdqnLJfnbqqDymdLetRp+sYmHj8isgV1kIu6QPZC21AvGYjsIK/OAWZDp0uV
    IUT6195G9tovFzSCdXj9v3UQXXTWSFQb83W8S6zdhBAx3qQkMiucI4mt0O/L6wcGk+nv
    Yfl5FkzTHbc23HY9DmdWI1AYtKclH/xkZKpqOPiUgyGQCIc8Mibhitnmx2DMe976hB1n
    d4tSC8qpN3YqOKE7/kxZm1eZORPUrVEyk5VBTRqtzEe3sMPr3/fe8cCvOlS8acW2ZPYe
    nxlFG7GR7tpvdBkd9iem4UtXUuLdnX5cj4Uz9bfkzh+/kpDssUT8xiaY+qtC/bGVoLAB
    L4xA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejudJywjsS7yVw=="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id N0b2dax5IHb12us
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 18 Jun 2021 19:37:01 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: gw: syncronize rcu operations before removing gw job entry
Date:   Fri, 18 Jun 2021 19:36:45 +0200
Message-Id: <20210618173645.2238-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

can_can_gw_rcv() is called under RCU protection, so after calling
can_rx_unregister, we may call synchronize_rcu in order to wait for any
RCU read-side critical sections to finish before removing the kmem_cache
entry with the referenced gw job entry.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/gw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/can/gw.c b/net/can/gw.c
index ba4124805602..d8861e862f15 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -594,10 +594,11 @@ static int cgw_notifier(struct notifier_block *nb,
 
 		hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
 			if (gwj->src.dev == dev || gwj->dst.dev == dev) {
 				hlist_del(&gwj->list);
 				cgw_unregister_filter(net, gwj);
+				synchronize_rcu();
 				kmem_cache_free(cgw_cache, gwj);
 			}
 		}
 	}
 
@@ -1152,10 +1153,11 @@ static void cgw_remove_all_jobs(struct net *net)
 	ASSERT_RTNL();
 
 	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
 		hlist_del(&gwj->list);
 		cgw_unregister_filter(net, gwj);
+		synchronize_rcu();
 		kmem_cache_free(cgw_cache, gwj);
 	}
 }
 
 static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -1220,10 +1222,11 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw)))
 			continue;
 
 		hlist_del(&gwj->list);
 		cgw_unregister_filter(net, gwj);
+		synchronize_rcu();
 		kmem_cache_free(cgw_cache, gwj);
 		err = 0;
 		break;
 	}
 
-- 
2.30.2

