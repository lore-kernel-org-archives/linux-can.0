Return-Path: <SRS0=YP9/=EK=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADD9C2D0A3
	for <linux-can@archiver.kernel.org>; Wed,  4 Nov 2020 18:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F241D206C1
	for <linux-can@archiver.kernel.org>; Wed,  4 Nov 2020 18:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604515431;
	bh=m20eoaOMo1ubqQ0jnlkDeXkxvSLTxtTfttk+YX60QgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SqE1cSD58yWnsdWyfAFsvz3z0Sy0GjWneYMTdsAD4VycTXPSonsq0iVdHvEcqZs4/
	 07iFGFxJh7CAdRNeYxmUqQxjDUVxsgw8la3wtmczDqXYI3Hv9Vt8omngyqGlOfpnwV
	 aoZ4MaQzA+DBRw+0k5bNiBwiT9G3H3IGdzr9Q0Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgKDSno (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 4 Nov 2020 13:43:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730812AbgKDSno (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 4 Nov 2020 13:43:44 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B50F206C1;
        Wed,  4 Nov 2020 18:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604515424;
        bh=m20eoaOMo1ubqQ0jnlkDeXkxvSLTxtTfttk+YX60QgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G7AmRI6lbMhJPYZGwW8Dz2xNu0XDnabbji7VDCaQuFbBmBFE/9XK4ri9EC5l38yN9
         DI0vqNWjggKDYggjzS8IiK7raV8T3o5FrezOh7qLS4BwrPfQ96Ev45j/jdBgzZesVF
         seuZ3aVOzaPSsIaT4j8kAISuRfm+8AE/IjY4mb5E=
Date:   Wed, 4 Nov 2020 10:43:42 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: pull-request: can 2020-11-03
Message-ID: <20201104104342.0dc17023@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201103220636.972106-1-mkl@pengutronix.de>
References: <20201103220636.972106-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue,  3 Nov 2020 23:06:09 +0100 Marc Kleine-Budde wrote:
> Hello Jakub, hello David,
> 
> here's a pull request for net/master consisting of 27 patches for net/master.

Pulled, thanks!
