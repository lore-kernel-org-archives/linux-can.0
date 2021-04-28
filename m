Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9F8C433ED
	for <linux-can@archiver.kernel.org>; Wed, 28 Apr 2021 07:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D157C61077
	for <linux-can@archiver.kernel.org>; Wed, 28 Apr 2021 07:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhD1HwI (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 28 Apr 2021 03:52:08 -0400
Received: from lissvexedge01.liebherr.com ([193.27.220.105]:54631 "EHLO
        lissvexedge01.liebherr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhD1HwI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Apr 2021 03:52:08 -0400
DKIM-Signature: v=1; c=relaxed/relaxed; d=liebherr.com; s=key1e; 
 t=1619596279; bh=24Y7gZrVh7NPumha42g0+2TOIwk/K1NgkikjhxkTFLE=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 tqLlWfFMwsdSZ6Bot/UmuOf6EkXpPXR2m+N97ITGz69ci6LIUQEbFOcNP/qfUYAJD68mSaviu+vZBUtNtKCtAA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=liebherr.com; s=key1; t=1619596279; 
 bh=24Y7gZrVh7NPumha42g0+2TOIwk/K1NgkikjhxkTFLE=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 XQXFv5lZ0MCJNu/Mul8NDzoGER8CnL90RmzXvFdp2OadJIYIT/GKcFUIrFqOWzr0kx7fDroxewT7MVRcC+q0dCssJ2LS+rk4Op1f9xTvlgcxemJq8bIck3i4xwH6HssIb/dZUnaqi6YC1wpDgk3EoLX0mamo1zlKJ2VvabO8fnI=
From:   "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: incorrect return values to user space
Thread-Topic: incorrect return values to user space
Thread-Index: Adc8AuUqdrJSvJNMRRqkv8AsYpUJEA==
Date:   Wed, 28 Apr 2021 07:51:03 +0000
Message-ID: <bd2e0e78d972433d88eade410618ad7f@liebherr.com>
Accept-Language: de-DE, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

It seems that when we send a long message over the ISO-TP (ISO-15765-2, mod=
ule can-isotp), the write() function always returns error code 0.
However, if no FlowControl frame is received from the peer, the documentati=
on (https://elixir.bootlin.com/linux/latest/source/net/can/isotp.c#L10) say=
s it should return ECOMM error.

Below is a pull request I made on the can-isotp module which was integrated=
 to the mainline kernel, however it doesn't seems to be the right place to =
fix it.
Could you please let me know on which repository this fix should be request=
ed/committed, in order to improve it?

https://github.com/hartkopp/can-isotp/pull/43

Thank you in advance for your feedback,

Guillaume


