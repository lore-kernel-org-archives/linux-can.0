Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB0BC433F5
	for <linux-can@archiver.kernel.org>; Thu, 31 Mar 2022 15:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbiCaPxL (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 31 Mar 2022 11:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiCaPxK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 31 Mar 2022 11:53:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9F45E77B;
        Thu, 31 Mar 2022 08:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A79B5B82055;
        Thu, 31 Mar 2022 15:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BA8C340ED;
        Thu, 31 Mar 2022 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648741880;
        bh=VjXJBLMwghLVEjwBReGlUKvAERUTxcnnoPhCoxdImTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H1EZzLRstUvMkRQklM5lrmGg3Fe2qQ53db+YgEea0nySAi0jbukgdFihLcNwOSaSA
         JGvaJDkl7KHGzq+kL4D18KzrkUOYayrXqxKE1+8arNLn0FAN2b6zvf9muVNhT/K9XQ
         l9mz3bWIt1/4h01H85cvHXK8pr4sEbdIPDiEbN5YNtqxftGBJhvMUykFeZAq6oKirn
         suu1xVYc87+MhccdguGwrliVI1XaLJSRnlaGu75Fq0SadDothaIKHWqsNRRGpE81zM
         YQ/FeXNV4t7p6XJa3L18WTx6CfCdfCW/fNRr2k9pSZeI9Z2de9/u/wYphMz1XDFsAl
         TaC6t5CcjuxpQ==
Date:   Thu, 31 Mar 2022 08:51:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net 0/n] pull-request: can 2022-03-31
Message-ID: <20220331085118.3a118acb@kernel.org>
In-Reply-To: <20220331154549.wqtxsepujwwap5wg@pengutronix.de>
References: <20220331084634.869744-1-mkl@pengutronix.de>
        <20220331084223.5d145b23@kernel.org>
        <20220331154549.wqtxsepujwwap5wg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, 31 Mar 2022 17:45:49 +0200 Marc Kleine-Budde wrote:
> > I think patchwork did not like the "0/n" in the subject :(  
> 
> Should I resend (with a fixed subject)?

I should have clarified that :) It's okay - I had to build test
manually before sending the PR to Linus, anyway. Looks clean.
