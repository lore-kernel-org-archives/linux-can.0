Return-Path: <SRS0=bCgY=DS=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C30C433E7
	for <linux-can@archiver.kernel.org>; Sun, 11 Oct 2020 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E16222227
	for <linux-can@archiver.kernel.org>; Sun, 11 Oct 2020 15:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602431155;
	bh=xe3fq0hSfzSGKm8Ry9d7SS9pzBcCbLI0gqyC21aVx0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IZDAK7wLBSuOBHKIh7tyxzWmuVa1x7ZvXDJkGnPs4xzbUcj5RIGNgZ+w7w5fhoRPw
	 JYkKUVNIec2ks7MvcLH8O7KySi8JxkMIXshMjVg7+TTJ+eIggL40ghvQj57Dfy3Sq5
	 aRM7CHdQGvPdNBYWhBhTjQTRy1/E0VIBsX7sRpYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgJKPps (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 11 Oct 2020 11:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgJKPps (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 11 Oct 2020 11:45:48 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B81762222A;
        Sun, 11 Oct 2020 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602431148;
        bh=xe3fq0hSfzSGKm8Ry9d7SS9pzBcCbLI0gqyC21aVx0U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hZFWZCH/WWSKvgNn+Si2ccnvoiUKWI5qxzd5PbwWpfVk/r4/L2H+rXS+HJ9b9Sfdy
         tCCFrwHXHRNdLxNAyfUyt4V0RvB6pBKqMSEnB2RLxkbSi995NdJlrkTAHc27dHS5eC
         v7WDC8DjTJX6NG7roe7/FybuDAJdR1wq6aexJz10=
Date:   Sun, 11 Oct 2020 08:45:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     netdev@vger.kernel.org, mkl@pengutronix.de, davem@davemloft.net,
        linux-can@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] can-isotp: implement cleanups /
 improvements from review
Message-ID: <20201011084546.2ee6117b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201011092408.1766-1-socketcan@hartkopp.net>
References: <20201011092408.1766-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, 11 Oct 2020 11:24:07 +0200 Oliver Hartkopp wrote:
> @@ -769,7 +771,7 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
>  
>  isotp_tx_burst:
>  		skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv),
> -				gfp_any());
> +				GFP_KERNEL);

hrtimer will need GFP_ATOMIC
