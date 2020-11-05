Return-Path: <SRS0=la7A=EL=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8C2C388F7
	for <linux-can@archiver.kernel.org>; Thu,  5 Nov 2020 21:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A446D20728
	for <linux-can@archiver.kernel.org>; Thu,  5 Nov 2020 21:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbgKEVv6 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:51:58 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:51682 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEVv6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Nov 2020 16:51:58 -0500
Date:   Thu, 05 Nov 2020 21:51:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acoro.eu;
        s=protonmail; t=1604613113;
        bh=ow5z9LuO/vtoOqNhTBdxDxldwi2gz5ijnd8ZUFXvNf8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ESm9uiZvZprWjBldoOi3XyGy6TevpBAkDfIj0H4E+j96rNL1HLeUBBvmpex11aIEJ
         oHS0IOCA278QLGwkiqbphgjHadX1kaHmWLzuWbZhXri+5jgX85IEVQNo0+MC8L/epS
         d1m75EJIuzAiIwStQ57SKcTgf194aA0jYQzcd+lESKVuCRuhhBKhug9VT+QRjpJM5H
         HWCPsXXhWCxMhVbCmMZwGcBtMWcvu7R5MmaszoZjZxOcX2y9esJ4bWQRLvQTz03Pmc
         3f0nd9nFMZ89Z/wdZN4gQ1gYanhWF9xQLSvWo3c38VJ7/Btfxj8dvXBNjHgjfulWa6
         WQeu8RnisNoYw==
To:     linux-can@vger.kernel.org
From:   Alejandro <alejandro@acoro.eu>
Cc:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        kuba@kernel.org
Reply-To: Alejandro <alejandro@acoro.eu>
Subject: Re: [PATCH] can: dev: can_restart(): post buffer from the right context
Message-ID: <4e84162b-fb31-3a73-fa9a-9438b4bd5234@acoro.eu>
In-Reply-To: <bd6d51f4-4a18-e557-46d1-00d3539d163e@acoro.eu>
References: <bd6d51f4-4a18-e557-46d1-00d3539d163e@acoro.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Alejandro Concepcion Rodriguez<alejandro@acoro.eu>

netif_rx() is meant to be called from interrupt contexts. can_restart()
may be called by can_restart_work(), which is called from a worqueue, so
it may run in process context. Use netif_rx_any_context() which invokes
the correct code path depending on context.

Co-developed-by: Loris Fauster<loris.fauster@ttcontrol.com>
Signed-off-by: Loris Fauster<loris.fauster@ttcontrol.com>
Signed-off-by: Alejandro Concepcion Rodriguez<alejandro@acoro.eu>
---
  drivers/net/can/dev.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index b70ded3760f2..83114f8e8c24 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -584,7 +584,7 @@ static void can_restart(struct net_device *dev)
 =20
  =09cf->can_id |=3D CAN_ERR_RESTARTED;
 =20
-=09netif_rx(skb);
+=09netif_rx_any_context(skb);
 =20
  =09stats->rx_packets++;
  =09stats->rx_bytes +=3D cf->can_dlc;
--=20
2.17.1


