Return-Path: <SRS0=bCgY=DS=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1F6C433DF
	for <linux-can@archiver.kernel.org>; Sun, 11 Oct 2020 15:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26D32222A
	for <linux-can@archiver.kernel.org>; Sun, 11 Oct 2020 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602431102;
	bh=m9czVHQzjCUW/4Q7vExkMd3mGcT9XtV+6UaDcGwHc/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iNoMba08BGGzPTjdy3md5zUDgRErYe+O5iXHFq639HxT1NHNYrdv77UErmSE8tkPQ
	 vyJUFYh/xjooB2mOK7L2MHIE0CG2oPYEOXG6mEVVQVRNjC2S6VmnNakb7RR4idPSFm
	 zAbcpJnMnyQWU7xFvtj3S6pk1w6sgLhFkXKaf99g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgJKPpB (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 11 Oct 2020 11:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgJKPpB (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 11 Oct 2020 11:45:01 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72DEC22227;
        Sun, 11 Oct 2020 15:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602431100;
        bh=m9czVHQzjCUW/4Q7vExkMd3mGcT9XtV+6UaDcGwHc/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gLOkU640NA0v+QwgA13KItw6y3T4tiDj8DqPsTEDe1pIl5Lzap9IQLkREhdcGAyD2
         irmMPYq621e7bWpSZa6/WtBqcfhzhN2rmdWUlo7f8QMSqaLbmcRn1xGEE4lkbrbwwW
         z3Wl2bXudFcvosialI5/TRv/glvkRE4mDnRW0JWE=
Date:   Sun, 11 Oct 2020 08:44:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     netdev@vger.kernel.org, mkl@pengutronix.de, davem@davemloft.net,
        linux-can@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] can-isotp: implement cleanups /
 improvements from review
Message-ID: <20201011084458.065be222@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201011092408.1766-1-socketcan@hartkopp.net>
References: <20201011092408.1766-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, 11 Oct 2020 11:24:07 +0200 Oliver Hartkopp wrote:
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index e6ff032b5426..22187669c5c9 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -79,6 +79,8 @@ MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Oliver Hartkopp <socketcan@hartkopp.net>");
>  MODULE_ALIAS("can-proto-6");
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

You need to move this before the includes:

net/can/isotp.c:82: warning: "pr_fmt" redefined
   82 | #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
      | 
In file included from ../include/linux/kernel.h:15,
                 from ../include/linux/list.h:9,
                 from ../include/linux/module.h:12,
                 from ../net/can/isotp.c:56:
include/linux/printk.h:297: note: this is the location of the previous definition
  297 | #define pr_fmt(fmt) fmt
      | 
net/can/isotp.c:82:9: warning: preprocessor token pr_fmt redefined
net/can/isotp.c: note: in included file (through ../include/linux/kernel.h, ../include/linux/list.h, ../include/linux/module.h):
include/linux/printk.h:297:9: this was the original definition
