Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEFAC433EF
	for <linux-can@archiver.kernel.org>; Mon, 27 Jun 2022 13:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiF0N5A (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 27 Jun 2022 09:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiF0N5A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Jun 2022 09:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618FB492;
        Mon, 27 Jun 2022 06:56:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A6860C86;
        Mon, 27 Jun 2022 13:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D34C3411D;
        Mon, 27 Jun 2022 13:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656338218;
        bh=CJOgDl3yKXDiC5HaH/8sINEC7qK1aC5cCyVmQXJOweg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1PNpA4zHA+xlOOo9au8hbyIJjE9gCOhR+pWBUrTF4+nbiPW01BtXNjJyV5MWDhcNp
         g/HlTtbvDt43T8Zi2Z3zAJGjHQJLV1ZVV5TE8rtFcguxN4PuIUVSMVB8jyig1GQEEZ
         kp3HAGqMh6mKHpon/1Hr9GrEOHF7C0RBZu96RXu8=
Date:   Mon, 27 Jun 2022 15:56:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Staudt <max@enpas.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Add N_CAN327 line discipline ID for ELM327 based
 CAN driver
Message-ID: <Yrm3J6C3bkanjfyq@kroah.com>
References: <20220618180134.9890-1-max@enpas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618180134.9890-1-max@enpas.org>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Jun 18, 2022 at 08:01:34PM +0200, Max Staudt wrote:
> The actual driver will be added via the CAN tree.
> 
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
> Dear TTY maintainers,
> 
> The CAN people (well, a subset) have spoken and decided to accept the
> can327 driver (formerly elmcan), an ldisc based CAN driver allowing CAN
> experiments with commodity hardware.
> 
> After several rounds of reviews, the final condition is for you to
> accept this patch for N_CAN327, so here goes - please add this new line
> discipline to the list, and once this filters through, the driver itself
> will be added to can-next :)

Great, will go to Linus before 5.19-final is out.

thanks,

greg k-h
