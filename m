Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087C2C48BD1
	for <linux-can@archiver.kernel.org>; Fri, 11 Jun 2021 03:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB4B61374
	for <linux-can@archiver.kernel.org>; Fri, 11 Jun 2021 03:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhFKDcF (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 10 Jun 2021 23:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFKDcE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Jun 2021 23:32:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48F4C061574;
        Thu, 10 Jun 2021 20:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Message-ID:From:CC:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=J6yJVC8shbMIBqLlAVsvKyu6KL64sSYBjvb9KFGvJec=; b=FCYMElWUCposNo6q+a7wmUrZIP
        u+1pzdEUjOxUs9rPgWEQN7/wANnwfEIVK0CfDRVFAwu78J/pQovtpn7lHxkCJmb8Frpe6/qzs+K3S
        Wv7LUS6Jxgrg/RbEdUmWo2wQRlRBiVlUgq9JLblTZnIh77Plzcw2+vUUVN0Ub/XBkf/P3ZCxdh532
        om50RFZd6YABKDuMvkL+CG6ZvftqeiAGHYIT40Rjhx03BbdU263u71C+k4zm5g/jjzqW4kRmA+csQ
        SjXr4jh2AHHq5bIW3NQ2wH5WABMPm+XptyLjAPDLWrpM2bKc169Op9o7/uh+bL76fKX6dQY+1jWGe
        PrdB2EFg==;
Received: from [2603:3004:62:d400:6c3a:d576:fed:b48]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrXrX-005lDI-EP; Fri, 11 Jun 2021 03:29:46 +0000
Date:   Thu, 10 Jun 2021 20:29:37 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20210611014051.13081-1-13145886936@163.com>
References: <20210611014051.13081-1-13145886936@163.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: j1939: socket: correct a grammatical error
To:     13145886936@163.com, robin@protonic.nl, linux@rempel-privat.de,
        kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de,
        davem@davemloft.net, kuba@kernel.org
CC:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4251D856-85E6-489A-ACAF-8D62AB539CB0@infradead.org>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On June 10, 2021 6:40:51 PM PDT, 13145886936@163=2Ecom wrote:
>From: gushengxian <gushengxian@yulong=2Ecom>
>
>Correct a grammatical error=2E
>
>Signed-off-by: gushengxian <gushengxian@yulong=2Ecom>
>---
> net/can/j1939/socket=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/can/j1939/socket=2Ec b/net/can/j1939/socket=2Ec
>index 56aa66147d5a=2E=2E31ec493a0fca 100644
>--- a/net/can/j1939/socket=2Ec
>+++ b/net/can/j1939/socket=2Ec
>@@ -352,7 +352,7 @@ static void j1939_sk_sock_destruct(struct sock *sk)
> {
> 	struct j1939_sock *jsk =3D j1939_sk(sk);
>=20
>-	/* This function will be call by the generic networking code, when
>then
>+	/* This function will be called by the generic networking code, when
>then

Please drop "then"=2E

> 	 * the socket is ultimately closed (sk->sk_destruct)=2E
> 	 *
> 	 * The race between

Thanks=2E=20


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
